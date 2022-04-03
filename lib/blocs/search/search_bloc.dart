import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:mymovie/data/movie_repositpry.dart';
import '../basic_bloc_state.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final MovieRepository movieRepository;
  SearchBloc({required this.movieRepository}) : super(const SearchState()) {
    on<GetSeachResults>(_mapSearchToState);
  }
  _mapSearchToState(GetSeachResults event, Emitter<SearchState> emit) async {
    emit(state.copyWith(blocstate: const BlocLoading()));
    try {
      final result =
          await movieRepository.search(page: event.page, query: event.query);
      emit(state.copyWith(blocstate: BlocSuccess(response: result)));
    } catch (e, t) {
      print(e);
      print(t);
      emit(state.copyWith(blocstate: const BlocError(message: "Error")));
    }
  }
}
