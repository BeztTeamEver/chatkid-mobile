import 'dart:convert';

import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/gift_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:logger/logger.dart';

class GiftService {
  Future<List<GiftModel>> getListGift() async {
    final response =
        await BaseHttp.instance.get(endpoint: Endpoint.listProductEndPoint);

    if (response.statusCode >= 200 && response.statusCode <= 210) {
      final list = jsonDecode(response.body) as List;
      final List<GiftModel> data = list.map((e) {
        return GiftModel.fromJson(e);
      }).toList();
      return data;
    }
    throw Exception('Lỗi không thể lấy thông tin cửa hàng!');
  }

  Future<List<GiftModel>> createGift(GiftModel gift) async {
    final response =
        await BaseHttp.instance.post(endpoint: Endpoint.listProductEndPoint, body: gift.toJson());

    if (response.statusCode >= 200 && response.statusCode <= 210) {
      final list = jsonDecode(response.body) as List;
      final List<GiftModel> data = list.map((e) {
        return GiftModel.fromJson(e);
      }).toList();
      return data;
    }
    throw Exception('Lỗi không thể lấy thông tin cửa hàng!');
  }

  Future<List<GiftModel>> updateGift(String id, GiftModel gift) async {
    final response =
        await BaseHttp.instance.patch(endpoint: Endpoint.productEndPoint.replaceAll("{id}", id), body: gift.toJson());

    if (response.statusCode >= 200 && response.statusCode <= 210) {
      final list = jsonDecode(response.body) as List;
      final List<GiftModel> data = list.map((e) {
        return GiftModel.fromJson(e);
      }).toList();
      return data;
    }
    throw Exception('Lỗi không thể lấy thông tin cửa hàng!');
  }

  Future<List<GiftModel>> deleteGift(String id) async {
    final response =
        await BaseHttp.instance.delete(endpoint: Endpoint.productEndPoint.replaceAll("{id}", id));

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
