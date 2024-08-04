import 'dart:async';
import 'dart:convert';

import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/zalopay_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class PaymentService {
  Future<ZaloPayModel> createZaloPayOrder(String id) async {
    final response = await BaseHttp.instance.post(
      endpoint: Endpoint.createZaloPayOrderEndPoint.replaceAll("{id}", id),
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      Logger().d(response.body);
      return ZaloPayModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create ZaloPay order');
    }
  }

  Future<bool> captureZaloPayOrder(
      String userId, String orderId, int energy) async {
    final response = await BaseHttp.instance.post(
      endpoint: Endpoint.createTransactionEndPoint,
      param: {'id': userId, 'orderId': orderId, 'energy': energy},
    );
    if (response.statusCode >= 200 && response.statusCode <= 204) {
      return true;
    } else {
      throw Exception('Failed to capture ZaloPay order');
    }
  }

  Future<bool> createTransaction(
      String userId, String orderId, int energy) async {
    final response = await BaseHttp.instance.post(
      endpoint: Endpoint.createTransactionEndPoint,
      param: {'id': userId, 'orderId': orderId, 'energy': energy},
    );
    if (response.statusCode >= 200 && response.statusCode <= 204) {
      return true;
    } else {
      throw Exception('Failed to capture ZaloPay order');
    }
  }
}
