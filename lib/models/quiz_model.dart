import 'package:chatkid_mobile/models/blog_model.dart';
import 'package:chatkid_mobile/models/question_model.dart';

class QuizModel {
  late String id;
  late String title;
  late int questionTimeLimit;
  late String illustratedImageUrl;
  late String ageGroup;
  late int percent;
  late int rate;
  late String topic;
  late String status;
  late String? createdAt;
  late BlogModel blog;
  late List<QuestionModel> questions;

  QuizModel({
    required this.id,
    required this.title,
    required this.questionTimeLimit,
    required this.illustratedImageUrl,
    required this.ageGroup,
    required this.percent,
    required this.rate,
    required this.topic,
    required this.status,
    required this.createdAt,
    required this.blog,
    required this.questions,
  });

  QuizModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    questionTimeLimit = json['questionTimeLimit'];
    illustratedImageUrl = json['illustratedImageUrl'];
    ageGroup = json['ageGroup'];
    percent = json['percent'];
    rate = json['rate'];
    topic = json['topic'];
    status = json['status'];
    createdAt = json['createdAt'];
    if (json['blog'] != null && json['blog'].isNotEmpty) {
      blog = BlogModel.fromJson(json['blog']);
    }

    if (json['questions'] != null && json['questions'].isNotEmpty) {
      questions = <QuestionModel>[];
      json['questions'].forEach((v) {
        questions.add(QuestionModel.fromJson(v));
      });
    } else {
      questions = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['questionTimeLimit'] = questionTimeLimit;
    data['illustratedImageUrl'] = illustratedImageUrl;
    data['ageGroup'] = ageGroup;
    data['percent'] = percent;
    data['rate'] = rate;
    data['topic'] = topic;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['blog'] = blog.toJson();
    data['listQuiz'] = questions.map((v) => v.toJson()).toList();
    return data;
  }
}
