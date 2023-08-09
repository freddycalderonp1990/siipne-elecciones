// To parse this JSON data, do
//
//     final provinciaModel = provinciaModelFromJson(jsonString);

part of 'models.dart';


ProvinciaModel provinciaModelFromJson(String str) => ProvinciaModel.fromJson(json.decode(str));

String provinciaModelToJson(ProvinciaModel data) => json.encode(data.toJson());

class ProvinciaModel {
  ProvinciaModel({
    this.provincias,
  });

  List<Provincia> provincias;

  factory ProvinciaModel.fromJson(Map<String, dynamic> json) => ProvinciaModel(
    provincias: json["datos"] == null ? null : List<Provincia>.from(json["datos"].map((x) => Provincia.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "datos": provincias == null ? null : List<dynamic>.from(provincias.map((x) => x.toJson())),
  };
}

class Provincia {
  Provincia({
    this.idGenDivPolitica,
    this.genIdGenDivPolitica,
    this.idGenTipoDivision,
    this.descripcion,
    this.sigla,
    this.usuario,
    this.fecha,
    this.ip,
  });

  String idGenDivPolitica;
  String genIdGenDivPolitica;
  String idGenTipoDivision;
  String descripcion;
  String sigla;
  String usuario;
  String fecha;
  String ip;

  factory Provincia.fromJson(Map<String, dynamic> json) => Provincia(
    idGenDivPolitica: json["idGenDivPolitica"] == null ? null : json["idGenDivPolitica"],
    genIdGenDivPolitica: json["gen_idGenDivPolitica"] == null ? null : json["gen_idGenDivPolitica"],
    idGenTipoDivision: json["idGenTipoDivision"] == null ? null : json["idGenTipoDivision"],
    descripcion: json["descripcion"] == null ? null : json["descripcion"],
    sigla: json["sigla"] == null ? null : json["sigla"],
    usuario: json["usuario"] == null ? null : json["usuario"],
    fecha: json["fecha"] == null ? null : json["fecha"],
    ip: json["ip"] == null ? null : json["ip"],
  );

  Map<String, dynamic> toJson() => {
    "idGenDivPolitica": idGenDivPolitica == null ? null : idGenDivPolitica,
    "gen_idGenDivPolitica": genIdGenDivPolitica == null ? null : genIdGenDivPolitica,
    "idGenTipoDivision": idGenTipoDivision == null ? null : idGenTipoDivision,
    "descripcion": descripcion == null ? null : descripcion,
    "sigla": sigla == null ? null : sigla,
    "usuario": usuario == null ? null : usuario,
    "fecha": fecha == null ? null : fecha,
    "ip": ip == null ? null : ip,
  };
}
