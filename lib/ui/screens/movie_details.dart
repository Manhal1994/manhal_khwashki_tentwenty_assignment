import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymovie/blocs/basic_bloc_state.dart';
import 'package:mymovie/blocs/geners/geners_bloc.dart';
import 'package:mymovie/data/models/general_model.dart';
import 'package:mymovie/data/models/movie_list_model.dart';
import 'package:mymovie/resources/resources.dart';
import 'package:intl/intl.dart';
import 'package:mymovie/ui/screens/video_trailer.dart';
import 'package:mymovie/utils/size_config.dart';

import '../../injection_container.dart';

class MovieDetails extends StatefulWidget {
  final Movie movie;
  MovieDetails({required this.movie});
  @override
  _MovieDetailsState createState() => _MovieDetailsState(movie: movie);
}

class _MovieDetailsState extends State<MovieDetails> {
  _MovieDetailsState({required this.movie});
  final Movie movie;
  late GenersBloc genersBloc;
  @override
  void initState() {
    genersBloc = sl<GenersBloc>();
    genersBloc.add(GetGeners());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: OrientationBuilder(builder: (context, o) {
        return responsiveWidget([
          Expanded(
            flex: 6,
            child: Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                baseImageUrl + movie.posterPath!.toString()),
                            fit: BoxFit.fill)),
                  ),
                  Positioned(
                      top: 36,
                      left: 24,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            Images.arrowBack,
                            width: 15,
                            height: 7.5,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            kwatch,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      )),
                  Positioned(
                      bottom: SizeConfig.isPortrait ? 36 : 20,
                      right: 1,
                      left: 1,
                      child: toggleOrientationWidget(
                          portait: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                movie.releaseDate != null
                                    ? KinTheater + toDate(movie.releaseDate!)
                                    : "",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                              Container(
                                width: SizeConfig.screenWidth / 1.5,
                                height: 50,
                                margin: const EdgeInsets.only(top: 15),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: const Material(
                                    color: AppColor.skyBlue,
                                    child: Center(
                                      child: Text(
                                        KTickets,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return VideoTrailer(
                                      movieId: movie.id!,
                                    );
                                  }));
                                },
                                child: Container(
                                  width: SizeConfig.screenWidth / 1.5,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.transparent,
                                      border: Border.all(
                                          color: AppColor.skyBlue, width: 1)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(Images.play),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      const Text(
                                        KwatchTrailers,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          landscape: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                movie.releaseDate != null
                                    ? KinTheater + toDate(movie.releaseDate!)
                                    : "",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(children: [
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      height: 50,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: const Material(
                                          color: AppColor.skyBlue,
                                          child: Center(
                                            child: Text(
                                              KTickets,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return VideoTrailer(
                                            movieId: movie.id!,
                                          );
                                        }));
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.transparent,
                                            border: Border.all(
                                                color: AppColor.skyBlue,
                                                width: 1)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(Images.play),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            const Text(
                                              KwatchTrailers,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ]),
                              )
                            ],
                          )))
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    Kgenres,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  BlocProvider<GenersBloc>(
                    create: (context) => genersBloc,
                    child: BlocBuilder<GenersBloc, GenersState>(
                        builder: (context, state) {
                      final blocState = state.state;
                      if (blocState is BlocSuccess<GenralModel?>) {
                        return SizedBox(
                          height: 24,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const ScrollPhysics(),
                              itemCount: movie.genreIds!.length,
                              itemBuilder: (contrxt, index) {
                                return mapGenersIdsToWidgets(
                                    blocState.response!.genres!,
                                    movie.genreIds![index]);
                              }),
                        );
                      } else {
                        return const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.black.withOpacity(0.05)),
                  const Text(
                    Koverview,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Text(movie.overview ?? ""))),
                ],
              ),
            ),
          ),
        ]);
      })),
    );
  }

  Widget responsiveWidget(List<Widget> children) {
    return SizeConfig.isPortrait
        ? Column(
            children: children,
          )
        : Row(
            children: children,
          );
  }

  Widget toggleOrientationWidget(
      {required Widget portait, required Widget landscape}) {
    return SizeConfig.isPortrait ? portait : landscape;
  }

  Widget mapGenersIdsToWidgets(
    List<Genres> geners,
    int id,
  ) {
    return Container(
      height: 24,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: mapGenersIdToColor(id),
          borderRadius: BorderRadius.circular(16)),
      child: Center(
        child: Text(
          geners.firstWhere((element) => element.id == id).name ?? "",
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }

  Color mapGenersIdToColor(int id) {
    var color = Colors.white;
    switch (id) {
      case 28:
        color = AppColor.lightGreen;
        break;
      case 878:
        color = AppColor.darkYellow;
        break;
      case 53:
        color = AppColor.lightPink;
        break;
      default:
        color = Colors.black;
    }
    return color;
  }

  String toDate(String releseDate) {
    final DateFormat formatter = DateFormat("yyyy-MM-dd");
    var formatted = formatter.parse(releseDate);
    final DateFormat toFormate = DateFormat("MMMM dd, yyyy");
    return toFormate.format(formatted); // something like 2013-04-20
  }
}
