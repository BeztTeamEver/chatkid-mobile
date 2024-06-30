import 'dart:convert';

import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/gift_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:logger/logger.dart';

class GiftService {
  Future<List<GiftModel>> getListGift() async {
    final response =
        await BaseHttp.instance.get(endpoint: Endpoint.listProductEndPoint);
    Logger().i(response.body);
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      final list = jsonDecode(response.body) as List;
      final List<GiftModel> data = list.map((e) {
        return GiftModel.fromJson(e);
      }).toList();
      return data;
    }
    throw Exception('Lỗi không thể lấy thông tin cửa hàng!');
  }
}
