import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mymovie/blocs/geners/geners_bloc.dart';
import 'package:mymovie/blocs/search/search_bloc.dart';
import 'package:mymovie/data/datasources/local/movie_db.dart';
import 'package:mymovie/data/datasources/local/movie_local_data_source.dart';
import 'package:mymovie/data/datasources/remote/movie_remote_data_source.dart';
import 'package:mymovie/data/movie_repository_impl.dart';

import 'blocs/movies/movie_bloc.dart';
import 'blocs/video/video_bloc.dart';
import 'data/movie_repositpry.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  sl.registerFactory(
    () => MovieBloc(
      movieRepository: sl(),
    ),
  );
  sl.registerFactory(
    () => SearchBloc(
      movieRepository: sl(),
    ),
  );
  sl.registerFactory(
    () => GenersBloc(
      movieRepository: sl(),
    ),
  );
  sl.registerFactory(
    () => VideoBloc(
      movieRepository: sl(),
    ),
  );

  // Repository
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      movieLocalDataSource: MovieLocalDataSource(movieDB: MyDatabase()),
      movieRemoteDataSource: sl(),
      internetConnectionChecker: InternetConnectionChecker(),
    ),
  );

  // Data sources
  sl.registerLazySingleton(
    () => MovieRemoteDataSource(client: sl()),
  );

  // sl.registerLazySingleton(
  //   () => MovieLocalDataSource(movieDB: MyDatabase()),
  // );

  //! Helper

  //! External
  sl.registerLazySingleton(() => Dio()
    ..interceptors.add(
      DioLoggingInterceptor(
        level: Level.body,
        compact: false,
      ),
    ));
}
