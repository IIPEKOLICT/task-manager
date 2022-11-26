import 'dart:io';

import 'package:injectable/injectable.dart';

import 'base/base.repository.dart';

@LazySingleton()
class MainRepository extends BaseRepository {
  MainRepository(super.httpClient, super.storageService);

  @override
  String get endpoint => '';

  Future<bool> healthCheck() async {
    return (await get()).statusCode == HttpStatus.ok;
  }
}