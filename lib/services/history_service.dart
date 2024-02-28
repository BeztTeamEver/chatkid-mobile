import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/paging_modal.dart';
import 'package:chatkid_mobile/models/response_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:logger/logger.dart';

class HistoryService {
  static Future<List<PagingResponseModel>> getHistory(
      PagingModel paging) async {
    final response = await BaseHttp.instance
        .get(endpoint: Endpoint.historyEndPoint, param: paging.toMap());

    Logger().i(response.body);
    if (response.statusCode == 200) {
      final data = response.body as List;
      return data.map((e) => PagingResponseModel.fromJson(e)).toList();
    } else {
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
}
