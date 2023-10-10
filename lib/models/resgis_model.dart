class RegisModel {
  String verifyToken;

  RegisModel({required this.verifyToken});

  factory RegisModel.fromJson(Map<String, dynamic> json) => RegisModel(
        verifyToken: json['verifyToken'],
      );
}
