import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:mymovie/blocs/search/search_bloc.dart';
import 'package:mymovie/data/models/general_model.dart';
import 'package:mymovie/data/models/movie_list_model.dart';
import 'package:mymovie/data/models/search_model.dart';

import 'movie_db.dart';

class MovieLocalDataSource {
  late MyDatabase movieDB;
  MovieLocalDataSource({required this.movieDB});
  GenralModel? genralModel;
  Future<MovieListModel?> getUpComingMovies({required int page}) async {
    String? res = await movieDB.getUpcomingMovies(page);
    if (res != null) {
      return MovieListModel.fromJson(json.decode(res));
    } else {
      return null;
    }
  }

  cachUpComingMovies({required String response, required int page}) {
    movieDB.cacheUpcomingMovies(page: page, response: response);
  }

  Future<GenralModel?> getGeners() async {
    if (genralModel != null) {
      String? res = await movieDB.getGeners();
      if (res != null) {
        return GenralModel.fromJson(json.decode(res));
      } else {
        return null;
      }
    }
    return genralModel;
  }

  Future<dynamic> cachGeners({required String response}) async {
    return await movieDB.cacheGeners(response: response);
  }

  Future<SearchModel?> getSeachResults({required String query}) async {
    String? res = await movieDB.getSearchResults(query: query);
    if (res != null) {
      return SearchModel.fromJson(json.decode(res));
    } else {
      return null;
    }
  }

  Future<dynamic> cachsearchResults(
      {required String response, required String query}) async {
    return await movieDB.cacheSearchResults(response: response, query: query);
  }
}
