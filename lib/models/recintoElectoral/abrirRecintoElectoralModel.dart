// To parse this JSON data, do
//
//     final abrirRecintoElectoralModel = abrirRecintoElectoralModelFromJson(jsonString);

part of '../models.dart';

AbrirRecintoElectoralModel abrirRecintoElectoralModelFromJson(String str) =>
    AbrirRecintoElectoralModel.fromJson(json.decode(str));

String abrirRecintoElectoralModelToJson(AbrirRecintoElectoralModel data) =>
    json.encode(data.toJson());

class AbrirRecintoElectoralModel {
  AbrirRecintoElectoralModel({
    this.abrirRecintoElectoral,
  });

  AbrirRecintoElectoral abrirRecintoElectoral;

  factory AbrirRecintoElectoralModel.fromJson(Map<String, dynamic> json) =>
      AbrirRecintoElectoralModel(
        abrirRecintoElectoral: json["datos"] == null
            ? null
            : AbrirRecintoElectoral.fromJson(json["datos"]),
      );

  Map<String, dynamic> toJson() => {
        "AbrirRecintoElectoral": abrirRecintoElectoral == null
            ? null
            : abrirRecintoElectoral.toJson(),
      };
}

class AbrirRecintoElectoral {
  AbrirRecintoElectoral(
      {this.idDgoCreaOpReci,
      this.idDgoReciElect,
      this.idGenPersona,
      this.estado = "Sin Estado",
      this.fechaIni,
      this.fechaFin,
      this.usuario,
      this.fecha,
      this.ip,
      this.apenom,
      this.sexoPerson,
      this.telefono,
      this.crearCodigo = false});

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
  String telefono;

  factory AbrirRecintoElectoral.fromJson(Map<String, dynamic> json) =>
      AbrirRecintoElectoral(
        idDgoCreaOpReci: ParseModel.parseToString(json["idDgoCreaOpReci"]),
        idDgoReciElect: ParseModel.parseToString(json["idDgoReciElect"]),
        idGenPersona: ParseModel.parseToString(json["idGenPersona"]),
        estado: ParseModel.parseToString(json["estado"] ),
        fechaIni: ParseModel.parseToString(json["fechaIni"]),
        fechaFin: ParseModel.parseToString(json["fechaFin"] ),
        usuario: ParseModel.parseToString(json["usuario"]),
        fecha: ParseModel.parseToString(json["fecha"]),
        ip: ParseModel.parseToString(json["ip"]),
        apenom: ParseModel.parseToString(json["apenom"] ),
        sexoPerson: ParseModel.parseToString(json["sexoPerson"]),
        telefono: ParseModel.parseToString(json["telefono"] ),
        crearCodigo: ParseModel.parseToBool(json["crearCodigo"]),
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
