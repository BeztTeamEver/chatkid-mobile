import 'dart:convert';

import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/history_tracking_model.dart';
import 'package:chatkid_mobile/models/pagination_response_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';

class HistoryTrackingService {
  Future<List<HistoryTrackingModel>> getHistory(String userId) async {
    final response = await BaseHttp.instance
        .get(endpoint: Endpoint.historyEndPoint, param: {'user-id': userId});
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      final data = jsonDecode(response.body);
      final model = PaginationResponseModel.fromJson(data);
      return model.items
          .map((res) => HistoryTrackingModel.fromJson(res))
          .toList();
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
        throw Exception('Không tìm thấy lịch sử hoạt động, vui lòng thử lại!');
      default:
        throw Exception(
            'Không thể lấy thông tin lịch sử hoạt động, vui lòng thử lại!');
    }
  }
}
