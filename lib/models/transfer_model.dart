class TransferModel {
  late String id;
  late int diamond;
  late String createdAt;

  TransferModel({
    required this.id,
    required this.diamond,
    required this.createdAt,
  });

  TransferModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    diamond = json['diamond'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['diamond'] = diamond;
    data['createdAt'] = createdAt;
    return data;
  }
}