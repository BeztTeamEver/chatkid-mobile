import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/file_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as DartHttp;

class FileService {
  final _http = BaseHttp.instance;

  Future<List<FileModel>> getAvatars() async {
    final response = await _http.get(endpoint: Endpoint.avatarEndpoint);

    if (response.statusCode >= 200 && response.statusCode <= 210) {
      final list = jsonDecode(response.body) as List;
      final List<FileModel> data = list.map((e) {
        return FileModel.fromJson(e);
      }).toList();
      return data;
    }
    throw Exception('Lỗi không thể lấy ảnh đại diện, vui lòng thử lại!');
  }

  Future<File?> saveFileToCache(String path) async {
    // final headers = await _http.getHeaders(null, false);
    final file =
        await DefaultCacheManager().getSingleFile(path).catchError((e) {
      Logger().e(e);
      throw Exception('Lỗi không thể tải dữ liệu, vui lòng thử lại!');
    });
    final isExisted = await file.exists();
    if (isExisted) {
      return file;
    }
    return null;
  }

  Future<FileModel> sendfile(File file) async {
    final response =
        await _http.postFile(file: file, endpoint: Endpoint.fileUploadEndPoint);
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      final data = FileModel.fromJson(jsonDecode(response.body));
      return data;
    }
    throw Exception('Lỗi không thể gửi dữ liệu, vui lòng thử lại!');
  }

  Future<FileModel?> pickAndUploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg', 'svg'],
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      return await sendfile(file);
    }
    return null;
  }
}

final fileServiceProvider = Provider<FileService>((ref) {
  return FileService();
});
