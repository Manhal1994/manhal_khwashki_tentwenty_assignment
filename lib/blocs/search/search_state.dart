part of 'search_bloc.dart';

class SearchState {
  final BasicBlocState state;
  const SearchState({this.state = const BlocInitial()});
  SearchState copyWith({BasicBlocState? blocstate}) {
    return SearchState(state: blocstate ?? blocstate!);
  }
}
