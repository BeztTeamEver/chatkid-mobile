abstract class IBaseModel {
  IBaseModel.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toMap();
  String toJson();
}

class BaseModel implements IBaseModel {
  @override
  BaseModel.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }

  BaseModel();

  @override
  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }

  @override
  String toJson() {
    throw UnimplementedError();
  }
}
