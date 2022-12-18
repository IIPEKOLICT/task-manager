import 'package:flutter/material.dart';
import 'package:frontend/repositories/base/base.repository.dart';

import '../../dtos/response/delete.dto.dart';
import '../../models/base/base_entity.dart';

mixin ReadDeleteRepository<E extends BaseEntity> on BaseRepository {
  @protected
  E Function(Map<String, dynamic>) get convertResponse;

  Future<E> getById(String id) async {
    return convertResponse(await get<Map<String, dynamic>>(path: id));
  }

  Future<String> deleteById(String id) async {
    return DeleteDto.fromJson(await delete<Map<String, dynamic>>(path: id)).id;
  }
}
