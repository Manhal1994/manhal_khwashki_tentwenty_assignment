import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mymovie/data/movie_repositpry.dart';
import '../basic_bloc_state.dart';
part 'geners_event.dart';
part 'geners_state.dart';

class GenersBloc extends Bloc<GenersEvent, GenersState> {
  final MovieRepository movieRepository;
  GenersBloc({required this.movieRepository}) : super(GenersState()) {
    on<GetGeners>(_mapGetGenersToState);
  }
  _mapGetGenersToState(GetGeners event, Emitter<GenersState> emit) async {
    try {
      emit(state.copyWith(blocstate: BlocLoading()));
      final result = await movieRepository.getGeners();
      emit(state.copyWith(blocstate: BlocSuccess(response: result)));
    } catch (e, t) {
      print(e.toString());
      print(t.toString());
      emit(state.copyWith(blocstate: BlocError(message: e.toString())));
    }
  }
}
