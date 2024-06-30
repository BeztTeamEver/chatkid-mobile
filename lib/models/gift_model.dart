class GiftModel {
  String? id;
  String? title;
  int? numberOfCoin;
  String? imageUrl;


  GiftModel(
      {this.id,
      this.title,
      this.numberOfCoin,
      this.imageUrl});

  GiftModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    numberOfCoin = json['numberOfCoin'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['numberOfCoin'] = this.numberOfCoin;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
