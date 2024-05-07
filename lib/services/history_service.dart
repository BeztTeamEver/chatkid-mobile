import 'dart:convert';

import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/family_model.dart';
import 'package:chatkid_mobile/models/history_model.dart';
import 'package:chatkid_mobile/models/paging_model.dart';
import 'package:chatkid_mobile/models/response_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class HistoryService {
  static Future<PagingResponseModel<HistoryModel>> getHistory(
      {required PagingModel paging, required String memberId}) async {
    final response =
        await BaseHttp.instance.get(endpoint: Endpoint.historyEndPoint, param: {
      ...paging.toMap(),
      'memberId': memberId,
    });

    if (response.statusCode >= 200 && response.statusCode <= 210) {
      final data = jsonDecode(response.body);
      final items = (data['items'] as List<dynamic>)
          .map((item) => HistoryModel.fromJson(item))
          .toList();

      return PagingResponseModel<HistoryModel>(
        items: items,
        // limit: data['limit'],
        pageSize: data['pageSize'],
        totalItem: data['totalItem'],
        pageNumber: data['pageNumber'],
      );
    }
    switch (response.statusCode) {
      case 400:
        throw Exception("Bad request");
      case 401:
        throw Exception("Unauthorized");
      case 403:
        throw Exception("Forbidden");
      case 404:
        throw Exception("Not found");
      case 500:
        throw Exception("Internal server error");
      default:
        throw Exception("Unknown error");
    }
  }
}
