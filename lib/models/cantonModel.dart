// To parse this JSON data, do
//
//     final provinciaModel = provinciaModelFromJson(jsonString);

part of 'models.dart';


CantonModel cantonModelFromJson(String str) => CantonModel.fromJson(json.decode(str));

String cantonModelToJson(CantonModel data) => json.encode(data.toJson());

class CantonModel {
  CantonModel({
    this.canton,
  });

  List<Canton> canton;

  factory CantonModel.fromJson(Map<String, dynamic> json) => CantonModel(
    canton: json["datos"] == null ? null : List<Canton>.from(json["datos"].map((x) => Canton.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "datos": canton == null ? null : List<dynamic>.from(canton.map((x) => x.toJson())),
  };
}

class Canton {
  Canton({
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

  factory Canton.fromJson(Map<String, dynamic> json) => Canton(
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
