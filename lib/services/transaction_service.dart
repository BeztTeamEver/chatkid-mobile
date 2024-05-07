import 'dart:convert';

import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/transaction_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class TransactionService {
  Future<TransactionModel> createTransaction(CreateTransactionModel body) async {
    final response = await BaseHttp.instance.post(
      endpoint: Endpoint.createTransactionEndPoint,
      body: jsonEncode(body.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      Logger().d(jsonDecode(response.body));
      return TransactionModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create transaction');
    }
  }
}

final transactionServiceProvider = Provider<TransactionService>((ref) {
  return TransactionService();
});