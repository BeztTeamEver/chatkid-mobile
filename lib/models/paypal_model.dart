class PaypalModel {
  String? id;
  String? status;
  late List<PaypalLinkModel> links;
  PaypalModel({required this.id, this.status, required this.links});

  PaypalModel.fromJson(Map<String, dynamic> json) {
    json['links'] = json['links'] != null
        ? (json['links'] as List)
            .map((e) => PaypalLinkModel.fromJson(e))
            .toList()
        : [];
    id = json['id'];
    status = json['status'];
    links = json['links'] as List<PaypalLinkModel>;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    return data;
  }
}

class PaypalLinkModel {
  String? href;
  String? rel;
  String? method;

  PaypalLinkModel({this.href, this.rel, this.method});

  PaypalLinkModel.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    rel = json['rel'];
    method = json['method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['href'] = href;
    data['rel'] = rel;
    data['method'] = method;
    return data;
  }
}

class PaypalRequestModel {
  double? amount;
  String? returnUrl;
  String? cancelUrl;

  PaypalRequestModel({required this.amount, this.returnUrl, this.cancelUrl});

  PaypalRequestModel.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    returnUrl = json['returnUrl'];
    cancelUrl = json['cancelUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['returnUrl'] = returnUrl;
    data['cancelUrl'] = cancelUrl;
    return data;
  }
}
