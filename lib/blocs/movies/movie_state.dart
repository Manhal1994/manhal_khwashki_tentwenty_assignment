part of 'movie_bloc.dart';

class MovieState {
  final BasicBlocState state;
  const MovieState({this.state = const BlocLoading()});
  MovieState copyWith({BasicBlocState? blocstate}) {
    return MovieState(state: blocstate ?? blocstate!);
  }
}
