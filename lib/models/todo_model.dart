import 'dart:convert';

import 'package:chatkid_mobile/models/base_model.dart';
import 'package:chatkid_mobile/models/paging_model.dart';
import 'package:dart_date/dart_date.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class TaskModel implements IBaseModel {
  String id;
  String taskTypeId;
  String memberId;
  DateTime startTime;
  DateTime endTime;
  String assigneerId;
  DateTime? finishTime;

  String? evidence;
  List<String>? frequency;
  int? numberOfCoin;
  String note;
  String status;
  TaskTypeModel taskType;
  String? feedbackVoice;
  String? feedbackEmoji;
  String? feedbackLevel;

  TaskModel({
    required this.id,
    required this.taskTypeId,
    required this.memberId,
    required this.startTime,
    this.finishTime,
    this.numberOfCoin,
    required this.assigneerId,
    required this.endTime,
    this.evidence,
    this.frequency,
    required this.note,
    required this.status,
    required this.taskType,
    this.feedbackVoice,
    this.feedbackEmoji,
    this.feedbackLevel,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    List<String>? frequency = [];
    if (json['frequency'] != null && json['frequency'].isNotEmpty) {
      frequency =
          json['frequency'].map<String>((item) => item.toString()).toList();
    }

    // TODO: handle frequency list
    return TaskModel(
      id: json['id'],
      taskTypeId: json['taskTypeId'],
      assigneerId: json['assigneerId'],
      endTime: DateTime.parse(json['endTime']),
      memberId: json['memberId'],
      startTime: DateTime.parse(json['startTime']),
      numberOfCoin: json['numberOfCoin'],
      finishTime: json['finishTime'] != null
          ? DateTime.parse(json['finishTime'])
          : null,
      evidence: json['evidence'],
      note: json['note'],
      frequency: frequency,
      status: json['status'],
      feedbackVoice: json['feedbackVoice'],
      feedbackEmoji: json['feedbackEmoji'],
      feedbackLevel: json['feedbackLevel'],
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
      'asssigneerId': assigneerId,
      'endTime': endTime.toIso8601String(),
      'frequency': frequency,
      'numberOfCoin': numberOfCoin,
      'note': note,
      'status': status,
      'feedbackVoice': feedbackVoice,
      'feedbackEmoji': feedbackEmoji,
      'feedbackLevel': feedbackLevel,
      'taskType': taskType.toJson(),
    };
  }
}

class TaskTypeImageModel {
  String name;
  String imageUrl;
  String? imageHomeUrl;
  TaskTypeImageModel({
    required this.name,
    required this.imageUrl,
    this.imageHomeUrl,
  });
  factory TaskTypeImageModel.fromJson(Map<String, dynamic> json) {
    return TaskTypeImageModel(
      name: json['name'],
      imageUrl: json['imageUrl'],
      imageHomeUrl: json['imageHomeUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'imageHomeUrl': imageHomeUrl,
    };
  }

  String toJson() => jsonEncode(toMap());
}

class TaskTypeModel {
  String id;
  String name;
  String? imageUrl;
  String? imageHomeUrl;
  String? status;
  bool? isFavorited;
  List<String>? hintQuestions;
  TaskTypeModel({
    required this.id,
    required this.name,
    this.status,
    this.imageUrl,
    this.imageHomeUrl,
    this.isFavorited,
    this.hintQuestions,
  });

  factory TaskTypeModel.fromJson(Map<String, dynamic> json) {
    final hintQuestions = json['hintQuestions'].map<String>((hint) {
      return hint.toString();
    }).toList();
    return TaskTypeModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      imageHomeUrl: json['imageHomeUrl'],
      status: json['status'],
      hintQuestions: hintQuestions,
      isFavorited: json['isFavorited'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'status': status,
      'imageHomeUrl': imageHomeUrl,
      'isFavorited': isFavorited,
      'hintQuestions': hintQuestions,
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

class TaskCategoryImage {
  String id;
  String name;
  List<TaskTypeImageModel> taskType;

  TaskCategoryImage({
    required this.id,
    required this.name,
    required this.taskType,
  });

  factory TaskCategoryImage.fromJson(Map<String, dynamic> json) {
    return TaskCategoryImage(
      id: json['id'],
      name: json['name'],
      taskType: json['taskTypes']
          .map<TaskTypeImageModel>(
              (taskType) => TaskTypeImageModel.fromJson(taskType))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'taskTypes': taskType.map((taskType) => taskType.toJson()).toList(),
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
  List<String>? memberIds;
  String taskTypeId;
  DateTime startTime;
  DateTime endTime;

  int numberOfCoin;
  List<String?>? frequency;
  String note;

  TodoCreateModel({
    this.memberIds,
    required this.taskTypeId,
    required this.startTime,
    required this.endTime,
    this.frequency,
    required this.numberOfCoin,
    required this.note,
  });

  factory TodoCreateModel.fromJson(Map<String, dynamic> json) {
    return TodoCreateModel(
      taskTypeId: json['taskTypeId'],
      memberIds: json['memberIds'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      frequency: json['frequency'],
      numberOfCoin: json['numberOfCoin'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toMap() {
    final memberIds = this.memberIds?.map((e) => e).toList();
    final result = {
      'memberIds': memberIds,
      'taskTypeId': taskTypeId,
      'startTime': "${startTime.toIso8601String()}Z",
      'endTime': "${endTime.toIso8601String()}Z",
      'frequency': frequency,
      'numberOfCoin': numberOfCoin,
      'note': note,
    };

    if (memberIds == null) {
      result.remove('memberIds');
    }
    return result;
  }

  String toJson() => jsonEncode(toMap());
}

class RequestTaskTypeCreateModel extends TaskTypeImageModel {
  String taskCategoryId;

  RequestTaskTypeCreateModel({
    required this.taskCategoryId,
    required String name,
    required String imageUrl,
    String? imageHomeUrl,
  }) : super(name: name, imageUrl: imageUrl, imageHomeUrl: imageHomeUrl);

  factory RequestTaskTypeCreateModel.fromJson(Map<String, dynamic> json) {
    return RequestTaskTypeCreateModel(
      taskCategoryId: json['taskCategoryId'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      imageHomeUrl: json['imageHomeUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'taskCategoryId': taskCategoryId,
      'name': name,
      'imageUrl': imageUrl,
      'imageHomeUrl': imageHomeUrl,
    };
  }

  String toJson() => jsonEncode(toMap());
}

class TaskListModel {
  RxList<TaskModel> availableTasks;
  RxList<TaskModel> inprogressTasks;
  RxList<TaskModel> pendingTasks;
  RxList<TaskModel> completedTasks;
  RxList<TaskModel> expiredTasks;
  RxList<TaskModel> canceledTasks;
  RxList<TaskModel> notCompletedTasks;

  TaskListModel({
    required this.availableTasks,
    required this.inprogressTasks,
    required this.pendingTasks,
    required this.completedTasks,
    required this.expiredTasks,
    required this.canceledTasks,
    required this.notCompletedTasks,
  });

  clear() {
    availableTasks.clear();
    inprogressTasks.clear();
    pendingTasks.clear();
    completedTasks.clear();
    expiredTasks.clear();
    canceledTasks.clear();
    notCompletedTasks.clear();
  }
}
