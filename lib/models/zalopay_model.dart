class ZaloPayModel {
  late String zp_trans_token;
  late String order_url;
  late String order_token;

  ZaloPayModel({
    required this.zp_trans_token,
    required this.order_url,
    required this.order_token,
  });

  ZaloPayModel.fromJson(Map<String, dynamic> json) {
    zp_trans_token = json['zp_trans_token'];
    order_url = json['order_url'];
    order_token = json['order_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['zp_trans_token'] = zp_trans_token;
    data['order_url'] = order_url;
    data['order_token'] = order_token;
    return data;
  }
}

class OrderCaptureModel {
  String? userId;
  String? orderId;
  int? energy;

  OrderCaptureModel({this.userId, this.orderId, this.energy});

  OrderCaptureModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    orderId = json['orderId'];
    energy = json['energy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['orderId'] = orderId;
    data['energy'] = energy;
    return data;
  }
}
