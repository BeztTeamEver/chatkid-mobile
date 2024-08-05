import 'dart:convert';

class QuestionModel {
  late String id;
  late String text;
  late List<String> answerOptions;
  late String correctAnswer;
  late String illustratedImageUrl;

  QuestionModel({
    required this.id,
    required this.text,
    required this.answerOptions,
    required this.correctAnswer,
    required this.illustratedImageUrl,
  });

  QuestionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    answerOptions = json['answerOptions'].cast<String>();
    correctAnswer = json['correctAnswer'];
    illustratedImageUrl = json['illustratedImageUrl'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['answerOptions'] = answerOptions;
    data['correctAnswer'] = correctAnswer;
    data['illustratedImageUrl'] = illustratedImageUrl;
    return data;
  }

  String toJson() => jsonEncode(toMap());
}
