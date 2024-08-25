class StatisticModel {
  late String taskCategory;
  late int count;

  StatisticModel({required this.taskCategory, required this.count});

  StatisticModel.fromJson(Map<String, dynamic> json) {
    taskCategory = json['taskCategory'];
    count = json['count'];
  }
}

class StatisticTaskModel {
  late int totalTasks;
  late int completedTasks;
  late int expiredTasks;
  late List<StatisticModel> statistic;

  StatisticTaskModel({
    required this.totalTasks,
    required this.completedTasks,
    required this.expiredTasks,
    required this.statistic,
  });

  StatisticTaskModel.fromJson(Map<String, dynamic> json) {
    totalTasks = json['totalTasks'];
    completedTasks = json['completedTasks'];
    expiredTasks = json['expiredTasks'];
    statistic = json['statistic'].map<StatisticModel>((e) => StatisticModel.fromJson(e)).toList();
  }
}

class FeedbackModel {
  late String imageUrl;
  late int count;

  FeedbackModel({required this.imageUrl, required this.count});

  FeedbackModel.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    count = json['count'];
  }
}

class StatisticEmotionModel {
  late String taskTypeId;
  late String taskType;
  late String taskTypeImageUrl;
  late int taskCount;
  late List<FeedbackModel> feedbackEmojis;

  StatisticEmotionModel({
    required this.taskTypeId,
    required this.taskType,
    required this.taskTypeImageUrl,
    required this.taskCount,
    required this.feedbackEmojis,
  });

  StatisticEmotionModel.fromJson(Map<String, dynamic> json) {
    taskTypeId = json['taskTypeId'];
    taskType = json['taskType'];
    taskTypeImageUrl = json['taskTypeImageUrl'];
    taskCount = json['taskCount'];
    feedbackEmojis = json['feedbackEmojis'].map<FeedbackModel>((e) => FeedbackModel.fromJson(e)).toList();
  }
}
