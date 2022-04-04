import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymovie/blocs/basic_bloc_state.dart';
import 'package:mymovie/blocs/movies/movie_bloc.dart';
import 'package:mymovie/data/models/movie_list_model.dart';
import 'package:mymovie/resources/resources.dart';
import 'package:mymovie/ui/screens/movie_details.dart';

import '../../injection_container.dart';

class MovieListWidget extends StatefulWidget {
  final MovieListModel movieListModel;

  MovieListWidget({required this.movieListModel});

  @override
  _MovieListWidgetState createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  ScrollController scrollController = ScrollController();
  MovieBloc movieBloc = sl<MovieBloc>();
  int page = 1;
  var isLoading = false;
  _MovieListWidgetState();
  callBack() {
    if ((scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) &&
        (page < widget.movieListModel.totalPages!)) {
      if (!isLoading) {
        page += 1;
        loadMoreMovies(page);
      }
    }
  }

  loadMoreMovies(int page) {
    movieBloc.add(GetUpcomingMovies(page: page));
  }

  @override
  void initState() {
    scrollController.addListener(callBack);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieBloc>(
      create: (_) => movieBloc,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: widget.movieListModel.results != null
                    ? widget.movieListModel.results!.length
                    : 0,
                shrinkWrap: true,
                controller: scrollController,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  final movie = widget.movieListModel.results![index];
                  final imagePath =
                      movie.backdropPath ?? movie.posterPath.toString();

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MovieDetails(
                          movie: movie,
                        );
                      }));
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Stack(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            height: 183,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: CachedNetworkImage(
                                imageUrl: baseImageUrl + imagePath,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 20,
                          child: Text(
                            movie.title ?? "",
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ]),
                    ),
                  );
                },
              ),
            ),
          ),
          BlocListener<MovieBloc, MovieState>(
            listener: (context, state) {
              final blocState = state.state;

              if (blocState is BlocSuccess<MovieListModel>) {
                setState(() {
                  widget.movieListModel.results!
                      .addAll(blocState.response.results!);
                });
              }
            },
            child:
                BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
              return state.state is BlocLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container();
            }),
          )
        ],
      ),
    );
  }
}
