import 'dart:convert';

import 'package:chatkid_mobile/models/base_model.dart';
import 'package:chatkid_mobile/models/paging_modal.dart';

class HistoryModel extends BaseModel {
  final String id;
  final String title;
  final String? note;

  HistoryModel({
    required this.id,
    required this.title,
    this.note,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      id: json['id'],
      title: json['title'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['title'] = this.title;
    data['note'] = this.note;
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
