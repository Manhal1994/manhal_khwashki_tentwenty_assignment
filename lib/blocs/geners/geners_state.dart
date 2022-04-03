part of 'geners_bloc.dart';

class GenersState {
  final BasicBlocState state;
  const GenersState({this.state = const BlocLoading()});
  GenersState copyWith({BasicBlocState? blocstate}) {
    return GenersState(state: blocstate ?? blocstate!);
  }
}
