import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mymovie/blocs/basic_bloc_state.dart';
import 'package:mymovie/blocs/movies/movie_bloc.dart';
import 'package:mymovie/data/datasources/local/movie_local_data_source.dart';
import 'package:mymovie/data/datasources/remote/movie_remote_data_source.dart';
import 'package:mymovie/data/models/movie_list_model.dart';
import 'package:mymovie/data/movie_repository_impl.dart';
import 'package:mymovie/di/di_config.dart';
import 'package:mymovie/resources/constants.dart';
import 'package:mymovie/resources/images.dart';
import 'package:mymovie/ui/screens/movie_details.dart';
import 'package:mymovie/ui/screens/search.dart';
import 'package:mymovie/ui/widgets/basic_app_error_widget.dart';
import 'package:mymovie/ui/widgets/bottom_nav.dart';

import '../../injection_container.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  HomeState({Key? key});
  late MovieBloc movieBloc;
  List<Movie> movies = [];
  @override
  void initState() {
    movieBloc = sl<MovieBloc>();
    movieBloc.add(GetUpcomingMovies(page: 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Watch",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      Container(
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        width: 20,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Search(
                                            movies: movies,
                                          )));
                            },
                            child: SvgPicture.asset(
                              Images.search,
                              width: 17,
                              height: 17,
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
              Expanded(
                child: BlocProvider<MovieBloc>(
                  create: (_) => movieBloc,
                  child: BlocBuilder<MovieBloc, MovieState>(
                    builder: (context, state) {
                      final blocState = state.state;
                      if (blocState is BlocLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (blocState is BlocSuccess) {
                        movies.clear();
                        final results =
                            (blocState.response as MovieListModel).results;
                        if (results != null) {
                          movies.addAll((results));
                        }
                        return MovieListWidget(
                          movieListModel: blocState.response,
                        );
                      } else if (blocState is BlocError) {
                        return BasicAppErrorWidget(
                          message: errorMessage,
                        );
                      } else if (blocState is BlocFail) {
                        return BasicAppErrorWidget(
                          message: blocState.message,
                        );
                      } else {
                        return BasicAppErrorWidget(
                          message: unexpectedError,
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          ),
          const Align(
              alignment: Alignment.bottomCenter, child: BottomNavigation())
        ],
      )),
    );
  }
}

class MovieListWidget extends StatefulWidget {
  final MovieListModel movieListModel;

  MovieListWidget({required this.movieListModel});

  @override
  _MovieListWidgetState createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  ScrollController scrollController = ScrollController();
  MovieBloc movieBloc = getIt<MovieBloc>();
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
