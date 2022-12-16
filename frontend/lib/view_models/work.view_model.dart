import 'package:flutter/material.dart';
import 'package:frontend/models/work.dart';
import 'package:frontend/repositories/work.repository.dart';
import 'package:frontend/state/task.state.dart';
import 'package:frontend/state/work.state.dart';
import 'package:frontend/view_models/base/loadable.view_model.dart';
import 'package:frontend/view_models/base/page.view_model.dart';
import 'package:injectable/injectable.dart';

import '../repositories/task.repository.dart';

@Injectable()
class WorkViewModel extends PageViewModel<WorkViewModel> with LoadableViewModel {
  final WorkState _workState;
  final TaskState _taskState;
  final TaskRepository _taskRepository;
  final WorkRepository _workRepository;

  WorkViewModel(
    @factoryParam super.context,
    this._workState,
    this._taskState,
    this._taskRepository,
    this._workRepository,
  );

  @override
  WorkViewModel copy(BuildContext context) {
    return WorkViewModel(context, _workState, _taskState, _taskRepository, _workRepository);
  }

  @override
  WorkViewModel create() {
    _loadWorks();
    return this;
  }

  @override
  void onInit() {
    _workState.entities$.subscribe(loaderSubscriber);
    _workState.current$.subscribe(_currentWorkSubscriber, lazy: false);
  }

  String _description = '';
  DateTime? _startDate;
  DateTime? _endDate;

  bool get isValid {
    if (_description.isEmpty || _startDate == null || _endDate == null) {
      return false;
    }

    return _startDate!.isBefore(_endDate!);
  }

  bool get isEdit {
    return _workState.getCurrentOrNull() != null;
  }

  String getDescription() => _description;
  DateTime? getStartDate() => _startDate;
  DateTime? getEndDate() => _endDate;
  List<Work> getWorks() => _workState.getEntities();

  void setDescription(String value) {
    _description = value;
    notifyListeners();
  }

  Future<void> _pickTime(void Function(DateTime, TimeOfDay) callback) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      helpText: 'Выберите дату',
      confirmText: 'ОК',
      cancelText: 'Отменить',
    );

    if (date == null) return;

    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: 'Выберите время',
      confirmText: 'ОК',
      cancelText: 'Отменить',
      hourLabelText: 'Часы',
      minuteLabelText: 'Минуты',
    );

    if (time != null) {
      callback(date, time);
      notifyListeners();
    }
  }

  DateTime _parseDateAndTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  Future<void> pickStartTime() async {
    await _pickTime(
      (DateTime date, TimeOfDay time) => _startDate = _parseDateAndTime(date, time),
    );
  }

  Future<void> pickEndTime() async {
    await _pickTime(
      (DateTime date, TimeOfDay time) => _endDate = _parseDateAndTime(date, time),
    );
  }

  void setWork(Work? value) {
    _workState.setCurrent(value);
  }

  void _currentWorkSubscriber(Work? work) {
    _description = work?.description ?? '';
    _startDate = work?.startDate;
    _endDate = work?.endDate;
  }

  Future<void> _loadWorks() async {
    try {
      _workState.setEntities(await _taskRepository.getTaskWorks(_taskState.getCurrentId()));
    } catch (e) {
      onException(e);
    }
  }

  Future<void> _create() async {
    _workState.addEntity(
      await _taskRepository.createTaskWork(
        _taskState.getCurrentId(),
        _description,
        _startDate ?? (throw Exception()),
        _endDate ?? (throw Exception()),
      ),
    );
  }

  Future<void> _update() async {
    _workState.updateEntity(
      await _workRepository.updateById(
        _workState.getCurrent().id,
        _description,
        _startDate ?? (throw Exception()),
        _endDate ?? (throw Exception()),
      ),
    );
  }

  Future<void> submitHandler() async {
    try {
      if (isEdit) {
        await _update();
      } else {
        await _create();
      }
    } catch (e) {
      onException(e);
    } finally {
      _workState.setCurrent(null);
      Navigator.of(context).pop();
    }
  }

  Future<void> Function() deleteById(String id) {
    return () async {
      try {
        _workState.removeEntityById(await _workRepository.deleteById(id));
      } catch (e) {
        onException(e);
      }
    };
  }

  @override
  void dispose() {
    _workState.entities$.unsubscribe(loaderSubscriber);
    _workState.current$.unsubscribe(_currentWorkSubscriber);

    super.dispose();
  }
}
