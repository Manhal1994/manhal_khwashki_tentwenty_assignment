import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:mymovie/data/models/general_model.dart';
import 'package:mymovie/data/models/movie_list_model.dart';
import 'package:mymovie/data/models/search_model.dart';
import 'package:mymovie/data/models/video_model.dart';
import 'package:mymovie/data/movie_repositpry.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'datasources/remote/movie_remote_data_source.dart';
import 'datasources/local/movie_local_data_source.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource movieRemoteDataSource;
  final MovieLocalDataSource movieLocalDataSource;
  final InternetConnectionChecker internetConnectionChecker;

  MovieRepositoryImpl(
      {required this.movieRemoteDataSource,
      required this.movieLocalDataSource,
      required this.internetConnectionChecker});
  @override
  Future<MovieListModel?>? getUpComingMovies({required int page}) async {
    if (await internetConnectionChecker.hasConnection) {
      final res = await movieRemoteDataSource.getUpComingMovies(page: page);
      if (res != null) {
        movieLocalDataSource.cachUpComingMovies(
            response: json.encode(res.toJson()), page: page);
      }
      return res;
    } else {
      return await movieLocalDataSource.getUpComingMovies(page: page);
    }
  }

  @override
  Future<VideosModel> getVideoLink({required int id}) async {
    return await movieRemoteDataSource.getVideoLink(id: id);
  }

  @override
  Future<GenralModel?> getGeners() async {
    if (await internetConnectionChecker.hasConnection) {
      final res = await movieRemoteDataSource.getGeners();
      if (res != null) {
        await movieLocalDataSource.cachGeners(
            response: json.encode(res.toJson()));
        return res;
      }
    } else {
      return await movieLocalDataSource.getGeners();
    }
  }

  @override
  Future<SearchModel?> search(
      {required int page, required String query}) async {
    if (await internetConnectionChecker.hasConnection) {
      final res = await movieRemoteDataSource.search(query: query, page: page);
      if (res != null) {
        await movieLocalDataSource.cachsearchResults(
            response: json.encode(res.toJson()), query: query);
        return res;
      }
    } else {
      return await movieLocalDataSource.getSeachResults(query: query);
    }
  }
}
