import 'package:chatkid_mobile/models/family_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:logger/logger.dart';

class FamilyService {
  static const _createFamilyEndPoint = "/api/family";

  static Future<void> createFamily({required String name}) async {
    final body = FamilyRequestModel(name: name);
    final response = await BaseHttp.instance.post(
      endpoint: _createFamilyEndPoint,
    );

    if (response.statusCode == 200) {
      Logger().d(response.body);
    }
    switch (response.statusCode) {
      case 401:
        throw Exception('Lỗi không thể xác thực người dùng, vui lòng thử lại!');
      case 403:
        throw Exception(
            'Bạn không có quyền truy cập vào ứng dụng, vui lòng liên hệ với quản trị viên!');
      default:
        throw Exception('Lỗi tạo tài khoản, vui lòng thử lại sau!');
    }
  }
}
