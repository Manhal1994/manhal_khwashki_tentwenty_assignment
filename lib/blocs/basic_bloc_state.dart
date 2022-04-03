abstract class BasicBlocState {
  const BasicBlocState();
}

class BlocInitial extends BasicBlocState {
  const BlocInitial();
}

class BlocLoading extends BasicBlocState {
  const BlocLoading();
}

class BlocSuccess<T> extends BasicBlocState {
  final T response;
  const BlocSuccess({required this.response});
}

class BlocFail extends BasicBlocState {
  final String message;
  const BlocFail({required this.message});
}

class BlocError extends BasicBlocState {
  final String message;
  const BlocError({required this.message});
}
