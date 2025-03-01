// To parse this JSON data, do
//
//     final datosRecintoElectoral = datosRecintoElectoralFromJson(jsonString);

part of '../models.dart';

DatosRecintoElectoral datosRecintoElectoralFromJson(String str) => DatosRecintoElectoral.fromJson(json.decode(str));

String datosRecintoElectoralToJson(DatosRecintoElectoral data) => json.encode(data.toJson());

class DatosRecintoElectoral {
  DatosRecintoElectoral({
    this.datosRecintoElectoral,
  });

  DatosRecintoElectoralClass datosRecintoElectoral;

  factory DatosRecintoElectoral.fromJson(Map<String, dynamic> json) => DatosRecintoElectoral(
    datosRecintoElectoral: json["datos"] == null ? null : DatosRecintoElectoralClass.fromJson(json["datos"]),
  );

  Map<String, dynamic> toJson() => {
    "datosRecintoElectoral": datosRecintoElectoral == null ? null : datosRecintoElectoral.toJson(),
  };
}

class DatosRecintoElectoralClass {
  DatosRecintoElectoralClass({
    this.idDgoReciElect,
    this.nomRecintoElec,
    this.idDgoTipoEje,
    this.encargado,
    this.documento,
    this.sexoPerson,

  });

  String idDgoReciElect;
  String nomRecintoElec;
  String idDgoTipoEje;
  String encargado;
  String documento;
  String sexoPerson;


  factory DatosRecintoElectoralClass.fromJson(Map<String, dynamic> json) => DatosRecintoElectoralClass(
    idDgoReciElect: ParseModel.parseToString(json["idDgoReciElect"]),
    nomRecintoElec: ParseModel.parseToString(json["nomRecintoElec"] ),
    idDgoTipoEje: ParseModel.parseToString(json["idDgoTipoEje"]),
    encargado: ParseModel.parseToString(json["encargado"]),
    documento: ParseModel.parseToString(json["documento"] ),
    sexoPerson: ParseModel.parseToString(json["sexoPerson"] ),

  );

  Map<String, dynamic> toJson() => {
    "nomRecintoElec": nomRecintoElec == null ? null : nomRecintoElec,
    "encargado": encargado == null ? null : encargado,
    "documento": documento == null ? null : documento,
    "sexoPerson": sexoPerson == null ? null : sexoPerson,
  };
}
