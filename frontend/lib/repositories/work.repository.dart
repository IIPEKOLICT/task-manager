import 'package:frontend/dtos/response/delete.dto.dart';
import 'package:injectable/injectable.dart';

import '../models/work.dart';
import 'base/base.repository.dart';

@LazySingleton()
class WorkRepository extends BaseRepository {
  WorkRepository(super.httpClient, super.mainInterceptor);

  @override
  String get endpoint => 'works';

  Future<Work> getById(String id) async {
    return Work.fromJson(await get<Map<String, dynamic>>(path: id));
  }

  Future<Work> updateById(
    String id,
    String description,
    DateTime startDate,
    DateTime endDate,
  ) async {
    return Work.fromJson(
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

  Future<String> deleteById(String id) async {
    return DeleteDto.fromJson(await delete<Map<String, dynamic>>(path: id)).id;
  }
}
