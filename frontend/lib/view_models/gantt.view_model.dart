import 'package:frontend/dtos/response/gantt_chart.dto.dart';
import 'package:frontend/models/gantt_item.dart';
import 'package:frontend/repositories/project.repository.dart';
import 'package:frontend/state/project.state.dart';
import 'package:frontend/view_models/base/base.view_model.dart';
import 'package:frontend/view_models/base/loadable.view_model.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GanttViewModel extends BaseViewModel with LoadableViewModel {
  final ProjectState _projectState;
  final ProjectRepository _projectRepository;

  GanttViewModel(@factoryParam super.context, this._projectState, this._projectRepository);

  @override
  void onInit() {
    _loadChart();
  }

  int _hours = 0;
  List<GanttItem> _items = [];

  int getHours() => _hours;
  List<GanttItem> getItems() => _items;

  Future<void> _loadChart() async {
    try {
      final GanttChartDto response = await _projectRepository.getProjectGanttChart(
        _projectState.getCurrentId(),
      );

      _hours = response.hours + const Duration(days: 14).inHours;
      _items = response.items;

      toggleIsLoading();
      notifyListeners();
    } catch (e) {
      onException(e);
    }
  }
}
