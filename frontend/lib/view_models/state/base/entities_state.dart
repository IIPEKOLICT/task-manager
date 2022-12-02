import 'package:frontend/models/base/base_entity.dart';
import 'package:frontend/view_models/state/base/observable.dart';
import 'package:frontend/view_models/state/base/stream.dart';

abstract class EntitiesState<E extends BaseEntity> {
  final Stream<List<E>> _entities$ = Stream([]);

  Observable<List<E>> get entities$ {
    return _entities$;
  }

  List<E> getEntities() => _entities$.get();

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
}
