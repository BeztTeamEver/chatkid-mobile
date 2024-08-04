import 'dart:convert';

import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/transaction_model.dart';
import 'package:chatkid_mobile/models/transfer_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class TransactionService {
  Future<List<TransactionModel>> getTransaction() async {
    final response = await BaseHttp.instance.get(
      endpoint: "${Endpoint.getPaymentTransactionEndPoint}?page-size=100",
    );
    if (response.statusCode >= 200 || response.statusCode < 300) {
      final data = jsonDecode(response.body);
      final listTransaction = (data['items'] as List<dynamic>).map((item) => TransactionModel.fromJson(item)).toList();

      return listTransaction;
    } else {
      throw Exception('Failed to get transaction');
    }
  }

  Future<List<TransferModel>> getTransferHistory(String id) async {
    final response = await BaseHttp.instance.get(
      endpoint: "${Endpoint.listTransactionTransferEndPoint}?memberId=$id&type=TRANSFER",
    );
    if (response.statusCode >= 200 || response.statusCode < 300) {
      List data = jsonDecode(response.body);
      final listTransaction = data.map((item) => TransferModel.fromJson(item)).toList();

      return listTransaction;
    } else {
      throw Exception('Failed to get transaction');
    }
  }

  Future<TransactionModel> createTransaction(CreateTransactionModel body) async {
    final response = await BaseHttp.instance.post(
      endpoint: Endpoint.createTransactionEndPoint,
      body: jsonEncode(body.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return TransactionModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create transaction');
    }
  }
}

final transactionServiceProvider = Provider<TransactionService>((ref) {
  return TransactionService();
});