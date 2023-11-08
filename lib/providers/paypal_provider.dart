import 'package:chatkid_mobile/models/paypal_model.dart';
import 'package:chatkid_mobile/pages/profile/payment_page.dart';
import 'package:chatkid_mobile/pages/sign_in/sign_in_page.dart';
import 'package:chatkid_mobile/services/payment_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final createPaypalProvider =
    FutureProvider.family<PaypalModel, PaypalRequestModel>((ref, model) async {
  try {
    final result = await ref.watch(paypalServiceProvider).createPaypal(model);

    return result;
  } catch (e, s) {
    Logger().e(e);
    throw Exception(e);
  }
});

final capturePaypalProvider =
    FutureProvider.family<bool, String>((ref, orderId) async {
  try {
    final result =
        await ref.watch(paypalServiceProvider).capturePaypalOrder(orderId);
    return result;
  } catch (e, s) {
    Logger().e(e);
    throw Exception(e);
  }
});
