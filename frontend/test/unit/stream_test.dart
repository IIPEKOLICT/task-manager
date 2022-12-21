import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/shared/stream.dart';

void main() async {
  int value = 0;

  void subscriber(int streamValue) => value = streamValue;

  group('stream tests', () {
    test('subscribe() should work correctly', () {
      final stream$ = Stream(1);

      stream$.subscribe(subscriber);

      expect(value, 0);

      stream$.set(42);

      expect(value, 42);

      stream$.unsubscribe(subscriber);
    });

    test('subscribe() with active parameter `lazy` should work correctly', () {
      final stream$ = Stream(1);

      stream$.subscribe(subscriber, lazy: false);

      expect(value, 1);

      stream$.unsubscribe(subscriber);
    });

    test('unsubscribe() should work correctly', () {
      final stream$ = Stream(1);

      stream$.subscribe(subscriber);
      stream$.set(42);

      expect(value, 42);

      stream$.unsubscribe(subscriber);
      stream$.set(11);

      expect(value, 42);

      stream$.unsubscribe(subscriber);
      stream$.set(1);
    });
  });
}
