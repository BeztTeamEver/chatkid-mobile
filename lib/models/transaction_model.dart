import 'package:chatkid_mobile/models/package_model.dart';

class TransactionModel {
  late String id;
  late String packageId;
  late String memberId;
  late String status;
  late String createdAt;
  late PackageModel package;

  TransactionModel({
    required this.id,
    required this.packageId,
    required this.memberId,
    required this.createdAt,
    required this.status,
    required this.package,
  });

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packageId = json['packageId'];
    memberId = json['memberId'];
    createdAt = json['createdAt'];
    status = json['status'];
    package = PackageModel.fromJson(json['package']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['packageId'] = packageId;
    data['memberId'] = memberId;
    data['createdAt'] = createdAt;
    data['status'] = status;
    data['package'] = package;
    return data;
  }
}

class CreateTransactionModel {
  String? packageId;
  String? paymentMethodId;

  CreateTransactionModel(
      {this.packageId,
      this.paymentMethodId = "ae51672d-e58c-4ba6-891e-c1e5165c487b"});

  CreateTransactionModel.fromJson(Map<String, dynamic> json) {
    packageId = json['packageId'];
    paymentMethodId = json['paymentMethodId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['packageId'] = packageId;
    data['paymentMethodId'] = paymentMethodId;
    return data;
  }
}
