import 'dart:convert';

import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/pagination_response_model.dart';
import 'package:chatkid_mobile/models/subcription_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';

class SubcriptionService {
  Future<List<SubcriptionModel>> getSubcriptions() async {
    final response = await BaseHttp.instance.get(
      endpoint: Endpoint.subcriptionEndPoint,
    );
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      final data = jsonDecode(response.body);
      final model = PaginationResponseModel.fromJson(data);
      return model.items.map((res) => SubcriptionModel.fromJson(res)).toList();
    }
    switch (response.statusCode) {
      case 401:
        LocalStorage.instance.clear();
        throw Exception('Lỗi không thể xác thực người dùng, vui lòng thử lại!');
      case 403:
        LocalStorage.instance.clear();
        throw Exception(
            'Bạn không có quyền truy cập vào ứng dụng, vui lòng liên hệ với quản trị viên!');
      case 404:
        LocalStorage.instance.clear();
        throw Exception('Không tìm thấy gói, vui lòng thử lại!');
      default:
        throw Exception('Không thể lấy thông tin gói, vui lòng thử lại!');
    }
  }
}
