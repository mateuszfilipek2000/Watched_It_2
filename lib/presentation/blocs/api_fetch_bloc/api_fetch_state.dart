abstract class ApiFetchState<T> {
  const ApiFetchState();
}

class ApiFetchInitial<T> extends ApiFetchState<T> {
  const ApiFetchInitial();
}

class ApiFetchLoading<T> extends ApiFetchState<T> {
  const ApiFetchLoading();
}

class ApiFetchSuccess<T> extends ApiFetchState<T> {
  const ApiFetchSuccess({
    required this.resource,
  });

  final T resource;
}

class ApiFetchFailure<T> extends ApiFetchState<T> {
  const ApiFetchFailure({
    required this.message,
  });

  final String message;
}
