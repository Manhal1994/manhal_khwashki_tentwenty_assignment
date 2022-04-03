import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mymovie/data/models/movie_list_model.dart';
import 'package:mymovie/data/movie_repository_impl.dart';
import 'package:mymovie/data/movie_repositpry.dart';
import '../basic_bloc_state.dart';
part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;
  MovieBloc({required this.movieRepository}) : super(const MovieState()) {
    on<GetUpcomingMovies>(_mapGetUpcomingMoviesToMovieState);
  }
  _mapGetUpcomingMoviesToMovieState(
    GetUpcomingMovies event,
    Emitter<MovieState> emit,
  ) async {
    emit(state.copyWith(blocstate: const BlocLoading()));
    try {
      final movieListModel =
          await movieRepository.getUpComingMovies(page: event.page);
      emit(state.copyWith(
          blocstate: BlocSuccess<MovieListModel>(response: movieListModel)));
    } catch (e, t) {
      print(e.toString());
      print(t);
      emit(state.copyWith(blocstate: BlocError(message: "Error")));
    }
  }
}
