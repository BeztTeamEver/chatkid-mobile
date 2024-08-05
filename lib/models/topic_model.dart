import 'package:chatkid_mobile/models/quiz_model.dart';

class TopicModel {
  late String id;
  late String name;
  late String imageUrl;

  TopicModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  TopicModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    return data;
  }
}

class TopicDetailModel {
  late String id;
  late String name;
  late String description;
  late String imageUrl;
  late List<QuizModel> quizzes;

  TopicDetailModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.quizzes,
  });

  TopicDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    description = json['description'];
    if (json['quizzes'] != null) {
      quizzes = (json['quizzes'] as List).map((item) => QuizModel.fromJson(item)).toList();
    } else {
      quizzes = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    data['description'] = description;
    data['quizzes'] = quizzes.map((item) => item.toJson()).toList();
    return data;
  }
}
