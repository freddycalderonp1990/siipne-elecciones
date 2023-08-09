part of 'models.dart';


ConfigAppModel configAppModelFromJson(String str) => ConfigAppModel.fromJson(json.decode(str));

String configAppModelToJson(ConfigAppModel data) => json.encode(data.toJson());

class ConfigAppModel {
  ConfigAppModel({
    this.appName,
    this.codeAndroid,
    this.codeIos,
    this.fechaCambio,
  });

  String appName;
  String codeAndroid;
  String codeIos;
  String fechaCambio;

  factory ConfigAppModel.fromJson(Map<String, dynamic> json) => ConfigAppModel(
    appName: json["appName"] == null ? "null" : json["appName"],
    codeAndroid: json["codeAndroid"] == null ? "null" : json["codeAndroid"],
    codeIos: json["codeIos"] == null ? "null" : json["codeIos"],
    fechaCambio: json["fechaCambio"] == null ? "null" : json["fechaCambio"],
  );

  Map<String, dynamic> toJson() => {
    "appName": appName == null ? "null" : appName,
    "codeAndroid": codeAndroid == null ? "null" : codeAndroid,
    "codeIos": codeIos == null ? "null" : codeIos,
    "fechaCambio": fechaCambio == null ? "null" : fechaCambio,
  };
}
