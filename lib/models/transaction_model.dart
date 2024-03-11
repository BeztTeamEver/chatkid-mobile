class TransactionModel {
  String? id;
  String? subscriptionId;
  String? memberId;
  String? paymentMethodId;
  String? createdAt;
  String? status;
  String? identifier;

  TransactionModel(
      {this.id,
      this.subscriptionId,
      this.memberId,
      this.paymentMethodId,
      this.createdAt,
      this.status,
      this.identifier});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subscriptionId = json['subscriptionId'];
    memberId = json['memberId'];
    paymentMethodId = json['paymentMethodId'];
    createdAt = json['createdAt'];
    status = json['status'];
    identifier = json['identifier'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subscriptionId'] = subscriptionId;
    data['memberId'] = memberId;
    data['paymentMethodId'] = paymentMethodId;
    data['createdAt'] = createdAt;
    data['status'] = status;
    data['identifier'] = identifier;
    return data;
  }
}

class CreateTransactionModel {
  String? subscriptionId;
  String? paymentMethodId;

  CreateTransactionModel(
      {this.subscriptionId,
      this.paymentMethodId = "ae51672d-e58c-4ba6-891e-c1e5165c487b"});

  CreateTransactionModel.fromJson(Map<String, dynamic> json) {
    subscriptionId = json['subscriptionId'];
    paymentMethodId = json['paymentMethodId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subscriptionId'] = subscriptionId;
    data['paymentMethodId'] = paymentMethodId;
    return data;
  }
}
