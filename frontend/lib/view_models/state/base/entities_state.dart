import 'package:frontend/models/base/base_entity.dart';
import 'package:frontend/view_models/state/base/observable.dart';
import 'package:frontend/view_models/state/base/stream.dart';

abstract class EntitiesState<E extends BaseEntity> {
  final Stream<List<E>> _entities$ = Stream([]);
  final Stream<E?> _current$ = Stream(null);
  final Stream<String?> _currentId$ = Stream(null);

  Observable<List<E>> get entities$ {
    return _entities$;
  }

  Observable<E?> get current$ {
    return _current$;
  }

  Observable<String?> get currentId$ {
    return _currentId$;
  }

  List<E> getEntities() => _entities$.get();
  E? getCurrentOrNull() => _current$.get();
  E getCurrent() => _current$.get() ?? (throw Exception());
  String? getCurrentIdOrNull() => _currentId$.get();
  String getCurrentId() => _currentId$.get() ?? (throw Exception());

  void setEntities(List<E> value) {
    _entities$.set(value);
  }

  void addEntity(E entity) {
    _entities$.set([...getEntities(), entity]);
  }

  void updateEntity(E entity) {
    _entities$.set(getEntities().map((e) => e.id == entity.id ? entity : e).toList());
  }

  void removeEntityById(String id) {
    _entities$.set(getEntities().where((entity) => entity.id != id).toList());
  }

  void setCurrent(E? value) {
    _current$.set(value);
  }

  void setCurrentId(String? value) {
    _currentId$.set(value);
  }
}
