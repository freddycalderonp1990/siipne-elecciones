part of 'models.dart';

CabeceraMsjApisModel cabeceraMsjApisModelFromJson(String str) => CabeceraMsjApisModel.fromJson(json.decode(str));

String cabeceraMsjApisModelToJson(CabeceraMsjApisModel data) => json.encode(data.toJson());

class CabeceraMsjApisModel {
  CabeceraMsjApisModel({
    this.success,
    this.statusCode,
    this.message,
    this.data
  });

  bool success;
  int statusCode;
  String message;
  Map<String, dynamic> data;

  factory CabeceraMsjApisModel.fromJson(Map<String, dynamic> json) => CabeceraMsjApisModel(
    success: ParseModel.parseToBool(json["success"]),
    statusCode: ParseModel.parseToInt(json["status_code"] ),
    message: ParseModel.parseToString(json["message"] ),
    data: json["data"] == null ? null : json["data"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "status_code": statusCode == null ? null : statusCode,
    "message": message == null ? null : message,
  };
}
