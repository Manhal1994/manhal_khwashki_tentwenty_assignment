import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mymovie/blocs/basic_bloc_state.dart';
import 'package:mymovie/blocs/video/video_bloc.dart';
import 'package:mymovie/data/datasources/local/movie_local_data_source.dart';
import 'package:mymovie/data/datasources/remote/movie_remote_data_source.dart';
import 'package:mymovie/data/models/video_model.dart';
import 'package:mymovie/data/movie_repository_impl.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../injection_container.dart';

class VideoTrailer extends StatefulWidget {
  final int movieId;
  VideoTrailer({Key? key, required this.movieId}) : super(key: key);

  @override
  _VideoTrailerState createState() => _VideoTrailerState();
}

class _VideoTrailerState extends State<VideoTrailer> {
  VideoBloc videoBloc = sl<VideoBloc>();

  late YoutubePlayerController controller;

  @override
  void initState() {
    videoBloc.add(GetMovieVideoLink(id: widget.movieId));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: BlocProvider<VideoBloc>(
          create: (context) => videoBloc,
          child: BlocBuilder<VideoBloc, VideoState>(
            builder: (context, state) {
              final blocState = state.state;

              if (blocState is BlocSuccess<VideosModel>) {
                var key = blocState.response.results![0].key.toString();
                controller = YoutubePlayerController(
                  initialVideoId: key,
                  flags: const YoutubePlayerFlags(
                    autoPlay: true,
                    mute: true,
                  ),
                );
                controller.toggleFullScreenMode();

                return YoutubePlayerBuilder(
                  player: YoutubePlayer(
                    aspectRatio: 16 / 9,
                    controller: controller,
                    topActions: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                width: 75,
                                child: Center(
                                  child: Text("Done"),
                                ),
                              ),
                            ),
                          ))
                    ],
                    onEnded: (metaData) {
                      Navigator.of(context).pop();
                    },
                  ),
                  builder: (context, player) {
                    return Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: player,
                    );
                  },
                );
              } else if (blocState is BlocLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const Center(child: Text("Error"));
              }
            },
          ),
        ),
      )),
    );
  }
}
