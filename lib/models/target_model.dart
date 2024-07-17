import 'dart:convert';

class TargetModel {
  String id;
  DateTime startTime;
  DateTime endTime;
  String message;
  String memberId;
  List<MissionModel> missions;

  TargetModel({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.message,
    required this.memberId,
    required this.missions,
  });

  factory TargetModel.fromJson(Map<String, dynamic> json) {
    final missions = json['missions'].map<MissionModel>((mission) {
      return MissionModel.fromJson(mission);
    }).toList();
    return TargetModel(
      id: json['id'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      message: json['message'],
      memberId: json['memberId'],
      missions: missions,
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
  String taskTypeId;
  int amount;

  MissionModel({
    required this.taskTypeId,
    required this.amount,
  });

  factory MissionModel.fromJson(Map<String, dynamic> json) {
    return MissionModel(
      taskTypeId: json['taskTypeId'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'taskTypeId': taskTypeId,
      'amount': amount,
    };
  }
}

class TargetRequestModal {
  String startTime;
  String endTime;
  String message;
  String memberId;
  List<MissionModel> missions;

  TargetRequestModal({
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
