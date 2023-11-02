import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/gpt_modal.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class GptService {
  Future<String> chat(String message) async {
    final body = GptRequestModal(message: message);
    final response = await BaseHttp.instance
        .post(endpoint: Endpoint.gptChatEndPoint, body: body.toJson());
    Logger().d(response.body);
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.body;
      case 400:
        throw Exception('Bad request');
      case 401:
        throw Exception('Lỗi xác thực');
      case 403:
        throw Exception('Bạn không có quyền truy cập vào tài nguyên này');
      case 404:
        throw Exception('Không tìm thấy tài nguyên');
      case 500:
        throw Exception('Lỗi máy chủ');
      default:
        return response.body;
    }
  }
}

class GptNotifier extends StateNotifier<GptRequestModal> {
  final GptService _gptService = GptService();

  GptNotifier() : super(GptRequestModal(message: ''));

  void setMessage(String message) {
    state = GptRequestModal(message: message);
  }

  Future<String> chat(String message) async {
    try {
      Logger().d(message);
      String result = await _gptService.chat(message);
      state.message = result;
      return result;
    } catch (e) {
      Logger().e(e);
      throw Exception(e);
    }
  }
}
