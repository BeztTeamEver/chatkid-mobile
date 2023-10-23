class Error {
  final String description;
  final int code;

  Error({required this.description, required this.code});

  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(
      description: json['description'],
      code: json['code'],
    );
  }
}
