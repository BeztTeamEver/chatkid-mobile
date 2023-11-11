import 'dart:async';
import 'dart:convert';

import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/paypal_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class PaymentService {
  Future<PaypalModel> createPaypal(PaypalRequestModel model) async {
    final response = await BaseHttp.instance.post(
      endpoint: Endpoint.paypalEndPoint,
      body: jsonEncode(model.toJson()),
    );
    if (response.statusCode == 200) {
      Logger().d(jsonDecode(response.body));
      return PaypalModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create paypal order');
    }
  }

  Future<bool> capturePaypalOrder(String userId, String orderId) async {
    final response = await BaseHttp.instance.post(
      endpoint: Endpoint.capturePaypalEndPoint,
      param: {'id': userId, 'orderId': orderId},
    );
    if (response.statusCode >= 200 && response.statusCode <= 204) {
      return true;
    } else {
      throw Exception('Failed to capture paypal order');
    }
  }
}

final paypalServiceProvider = Provider<PaymentService>((ref) {
  return PaymentService();
});
