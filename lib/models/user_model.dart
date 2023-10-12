class UserModel {
  String id;
  String? avatarUrl;
  String? password;
  String? name;
  String? role;
  int status;
  String? familyId;
  String? deviceToken;

  UserModel(
      {required this.id,
      this.avatarUrl,
      this.password,
      this.name,
      this.role,
      required this.status,
      this.familyId,
      this.deviceToken});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      avatarUrl: json['avatarUrl'],
      password: json['password'],
      name: json['name'],
      role: json['role'],
      status: json['status'],
      familyId: json['familyId'],
      deviceToken: json['deviceToken'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['avatarUrl'] = avatarUrl;
    data['password'] = password;
    data['name'] = name;
    data['role'] = role;
    data['status'] = status;
    data['familyId'] = familyId;
    data['deviceToken'] = deviceToken;
    return data;
  }
}
