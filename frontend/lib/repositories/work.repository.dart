import 'package:frontend/repositories/base/read_delete.repository.dart';
import 'package:injectable/injectable.dart';

import '../models/work.dart';
import 'base/base.repository.dart';

@LazySingleton()
class WorkRepository extends BaseRepository with ReadDeleteRepository<Work> {
  WorkRepository(super.httpClient, super.mainInterceptor);

  @override
  String get endpoint => 'works';

  @override
  Work Function(Map<String, dynamic> p1) get convertResponse => Work.fromJson;

  Future<Work> updateById(
    String id,
    String description,
    DateTime startDate,
    DateTime endDate,
  ) async {
    return convertResponse(
      await put<Map<String, dynamic>>(
        path: id,
        body: {
          'description': description,
          'startDate': startDate.toUtc().toString(),
          'endDate': endDate.toUtc().toString(),
        },
      ),
    );
  }
}
