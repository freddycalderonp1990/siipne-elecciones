// To parse this JSON data, do
//
//     final datosPersModel = datosPersModelFromJson(jsonString);

part of 'models.dart';
DatosPersModel datosPersModelFromJson(String str) => DatosPersModel.fromJson(json.decode(str));

String datosPersModelToJson(DatosPersModel data) => json.encode(data.toJson());

class DatosPersModel {
  DatosPersModel({
    this.datosPers,
  });

  List<DatosPer> datosPers;

  factory DatosPersModel.fromJson(Map<String, dynamic> json) => DatosPersModel(
    datosPers: json["datos"] == null ? null : List<DatosPer>.from(json["datos"].map((x) => DatosPer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "dataPersona": datosPers == null ? null : List<dynamic>.from(datosPers.map((x) => x.toJson())),
  };
}

class DatosPer {
  DatosPer({
    this.idGenPersona,
    this.siglas,
    this.apenom,
    this.poliRegistrado,
    this.documento
  });

  String idGenPersona;
  String siglas;
  String apenom;
  String documento;
  bool poliRegistrado;

  factory DatosPer.fromJson(Map<String, dynamic> json) => DatosPer(
    idGenPersona:  ParseModel.parseToString(json["idGenPersona"]),
    siglas: json["siglas"] == null ? '' : json["siglas"],
    documento: json["documento"] == null ? '' : json["documento"],
    apenom: json["apenom"] == null ? null : json["apenom"],
    poliRegistrado: json["poliRegistrado"] == null ? null : json["poliRegistrado"],
  );

  Map<String, dynamic> toJson() => {
    "idGenPersona": idGenPersona == null ? null : idGenPersona,
    "siglas": siglas == null ? null : siglas,
    "documento": documento == null ? null : documento,
    "apenom": apenom == null ? null : apenom,
    "poliRegistrado": poliRegistrado == null ? null : poliRegistrado,
  };
}
