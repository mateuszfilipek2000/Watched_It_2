abstract class ApiFetchEvent<T> {
  const ApiFetchEvent();
}

class ApiFetchLoad<T> extends ApiFetchEvent<T> {
  const ApiFetchLoad();
}
