// To parse this JSON data, do
//
//     final resgistroPersEnRecElectoralModel = resgistroPersEnRecElectoralModelFromJson(jsonString);

part of '../models.dart';

ResgistroPersEnRecElectoralModel resgistroPersEnRecElectoralModelFromJson(String str) => ResgistroPersEnRecElectoralModel.fromJson(json.decode(str));

String resgistroPersEnRecElectoralModelToJson(ResgistroPersEnRecElectoralModel data) => json.encode(data.toJson());

class ResgistroPersEnRecElectoralModel {
  ResgistroPersEnRecElectoralModel({
    this.resgistroPersEnRecElectoral,
  });

  ResgistroPersEnRecElectoral resgistroPersEnRecElectoral;

  factory ResgistroPersEnRecElectoralModel.fromJson(Map<String, dynamic> json) => ResgistroPersEnRecElectoralModel(
    resgistroPersEnRecElectoral: json["datos"] == null ? null : ResgistroPersEnRecElectoral.fromJson(json["datos"]),
  );

  Map<String, dynamic> toJson() => {
    "resgistroPersEnRecElectoral": resgistroPersEnRecElectoral == null ? null : resgistroPersEnRecElectoral.toJson(),
  };
}

class ResgistroPersEnRecElectoral {
  ResgistroPersEnRecElectoral({
    this.idDgoPerAsigOpe,
    this.codigoRecinto,
    this.fechaIni,
    this.nomRecintoElec,
    this.encargado,
    this.documento,
  });

  String idDgoPerAsigOpe;
  String codigoRecinto;
  String fechaIni;
  String nomRecintoElec;
  String encargado;
  String documento;

  factory ResgistroPersEnRecElectoral.fromJson(Map<String, dynamic> json) => ResgistroPersEnRecElectoral(
    idDgoPerAsigOpe: json["idDgoPerAsigOpe"] == null ? null : json["idDgoPerAsigOpe"],
    codigoRecinto: json["codigoRecinto"] == null ? null : json["codigoRecinto"],
    fechaIni: json["fechaIni"] == null ? null : json["fechaIni"],
    nomRecintoElec: json["nomRecintoElec"] == null ? null : json["nomRecintoElec"],
    encargado: json["encargado"] == null ? null : json["encargado"],
    documento: json["documento"] == null ? null : json["documento"],
  );

  Map<String, dynamic> toJson() => {
    "idDgoPerAsigOpe": idDgoPerAsigOpe == null ? null : idDgoPerAsigOpe,
    "codigoRecinto": codigoRecinto == null ? null : codigoRecinto,
    "fechaIni": fechaIni == null ? null : fechaIni,
    "nomRecintoElec": nomRecintoElec == null ? null : nomRecintoElec,
    "encargado": encargado == null ? null : encargado,
    "documento": documento == null ? null : documento,
  };
}
