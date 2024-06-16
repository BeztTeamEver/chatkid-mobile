import 'dart:convert';

import 'package:chatkid_mobile/models/base_model.dart';

class TaskModel implements IBaseModel {
  @override
  String toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}

class TaskTypeModel {
  String id;
  String name;
  String? imageUrl;

  TaskTypeModel({
    required this.id,
    required this.name,
    this.imageUrl,
  });

  factory TaskTypeModel.fromJson(Map<String, dynamic> json) {
    return TaskTypeModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
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
