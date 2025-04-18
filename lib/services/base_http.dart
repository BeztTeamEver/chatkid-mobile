import 'dart:convert';
import 'dart:io';

import 'package:chatkid_mobile/config.dart';
import 'package:chatkid_mobile/services/login_service.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

const TIME_OUT = 30;

class BaseHttp {
  static BaseHttp? _instance;
  static const String apiVersion = "1.0";
  LocalStorage _localStorage = LocalStorage.instance;

  BaseHttp._internal();

  static BaseHttp get instance {
    _instance ??= BaseHttp._internal();
    return _instance!;
  }

  String _combineUrl(String enpoint, Map<String, dynamic>? param) {
    String url = Env.apiUrl + enpoint;
    if (param != null) {
      url += "?";
      param.forEach((key, value) {
        if (value != null) {
          url += "$key=$value&";
        }
      });
      // url = url.substring(0, url.length - 1);
    }
    return url;
  }

  Future<Map<String, String>> getHeaders(
      Map<String, String>? headers, bool? isUseFamilyToken) async {
    String token =
        await AuthService.getAccessToken(isUseFamilyToken: isUseFamilyToken);

    return {
      "Content-Type": "application/json",
      "Accept": "application/json, text/plain, */*",
      "Authorization": "Bearer $token",
      "api-version": apiVersion,
      ...?headers,
    };
  }

  Future<http.Response> get({
    required String endpoint,
    Map<String, dynamic>? param,
    Map<String, String>? headers,
    bool? isUseFamilyToken,
  }) async {
    String url = _combineUrl(endpoint, param);
    final combineHeaders = await getHeaders(headers, isUseFamilyToken);
    return await http.Client()
        .get(
      Uri.parse(url),
      headers: combineHeaders,
    )
        .timeout(
      const Duration(seconds: TIME_OUT),
      onTimeout: () {
        throw Exception('Connection Timeout!');
      },
    );
  }

  Future<http.Response> post({
    required String endpoint,
    Map<String, dynamic>? param,
    Map<String, String>? headers,
    bool? isUseFamilyToken,
    String? body,
  }) async {
    String url = _combineUrl(endpoint, param);

    return await http
        .post(
      Uri.parse(url),
      body: body,
      headers: await getHeaders(headers, isUseFamilyToken),
    )
        .catchError((err, s) {
      Logger().e(err, stackTrace: s);
      throw Exception(err);
    }).timeout(
      const Duration(seconds: TIME_OUT),
      onTimeout: () {
        throw Exception('Connection Timeout!');
      },
    );
  }

  Future<http.Response> put({
    required String endpoint,
    Map<String, dynamic>? param,
    Map<String, String>? headers,
    bool? isUseFamilyToken,
    String? body,
  }) async {
    String url = _combineUrl(endpoint, param);
    return await http
        .put(
      Uri.parse(url),
      body: body,
      headers: await getHeaders(headers, isUseFamilyToken),
    )
        .timeout(
      const Duration(seconds: TIME_OUT),
      onTimeout: () {
        throw Exception('Connection Timeout!');
      },
    );
  }

  Future<http.Response> delete({
    required String endpoint,
    Map<String, dynamic>? param,
    Map<String, String>? headers,
    bool? isUseFamilyToken,
    String? body,
  }) async {
    String url = _combineUrl(endpoint, param);
    return await http
        .delete(
      Uri.parse(url),
      headers: await getHeaders(headers, isUseFamilyToken),
      body: body,
    )
        .timeout(
      const Duration(seconds: TIME_OUT),
      onTimeout: () {
        throw Exception('Connection Timeout!');
      },
    );
  }

  Future<http.Response> patch({
    required String endpoint,
    Map<String, dynamic>? param,
    Map<String, String>? headers,
    bool? isUseFamilyToken,
    String? body,
  }) async {
    String url = _combineUrl(endpoint, param);
    return await http
        .patch(
      Uri.parse(url),
      headers: await getHeaders(headers, isUseFamilyToken),
      body: body,
    )
        .timeout(
      const Duration(seconds: TIME_OUT),
      onTimeout: () {
        throw Exception('Connection Timeout!');
      },
    );
  }

  Future<http.Response> postFile({
    required File file,
    required String endpoint,
  }) async {
    final headers = await getHeaders(null, false);
    final request =
        http.MultipartRequest('POST', Uri.parse(Env.apiUrl + endpoint))
          ..files.add(
            await http.MultipartFile.fromPath(
              'file',
              file.path,
            ),
          );
    request.headers.addAll(headers);
    return await request.send().then((response) async {
      final res = await http.Response.fromStream(response);
      return res;
    });
  }
}
