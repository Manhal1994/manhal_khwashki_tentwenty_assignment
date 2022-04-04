import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymovie/blocs/basic_bloc_state.dart';
import 'package:mymovie/blocs/movies/movie_bloc.dart';
import 'package:mymovie/data/models/movie_list_model.dart';
import 'package:mymovie/resources/constants.dart';
import 'package:mymovie/resources/images.dart';
import 'package:mymovie/ui/screens/search.dart';
import 'package:mymovie/ui/widgets/basic_app_error_widget.dart';
import 'package:mymovie/ui/widgets/bottom_nav.dart';
import 'package:mymovie/ui/widgets/movie_list_widget.dart';

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
                        kwatch,
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
