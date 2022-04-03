import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mymovie/data/models/video_model.dart';
import 'package:mymovie/data/movie_repositpry.dart';
import '../basic_bloc_state.dart';
part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final MovieRepository movieRepository;
  VideoBloc({required this.movieRepository}) : super(VideoState()) {
    on<GetMovieVideoLink>(_mapGetVideoLink);
  }
  _mapGetVideoLink(GetMovieVideoLink event, Emitter<VideoState> emit) async {
    emit(state.copyWith(blocstate: BlocLoading()));
    try {
      var response = await movieRepository.getVideoLink(id: event.id);
      emit(state.copyWith(
          blocstate: BlocSuccess<VideosModel>(response: response)));
    } catch (e, t) {
      emit(state.copyWith(blocstate: BlocError(message: "Error")));
    }
  }
}
