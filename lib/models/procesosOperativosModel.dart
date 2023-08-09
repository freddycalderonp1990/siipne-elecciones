part of 'models.dart';

ProcesosOperativosModel procesosOperativosModelFromJson(String str) => ProcesosOperativosModel.fromJson(json.decode(str));

String procesosOperativosModelToJson(ProcesosOperativosModel data) => json.encode(data.toJson());

class ProcesosOperativosModel {
  ProcesosOperativosModel({
    this.procesosOperativos,
  });

  List<ProcesosOperativo> procesosOperativos;

  factory ProcesosOperativosModel.fromJson(Map<String, dynamic> json) => ProcesosOperativosModel(
    procesosOperativos: json["datos"] == null ? null : List<ProcesosOperativo>.from(json["datos"].map((x) => ProcesosOperativo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "datos": procesosOperativos == null ? null : List<dynamic>.from(procesosOperativos.map((x) => x.toJson())),
  };
}

class ProcesosOperativo {
  ProcesosOperativo({
    this.idDgoProcElec,
    this.idGenGeoSenplades,
    this.descProcElecc,
    this.fechaInici,
    this.fechaFin,
    this.tipo,

  });

  String idDgoProcElec;
  String idGenGeoSenplades;
  String descProcElecc;
  String fechaInici;
  String fechaFin;
  String tipo;


  factory ProcesosOperativo.fromJson(Map<String, dynamic> json) => ProcesosOperativo(
    idDgoProcElec: json["idDgoProcElec"] == null ? null : json["idDgoProcElec"],
    idGenGeoSenplades: json["idGenGeoSenplades"] == null ? null : json["idGenGeoSenplades"],
    descProcElecc: json["descProcElecc"] == null ? null : json["descProcElecc"],
    fechaInici: json["fechaInici"] == null ? null : json["fechaInici"],
    fechaFin: json["fechaFin"] == null ? null : json["fechaFin"],
    tipo: json["tipo"] == null ? null : json["tipo"],
  );

  Map<String, dynamic> toJson() => {
    "idDgoProcElec": idDgoProcElec == null ? null : idDgoProcElec,
    "idGenGeoSenplades": idGenGeoSenplades == null ? null : idGenGeoSenplades,
    "descProcElecc": descProcElecc == null ? null : descProcElecc,
    "fechaInici": fechaInici == null ? null : fechaInici,
    "fechaFin": fechaFin == null ? null : fechaFin,
    "tipo": tipo == null ? null : tipo,
  };
}
