part of 'video_bloc.dart';

class VideoState {
  final BasicBlocState state;
  const VideoState({this.state = const BlocLoading()});
  VideoState copyWith({BasicBlocState? blocstate}) {
    return VideoState(state: blocstate ?? blocstate!);
  }
}
