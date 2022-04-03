part of 'video_bloc.dart';

@immutable
abstract class VideoEvent {}

class GetMovieVideoLink extends VideoEvent {
  final int id;
  GetMovieVideoLink({required this.id});
}
