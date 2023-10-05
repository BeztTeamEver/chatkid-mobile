import 'dart:convert';
import 'package:chatkid_mobile/modals/post_modal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

List<PostModal> parserPost(String responseBody) {
  var list = jsonDecode(responseBody) as List<dynamic>;
  List<PostModal> posts =
      list.map((modal) => PostModal.fromJson(modal)).toList();
  return posts;
}

// FIX: This just use for example for testing list api
class PostService {
  String endpoint = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<PostModal>> get() async {
    final response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      return parserPost(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

final postServiceProvider = Provider<PostService>((ref) {
  return PostService();
});
