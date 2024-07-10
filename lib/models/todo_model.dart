import 'dart:convert';

import 'package:chatkid_mobile/models/base_model.dart';
import 'package:chatkid_mobile/models/paging_model.dart';
import 'package:dart_date/dart_date.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class TodoFrequency {}

class TaskModel implements IBaseModel {
  String id;
  String taskTypeId;
  String memberId;
  DateTime startTime;
  DateTime? finishTime;
  String? evidence;
  List<TodoFrequency>? frequency;
  String note;
  String status;
  TaskTypeModel taskType;

  TaskModel({
    required this.id,
    required this.taskTypeId,
    required this.memberId,
    required this.startTime,
    this.finishTime,
    this.evidence,
    this.frequency,
    required this.note,
    required this.status,
    required this.taskType,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    final frequency = json['frequency'].map<TodoFrequency>((freq) {
      return TodoFrequency();
    }).toList();

    // TODO: handle frequency list
    return TaskModel(
      id: json['id'],
      taskTypeId: json['taskTypeId'],
      memberId: json['memberId'],
      startTime: DateTime.parse(json['startTime']),
      finishTime: json['finishTime'] != null
          ? DateTime.parse(json['finishTime'])
          : null,
      evidence: json['evidence'],
      note: json['note'],
      frequency: frequency,
      status: json['status'],
      taskType: TaskTypeModel.fromJson(json['taskType']),
    );
  }

  @override
  String toJson() {
    return jsonEncode(toMap());
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskTypeId': taskTypeId,
      'memberId': memberId,
      'startTime': startTime.toIso8601String(),
      'finishTime': finishTime?.toIso8601String(),
      'evidence': evidence,
      'frequency': frequency,
      'note': note,
      'status': status,
      'taskType': taskType.toJson(),
    };
  }
}

class TaskTypeModel {
  String id;
  String name;
  String? imageUrl;
  String? imageHomeUrl;
  bool? isFavorited;
  TaskTypeModel({
    required this.id,
    required this.name,
    this.imageUrl,
    this.imageHomeUrl,
    this.isFavorited,
  });

  factory TaskTypeModel.fromJson(Map<String, dynamic> json) {
    return TaskTypeModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      imageHomeUrl: json['imageHomeUrl'],
      isFavorited: json['isFavorited'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'imageHomeUrl': imageHomeUrl,
      'isFavorited': isFavorited,
    };
  }

  String toJson() => jsonEncode(toMap());
}

class TaskCategoryModel implements IBaseModel {
  String id;
  String name;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<TaskTypeModel> taskTypes;

  TaskCategoryModel({
    required this.id,
    required this.name,
    this.createdAt,
    this.updatedAt,
    required this.taskTypes,
  });

  factory TaskCategoryModel.fromJson(Map<String, dynamic> json) {
    return TaskCategoryModel(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      taskTypes: json['taskTypes']
          .map<TaskTypeModel>((taskType) => TaskTypeModel.fromJson(taskType))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'taskTypes': taskTypes.map((taskType) => taskType.toJson()).toList(),
    };
  }

  String toJson() => jsonEncode(toMap());
}

class TodoFilter {
  String? status;
  DateTime date;

  TodoFilter({this.status, required this.date});
}

class TodoRequestModel {
  String memberId;
  PagingModelWithFilter<TodoFilter> paging;

  TodoRequestModel({required this.memberId, required this.paging});
}

class TodoCreateModel {
  String memberId;
  String taskTypeId;
  DateTime startTime;
  DateTime endTime;
  int giftTicket;
  List<String>? frequency;
  String note;

  TodoCreateModel({
    required this.memberId,
    required this.taskTypeId,
    required this.startTime,
    required this.endTime,
    this.frequency,
    required this.giftTicket,
    required this.note,
  });

  factory TodoCreateModel.fromJson(Map<String, dynamic> json) {
    return TodoCreateModel(
      memberId: json['memberId'],
      taskTypeId: json['taskTypeId'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      frequency: json['frequency'],
      giftTicket: int.parse(json['giftTicket'] ?? "0"),
      note: json['note'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'memberId': memberId,
      'taskTypeId': taskTypeId,
      'startTime': "${startTime.toIso8601String()}Z",
      'endTime': "${endTime.toIso8601String()}Z",
      'frequency': frequency,
      'giftTicket': giftTicket,
      'note': note,
    };
  }

  String toJson() => jsonEncode(toMap());
}

class TaskListModel {
  RxList<TaskModel> pendingTasks;
  RxList<TaskModel> completedTasks;
  RxList<TaskModel> expiredTasks;
  RxList<TaskModel> canceledTasks;

  TaskListModel({
    required this.pendingTasks,
    required this.completedTasks,
    required this.expiredTasks,
    required this.canceledTasks,
  });
}
