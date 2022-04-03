import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:injectable/injectable.dart';
import 'package:mymovie/blocs/geners/geners_bloc.dart';
import 'package:mymovie/data/models/general_model.dart';
import 'package:mymovie/data/models/movie_list_model.dart';
import 'package:mymovie/data/models/search_model.dart';
import 'package:mymovie/data/models/video_model.dart';

class MovieRemoteDataSource {
  static const String scheme = "https://";
  static const String domain = "api.themoviedb.org/";
  static const String moviesUrl = "api.themoviedb.org/3/movie/";
  static const String url = scheme + moviesUrl;
  static const String apiKEY = "df0afeb903f509ecce3212b0af798cc3";

  Dio client;
  MovieRemoteDataSource({required this.client}) {
    client.interceptors.add(
      DioLoggingInterceptor(
        level: Level.body,
        compact: false,
      ),
    );
  }
  Future<MovieListModel>? getUpComingMovies({required int page}) async {
    Response response =
        await client.get(url + "upcoming?page=$page&api_key=$apiKEY");
    return MovieListModel.fromJson(response.data);
  }

  Future<VideosModel> getVideoLink({required int id}) async {
    Response response = await client.get(url + "/$id/videos?&api_key=$apiKEY");
    return VideosModel.fromJson(response.data);
  }

  Future<GenralModel?> getGeners() async {
    try {
      Response response = await client
          .get(scheme + domain + "3/genre/movie/list?&api_key=$apiKEY");
      return GenralModel.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<SearchModel> search({required String query, required int page}) async {
    Response response = await client.get(scheme +
        domain +
        "3/search/movie?&query=$query&page$page&api_key=$apiKEY");
    return SearchModel.fromJson(response.data);
  }
}
