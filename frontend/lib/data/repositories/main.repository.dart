import 'dart:io';

import 'base/base.repository.dart';

class MainRepository extends BaseRepository {
  MainRepository() : super('');

  Future<bool> healthCheck() async {
    return (await get()).statusCode == HttpStatus.ok;
  }
}