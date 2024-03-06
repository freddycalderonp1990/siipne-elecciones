// To parse this JSON data, do
//
//     final recintosElectoralesAbiertosModel = recintosElectoralesAbiertosModelFromJson(jsonString);

part of '../models.dart';

RecintosElectoralesAbiertosModel recintosElectoralesAbiertosModelFromJson(
        String str) =>
    RecintosElectoralesAbiertosModel.fromJson(json.decode(str));

String recintosElectoralesAbiertosModelToJson(
        RecintosElectoralesAbiertosModel data) =>
    json.encode(data.toJson());

class RecintosElectoralesAbiertosModel {
  RecintosElectoralesAbiertosModel({
    this.recintosElectoralesAbiertos,
  });

  RecintosElectoralesAbiertos recintosElectoralesAbiertos;

  factory RecintosElectoralesAbiertosModel.fromJson(
          Map<String, dynamic> json) =>
      RecintosElectoralesAbiertosModel(
        recintosElectoralesAbiertos: json["datos"] == null
            ? null
            : RecintosElectoralesAbiertos.fromJson(json["datos"]),
      );

  Map<String, dynamic> toJson() => {
        "recintosElectoralesAbiertos": recintosElectoralesAbiertos == null
            ? null
            : recintosElectoralesAbiertos.toJson(),
      };
}

class RecintosElectoralesAbiertos {
  RecintosElectoralesAbiertos({
    this.idDgoCreaOpReci,
    this.descProcElecc,
    this.idDgoPerAsigOpe,
    this.idDgoProcElec,
    this.codigoRecinto,
    this.fechaIni,
    this.nomRecintoElec,
    this.idDgoReciElect,
    this.encargado,
    this.documento,
    this.cargo,
    this.descripcion,
    this.isJefe = false,
    this.isRecinto = false,
    this.idDgoTipoEje,
  });

  String idDgoCreaOpReci;
  String descProcElecc;
  String idDgoPerAsigOpe;
  //Se agrega para capturar el proceso u operativo seleccionado
  String idDgoProcElec;
  String codigoRecinto;
  String fechaIni;
  String nomRecintoElec;
  String idDgoReciElect;
  String encargado;
  String documento;
  String cargo;
  String descripcion;
  bool isJefe;
  bool isRecinto;

  //Se agrega esta variable para al macenar el tipo de eje seleccionado
  String idDgoTipoEje;

  factory RecintosElectoralesAbiertos.fromJson(Map<String, dynamic> json) =>
      RecintosElectoralesAbiertos(
        idDgoProcElec: ParseModel.parseToString(json["idDgoProcElec"]),
        descProcElecc: json["descProcElecc"] == null ? null : json["descProcElecc"],
        idDgoTipoEje: ParseModel.parseToString(json["idDgoTipoEje"]),
        idDgoCreaOpReci: ParseModel.parseToString(json["idDgoCreaOpReci"]),
        idDgoPerAsigOpe: ParseModel.parseToString(json["idDgoPerAsigOpe"]),
        codigoRecinto: ParseModel.parseToString(json["codigoRecinto"]),
        fechaIni: json["fechaIni"] == null ? null : json["fechaIni"],
        nomRecintoElec:
            json["nomRecintoElec"] == null ? null : json["nomRecintoElec"],
        idDgoReciElect:
        ParseModel.parseToString(json["idDgoReciElect"]),
        encargado: json["encargado"] == null ? null : json["encargado"],
        documento: json["documento"] == null ? null : json["documento"],
        cargo: json["cargo"] == null ? null : json["cargo"],
        descripcion: json["descripcion"] == null ? null : json["descripcion"],
        isJefe: json["cargo"] == null
            ? null
            : json["cargo"] == "J"
                ? true
                : false,
        isRecinto: json["isRecinto"] == null ? false : json["isRecinto"],
      );

  Map<String, dynamic> toJson() => {
        "idDgoCreaOpReci": idDgoCreaOpReci == null ? null : idDgoCreaOpReci,
        "idDgoPerAsigOpe": idDgoPerAsigOpe == null ? null : idDgoPerAsigOpe,
        "codigoRecinto": codigoRecinto == null ? null : codigoRecinto,
        "fechaIni": fechaIni == null ? null : fechaIni,
        "nomRecintoElec": nomRecintoElec == null ? null : nomRecintoElec,
        "idDgoReciElect": idDgoReciElect == null ? null : idDgoReciElect,
        "encargado": encargado == null ? null : encargado,
        "documento": documento == null ? null : documento,
        "cargo": cargo == null ? null : cargo,
        "descripcion": descripcion == null ? null : descripcion,
      };
}
