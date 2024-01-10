class PaginationResponseModel {
  final int? pageNumber;
  final int? pageSize;
  final int? totalItem;
  final List<dynamic> items;

  PaginationResponseModel(
      {this.pageNumber, this.pageSize, this.totalItem, required this.items});

  factory PaginationResponseModel.fromJson(Map<String, dynamic> json) {
    return PaginationResponseModel(
        pageNumber: json['pageNumber'],
        pageSize: json['pageSize'],
        totalItem: json['totalItem'],
        items: json['items']);
  }
}
