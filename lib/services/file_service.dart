import 'dart:convert';
import 'dart:math';

import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/file_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class FileService {
  Future<List<FileModel>> getAvatars() async {
    final response =
        await BaseHttp.instance.get(endpoint: Endpoint.avatarEndpoint);
    Logger().i(response.body);
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      // final data = jsonDecode(response.body)
      //     .map((e) => FileModel.fromJson(jsonDecode(e)));
      final list = jsonDecode(response.body) as List;
      final List<FileModel> data = list.map((e) {
        return FileModel.fromJson(e);
      }).toList();
      return data;
    }
    throw Exception('Lỗi không thể lấy ảnh đại diện, vui lòng thử lại!');
  }
}

final fileServiceProvider = Provider<FileService>((ref) {
  return FileService();
});
