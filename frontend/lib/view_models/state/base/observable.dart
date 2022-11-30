abstract class Observable<T> {
  T get();
  void subscribe(void Function(T) callback);
  void unsubscribe(void Function(T) callback);
}