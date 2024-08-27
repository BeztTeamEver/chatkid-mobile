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

  static Future<PagingResponseModel<HistoryBotChatModel>>
      getBotQuestionHistories(HistoryRequestModel paging) async {
    final response = await BaseHttp.instance
        .get(endpoint: Endpoint.botQuestionHistories, param: {
      "memberId": paging.memberId,
      ...paging.paging.toMap(),
    });
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      final data = jsonDecode(response.body);
      final items = (data['items'] as List<dynamic>)
          .map((item) => HistoryBotChatModel.fromJson(item))
          .toList();

      return PagingResponseModel<HistoryBotChatModel>(
        items: items,
        // limit: data['limit'],
        pageSize: data['pageSize'],
        totalItem: data['totalItem'],
        pageNumber: data['pageNumber'],
      );
    }
    switch (response.statusCode) {
      case 401:
        throw Exception('Lỗi không thể xác thực người dùng, vui lòng thử lại!');
      case 403:
        throw Exception(
            'Bạn không có quyền truy cập vào ứng dụng, vui lòng liên hệ với quản trị viên!');
      case 404:
        throw Exception('Không tìm thấy lịch sử, vui lòng thử lại!');
      default:
        throw Exception('Không thể lấy lịch sử, vui lòng thử lại!');
    }
  }

  static Future<bool> report(HistoryReportModel historyReport) async {
    final response = await BaseHttp.instance.post(
      endpoint: Endpoint.ReportEndPoint,
      body: historyReport.toJson(),
    );

    if (response.statusCode >= 200 && response.statusCode <= 210) {
      return true;
    }
    switch (response.statusCode) {
      case 401:
        throw Exception('Lỗi không thể xác thực người dùng, vui lòng thử lại!');
      case 403:
        throw Exception(
            'Bạn không có quyền truy cập vào ứng dụng, vui lòng liên hệ với quản trị viên!');
      case 404:
        throw Exception('Không tìm thấy lịch sử, vui lòng thử lại!');
      default:
        throw Exception('Không thể lấy lịch sử, vui lòng thử lại!');
    }
  }
}
