import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mymovie/blocs/geners/geners_bloc.dart';
import 'package:mymovie/data/models/general_model.dart';
import 'package:mymovie/data/models/movie_list_model.dart' as MovieModel;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymovie/blocs/basic_bloc_state.dart';
import 'package:mymovie/blocs/search/search_bloc.dart';
import 'package:mymovie/data/models/search_model.dart';
import 'package:mymovie/resources/resources.dart';
import 'package:mymovie/ui/screens/movie_details.dart';
import 'package:mymovie/ui/widgets/basic_widget.dart';
import 'package:mymovie/ui/widgets/top_result_widget.dart';

import '../../injection_container.dart';
import '../ui_helpers.dart';

class Search extends StatefulWidget {
  final List<MovieModel.Movie> movies;
  Search({Key? key, required this.movies}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchEditingController = TextEditingController();
  bool searchSubmited = false;
  bool userTyped = false;
  bool loadingGeners = false;
  late SearchBloc searchBloc;
  late GenersBloc genersBloc;
  int totalResults = 0;
  List<Genres> geners = [];
  @override
  void initState() {
    searchBloc = sl<SearchBloc>();
    genersBloc = sl<GenersBloc>();
    genersBloc.add(GetGeners());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasicWidget(
        child: BlocProvider(
      create: (context) => genersBloc,
      child: BlocProvider<SearchBloc>(
        create: (context) => searchBloc,
        child: Column(
          children: [
            !searchSubmited
                ? Container(
                    height: 52,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.only(
                        top: 20, right: 10, left: 10, bottom: 10),
                    decoration: BoxDecoration(
                        color: AppColor.greyBg,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(width: 1, color: AppColor.greyEF)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(right: 13),
                            child: SvgPicture.asset(Images.search)),
                        Expanded(
                          child: TextField(
                            controller: searchEditingController,
                            onChanged: (value) {
                              if (!userTyped) {
                                setState(() {
                                  userTyped = true;
                                });
                              }
                              searchBloc
                                  .add(GetSeachResults(query: value, page: 1));
                            },
                            onSubmitted: (value) {
                              searchSubmited = true;
                              searchBloc
                                  .add(GetSeachResults(query: value, page: 1));
                            },
                            decoration: const InputDecoration.collapsed(
                                fillColor: AppColor.greyBg,
                                filled: true,
                                hintText: KsearchHint,
                                hintStyle: TextStyle(
                                    color: AppColor.hintTextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400)),
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColor.searchTextColor),
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                searchEditingController.clear();
                              });
                            },
                            child: SvgPicture.asset(Images.cancel))
                      ],
                    ),
                  )
                : Container(
                    height: 52,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.only(
                        top: 20, right: 10, left: 10, bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                searchSubmited = false;
                              });
                            },
                            child: SizedBox(
                              width: 50,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: SvgPicture.asset(
                                  Images.arrowBack,
                                  width: 10,
                                  color: AppColor.searchTextColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "$totalResults Results Found",
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColor.searchTextColor),
                        )
                      ],
                    ),
                  ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(color: AppColor.greyEF),
                child: (loadingGeners && userTyped)
                    ? BlocListener<SearchBloc, SearchState>(
                        listener: (context, state) {
                          final blocState = state.state;
                          if (blocState is BlocSuccess<SearchModel?>) {
                            if (searchSubmited && loadingGeners) {
                              setState(() {
                                searchSubmited = true;
                                totalResults =
                                    blocState.response!.results!.length;
                              });
                            } else {}
                          }
                        },
                        child: BlocBuilder<SearchBloc, SearchState>(
                            builder: (context, state) {
                          final blocState = state.state;
                          if (blocState is BlocSuccess<SearchModel?>) {
                            return (blocState.response != null &&
                                    blocState.response!.results!.isNotEmpty)
                                ? Column(
                                    children: [
                                      searchSubmited
                                          ? Container()
                                          : topResultsLabelWidget(),
                                      Expanded(
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: blocState
                                                .response!.results!.length,
                                            itemBuilder: (context, index) {
                                              final movie = blocState
                                                  .response!.results![index];
                                              return GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return MovieDetails(
                                                        movie: MovieModel.Movie(
                                                            id: movie.id!,
                                                            genreIds:
                                                                movie.genreIds,
                                                            overview:
                                                                movie.overview,
                                                            title: movie.title,
                                                            releaseDate: movie
                                                                .releaseDate,
                                                            posterPath: movie
                                                                .posterPath));
                                                  }));
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: SizedBox(
                                                              width: 130,
                                                              height: 100,
                                                              child: movie.posterPath !=
                                                                      null
                                                                  ? Image
                                                                      .network(
                                                                      baseImageUrl +
                                                                          movie
                                                                              .posterPath!,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    )
                                                                  : Container(),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(24),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width: 106,
                                                                  child: Text(
                                                                    movie.title
                                                                        .toString(),
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            16,
                                                                        color: AppColor
                                                                            .searchTextColor),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 4),
                                                                Text(
                                                                  mapGenersIdsToText(
                                                                      geners,
                                                                      movie.genreIds![
                                                                          0]),
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          12,
                                                                      color: AppColor
                                                                          .greyDB),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SvgPicture.asset(
                                                        Images.moreH,
                                                        width: 20,
                                                        height: 4,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    ],
                                  )
                                : const Center(
                                    child: Text(KnoDataFound),
                                  );
                          } else if (blocState is BlocLoading) {
                            return const SizedBox(
                              width: 20,
                              height: 20,
                              child: Center(child: CircularProgressIndicator()),
                            );
                          } else if (blocState is BlocInitial) {
                            return Container();
                          } else {
                            return const Center(
                              child: Text(Kerror),
                            );
                          }
                        }),
                      )
                    : BlocListener<GenersBloc, GenersState>(
                        listener: (context, state) {
                        final blocState = state.state;
                        if (blocState is BlocSuccess<GenralModel?>) {
                          setState(() {
                            loadingGeners = true;
                            geners = blocState.response!.genres!;
                          });
                        }
                      }, child: BlocBuilder<GenersBloc, GenersState>(
                            builder: (context, state) {
                        final blocState = state.state;
                        if (blocState is BlocLoading) {
                          return Container(
                            color: AppColor.greyEF,
                            width: double.infinity,
                            height: double.infinity,
                            child: const SizedBox(
                              width: 20,
                              height: 20,
                              child: Center(child: CircularProgressIndicator()),
                            ),
                          );
                        } else if (blocState is BlocSuccess<GenralModel?>) {
                          return Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: GridView.builder(
                                shrinkWrap: true,
                                itemCount: widget.movies.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemBuilder: (context, index) {
                                  final movie = widget.movies[index];
                                  return Container(
                                    margin: const EdgeInsets.all(4),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Stack(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl: baseImageUrl +
                                                    movie.posterPath!,
                                                fit: BoxFit.fill,
                                                width: double.infinity,
                                                height: double.infinity,
                                              ),
                                              Positioned(
                                                  bottom: 10,
                                                  left: 10,
                                                  child: Text(
                                                    mapGenersIdsToText(geners,
                                                        movie.genreIds![0]),
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          );
                        } else {
                          return const Text(Kerror);
                        }
                      })),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
