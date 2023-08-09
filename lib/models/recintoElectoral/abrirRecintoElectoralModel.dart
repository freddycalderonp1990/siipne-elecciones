// To parse this JSON data, do
//
//     final abrirRecintoElectoralModel = abrirRecintoElectoralModelFromJson(jsonString);

part of '../models.dart';

AbrirRecintoElectoralModel abrirRecintoElectoralModelFromJson(String str) => AbrirRecintoElectoralModel.fromJson(json.decode(str));

String abrirRecintoElectoralModelToJson(AbrirRecintoElectoralModel data) => json.encode(data.toJson());

class AbrirRecintoElectoralModel {
  AbrirRecintoElectoralModel({
    this.abrirRecintoElectoral,
  });

  AbrirRecintoElectoral abrirRecintoElectoral;

  factory AbrirRecintoElectoralModel.fromJson(Map<String, dynamic> json) => AbrirRecintoElectoralModel(
    abrirRecintoElectoral: json["datos"] == null ? null : AbrirRecintoElectoral.fromJson(json["datos"]),
  );

  Map<String, dynamic> toJson() => {
    "AbrirRecintoElectoral": abrirRecintoElectoral == null ? null : abrirRecintoElectoral.toJson(),
  };
}

class AbrirRecintoElectoral {
  AbrirRecintoElectoral({
    this.idDgoCreaOpReci,
    this.idDgoReciElect,
    this.idGenPersona,
    this.estado="Sin Estado",
    this.fechaIni,
    this.fechaFin,
    this.usuario,
    this.fecha,
    this.ip,
    this.apenom,
    this.sexoPerson,
    this.crearCodigo=false
  });

  String idDgoCreaOpReci;
  String idDgoReciElect;
  String idGenPersona;
  String estado;
  String fechaIni;
  String fechaFin;
  String usuario;
  String fecha;
  String ip;
  String apenom;
  String sexoPerson;
  bool crearCodigo;

  factory AbrirRecintoElectoral.fromJson(Map<String, dynamic> json) => AbrirRecintoElectoral(
    idDgoCreaOpReci: json["idDgoCreaOpReci"] == null ? null : json["idDgoCreaOpReci"],
    idDgoReciElect: json["idDgoReciElect"] == null ? null : json["idDgoReciElect"],
    idGenPersona: json["idGenPersona"] == null ? null : json["idGenPersona"],
    estado: json["estado"] == null ? null : json["estado"],
    fechaIni: json["fechaIni"] == null ? null : json["fechaIni"],
    fechaFin: json["fechaFin"] == null ? null : json["fechaFin"],
    usuario: json["usuario"] == null ? null : json["usuario"],
    fecha: json["fecha"] == null ? null : json["fecha"],
    ip: json["ip"] == null ? null : json["ip"],
    apenom: json["apenom"] == null ? null : json["apenom"],
    sexoPerson: json["sexoPerson"] == null ? null : json["sexoPerson"],
    crearCodigo: json["crearCodigo"] == null ? false : json["crearCodigo"],
  );

  Map<String, dynamic> toJson() => {
    "idDgoCreaOpReci": idDgoCreaOpReci == null ? null : idDgoCreaOpReci,
    "idDgoReciElect": idDgoReciElect == null ? null : idDgoReciElect,
    "estado": estado == null ? null : estado,
    "fechaIni": fechaIni == null ? null : fechaIni,
    "fechaFin": fechaFin == null ? null : fechaFin,
    "usuario": usuario == null ? null : usuario,
    "fecha": fecha == null ? null : fecha,
    "ip": ip == null ? null : ip,
    "apenom": apenom == null ? null : apenom,
    "sexoPerson": sexoPerson == null ? null : sexoPerson,
  };
}
