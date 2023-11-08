import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/gpt_modal.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class GptService {
  Future<String> chat(String message, String kidServiceId) async {
    final body = GptRequestModal(message: message, kidServiceId: kidServiceId);
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

  GptNotifier() : super(GptRequestModal(message: '', kidServiceId: ''));

  void setMessage(String message, String kidServiceId) {
    state = GptRequestModal(message: message, kidServiceId: kidServiceId);
  }

  Future<String> chat(String message, String kidServiceId) async {
    try {
      String result = await _gptService.chat(message, kidServiceId);
      state.message = result;
      return result;
    } catch (e) {
      Logger().e(e);
      throw Exception(e);
    }
  }
}
