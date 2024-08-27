import 'dart:convert';

import 'package:chatkid_mobile/models/base_model.dart';
import 'package:chatkid_mobile/models/paging_model.dart';

class HistoryModel extends BaseModel {
  final String id;
  final String title;
  final String? note;
  final String? createdAt;
  final String? updatedAt;
  HistoryModel({
    required this.id,
    required this.title,
    this.note,
    this.createdAt,
    this.updatedAt,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      id: json['id'],
      title: json['title'],
      note: json['note'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['title'] = this.title;
    data['note'] = this.note;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

class HistoryRequestModal {
  final String memberId;
  final PagingModel paging;

  HistoryRequestModal({
    required this.memberId,
    required this.paging,
  });

  factory HistoryRequestModal.fromJson(Map<String, dynamic> json) {
    return HistoryRequestModal(
      memberId: json['memberId'],
      paging: PagingModel.fromJson(json['paging']),
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['memberId'] = this.memberId;
    data['paging'] = this.paging.toMap();
    return data;
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

class HistoryRequestModel {
  String memberId;
  PagingModel paging;

  HistoryRequestModel({
    required this.memberId,
    required this.paging,
  });

  factory HistoryRequestModel.fromJson(Map<String, dynamic> json) {
    return HistoryRequestModel(
      memberId: json['memberId'],
      paging: PagingModel.fromJson(json['paging']),
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['memberId'] = this.memberId;
    data['paging'] = this.paging.toMap();
    return data;
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

class HistoryBotChatModel {
  final String id;
  final String content;
  final String? voiceUrl;
  final String? botVoiceUrl;
  final String reportStatus;
  final DateTime createdAt;
  final String answer;

  HistoryBotChatModel({
    required this.id,
    required this.content,
    this.voiceUrl,
    this.botVoiceUrl,
    required this.reportStatus,
    required this.createdAt,
    required this.answer,
  });

  factory HistoryBotChatModel.fromJson(Map<String, dynamic> json) {
    return HistoryBotChatModel(
      id: json['id'],
      content: json['content'],
      voiceUrl: json['voiceUrl'],
      reportStatus: json['reportStatus'],
      botVoiceUrl: json['botVoiceUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['content'] = this.content;
    data['voiceUrl'] = this.voiceUrl;
    data['botVoiceUrl'] = this.botVoiceUrl;
    data['reportStatus'] = this.reportStatus;
    data['createAt'] = this.createdAt.toIso8601String();
    data['answer'] = this.answer;
    return data;
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

class HistoryReportModel {
  final String? botQuestionId;
  final List<String>? reasons;

  HistoryReportModel({
    this.botQuestionId,
    this.reasons,
  });

  factory HistoryReportModel.fromJson(Map<String, dynamic> json) {
    return HistoryReportModel(
      botQuestionId: json['botQuestionId'],
      reasons: json['reasons'] != null
          ? List<String>.from(json['reasons'])
          : <String>[],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['botQuestionId'] = this.botQuestionId;
    data['reasons'] = this.reasons;
    return data;
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
