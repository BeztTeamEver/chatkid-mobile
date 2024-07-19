import 'dart:convert';

import 'package:path/path.dart';

class TargetModel {
  String id;
  DateTime startTime;
  DateTime endTime;
  String message;
  String memberId;
  List<MissionModel> missions;
  int totalProgress;
  int currentProgress;

  TargetModel({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.message,
    required this.memberId,
    required this.missions,
    this.currentProgress = 0,
    this.totalProgress = 0,
  });

  factory TargetModel.fromJson(Map<String, dynamic> json) {
    int totalProgress = 0;
    int currentProgress = 0;
    final missions = json['missions'].map<MissionModel>((mission) {
      int quanity = mission['quantity'] ?? 0;
      int progress = mission['progress'] ?? 0;
      totalProgress += quanity;
      currentProgress += progress;
      return MissionModel.fromJson(mission);
    }).toList();
    return TargetModel(
      id: json['id'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      message: json['message'],
      memberId: json['memberId'],
      missions: missions,
      totalProgress: totalProgress,
      currentProgress: currentProgress,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'message': message,
      'memberId': memberId,
      'missions': missions,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

class MissionModel {
  String? id;
  String? name;
  String? imageUrl;
  int? quantity;
  int? progress;
  String? taskTypeId;
  int? amount;

  MissionModel({
    this.taskTypeId,
    this.amount,
    this.id,
    this.name,
    this.imageUrl,
    this.quantity,
    this.progress,
  });

  factory MissionModel.fromJson(Map<String, dynamic> json) {
    return MissionModel(
      taskTypeId: json['taskTypeId'],
      amount: json['amount'],
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'taskTypeId': taskTypeId,
      'amount': amount,
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'progress': progress,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

class TargetRequestModal {
  DateTime startTime;
  DateTime endTime;
  String message;
  String? memberId;
  List<MissionModel> missions;

  TargetRequestModal({
    required this.startTime,
    required this.endTime,
    required this.message,
    required this.memberId,
    required this.missions,
  });

  factory TargetRequestModal.fromJson(Map<String, dynamic> json) {
    final missions = json['missions'].map<MissionModel>((mission) {
      return MissionModel.fromJson(mission);
    }).toList();
    return TargetRequestModal(
      startTime: json['startTime'],
      endTime: json['endTime'],
      message: json['message'],
      memberId: json['memberId'],
      missions: missions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'startTime': '${startTime.toIso8601String()}Z',
      'endTime': '${endTime.toIso8601String()}Z',
      'message': message,
      'memberId': memberId,
      'missions': missions.map((v) => v.toMap()).toList(),
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

class TargetFormModel {
  DateTime startTime;
  DateTime endTime;
  String message;
  String memberId;
  List<MissionModel> missions;

  TargetFormModel({
    required this.startTime,
    required this.endTime,
    required this.message,
    required this.memberId,
    required this.missions,
  });

  Map<String, dynamic> toMap() {
    return {
      'startTime': startTime,
      'endTime': endTime,
      'message': message,
      'memberId': memberId,
      'missions': missions.map((v) => v.toMap()).toList(),
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
