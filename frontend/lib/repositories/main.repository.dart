import 'package:injectable/injectable.dart';

import '../dtos/response/health_check.dto.dart';
import 'base/base.repository.dart';

@LazySingleton()
class MainRepository extends BaseRepository {
  MainRepository(super.httpClient, super.authState);

  @override
  String get endpoint => '';

  Future<bool> healthCheck() async {
    return HealthCheckDto
        .fromJSON(await get<Map<String, dynamic>>(path: 'test'))
        .status == 'ok';
  }
}