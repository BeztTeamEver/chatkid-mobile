import 'package:chatkid_mobile/models/transaction_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chatkid_mobile/services/transaction_service.dart';
import 'package:logger/logger.dart';

final createTransactionProvider =
    FutureProvider.family<TransactionModel, CreateTransactionModel>(
        (ref, model) async {
  try {
    final result =
        await ref.watch(transactionServiceProvider).createTransaction(model);
    return result;
  } catch (e, s) {
    Logger().e(e);
    throw Exception(e);
  }
});
