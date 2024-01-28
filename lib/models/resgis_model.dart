class RegisModel {
  String accessToken;

  RegisModel({required this.accessToken});

  factory RegisModel.fromJson(Map<String, dynamic> json) => RegisModel(
        accessToken: json['accessToken'],
      );
}
