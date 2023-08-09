part of  'modelsMiUpc.dart';

RegistroUsuarioModel registroUsuarioModelFromJson(String str) => RegistroUsuarioModel.fromJson(json.decode(str));

String registroUsuarioModelToJson(RegistroUsuarioModel data) => json.encode(data.toJson());

class RegistroUsuarioModel {
  RegistroUsuarioModel({
    this.datoPer,
    this.code,
  });

  List<String> datoPer;
  String code;

  factory RegistroUsuarioModel.fromJson(Map<String, dynamic> json) => RegistroUsuarioModel(
    datoPer: json["datoPer"] == null ? null : List<String>.from(json["datoPer"].map((x) => x)),
    code: json["code"] == null ? null : json["code"],
  );

  Map<String, dynamic> toJson() => {
    "datoPer": datoPer == null ? null : List<dynamic>.from(datoPer.map((x) => x)),
    "code": code == null ? null : code,
  };
}

