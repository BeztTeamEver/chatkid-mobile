import 'package:chatkid_mobile/config.dart';
import 'package:chatkid_mobile/services/base_http.dart';

class AuthService {
  final _endpoint = "/api/auth/google-auth";

  Future<String> login(String token) async {
    final response = await BaseHttp.instance.post(
      endpoint: _endpoint,
      body: {
        "token": token,
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to login');
    }
  }
}
