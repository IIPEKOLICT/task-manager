import 'package:frontend/view_models/shared/observable.dart';

class Stream<T> extends Observable<T> {
  T _value;

  Stream(this._value);

  final Set<void Function(T)> _subscribers = {};

  @override
  T get() {
    return _value;
  }

  void set(T value) {
    _value = value;
    notifySubscribers();
  }

  @override
  void subscribe(void Function(T) callback, {bool lazy = true}) {
    _subscribers.add(callback);

    if (!lazy) {
      callback(_value);
    }
  }

  @override
  void unsubscribe(void Function(T) callback) {
    _subscribers.remove(callback);
  }

  void notifySubscribers() {
    for (var callback in _subscribers) {
      callback(_value);
    }
  }
}
