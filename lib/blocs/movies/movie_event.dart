part of 'movie_bloc.dart';

@immutable
abstract class MovieEvent {}

class GetUpcomingMovies extends MovieEvent {
  final int page;
  GetUpcomingMovies({required this.page});
}
