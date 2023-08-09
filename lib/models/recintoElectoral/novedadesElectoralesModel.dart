// To parse this JSON data, do
//
//     final novedadesElectoralesModel = novedadesElectoralesModelFromJson(jsonString);

part of '../models.dart';

NovedadesElectoralesModel novedadesElectoralesModelFromJson(String str) => NovedadesElectoralesModel.fromJson(json.decode(str));

String novedadesElectoralesModelToJson(NovedadesElectoralesModel data) => json.encode(data.toJson());

class NovedadesElectoralesModel {
  NovedadesElectoralesModel({
    this.novedadesElectorales,
  });

  List<NovedadesElectorale> novedadesElectorales;

  factory NovedadesElectoralesModel.fromJson(Map<String, dynamic> json) => NovedadesElectoralesModel(
    novedadesElectorales: json["datos"] == null ? null : List<NovedadesElectorale>.from(json["datos"].map((x) => NovedadesElectorale.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "novedadesElectorales": novedadesElectorales == null ? null : List<dynamic>.from(novedadesElectorales.map((x) => x.toJson())),
  };
}

class NovedadesElectorale {
  NovedadesElectorale({
    this.idDgoNovedadesElect,
    this.dgoIdDgoNovedadesElect,
    this.descripcion,
    this.idGenEstado,
    this.delLog,
    this.usuario,
    this.fecha,
    this.ip,
  });

  String idDgoNovedadesElect;
  String dgoIdDgoNovedadesElect;
  String descripcion;
  String idGenEstado;
  String delLog;
  String usuario;
  String fecha;
  String ip;

  factory NovedadesElectorale.fromJson(Map<String, dynamic> json) => NovedadesElectorale(
    idDgoNovedadesElect: json["idDgoNovedadesElect"] == null ? null : json["idDgoNovedadesElect"],
    dgoIdDgoNovedadesElect: json["dgo_idDgoNovedadesElect"] == null ? null : json["dgo_idDgoNovedadesElect"],
    descripcion: json["descripcion"] == null ? null : json["descripcion"],
    idGenEstado: json["idGenEstado"] == null ? null : json["idGenEstado"],
    delLog: json["delLog"] == null ? null : json["delLog"],
    usuario: json["usuario"] == null ? null : json["usuario"],
    fecha: json["fecha"] == null ? null : json["fecha"],
    ip: json["ip"] == null ? null : json["ip"],
  );

  Map<String, dynamic> toJson() => {
    "idDgoNovedadesElect": idDgoNovedadesElect == null ? null : idDgoNovedadesElect,
    "dgo_idDgoNovedadesElect": dgoIdDgoNovedadesElect == null ? null : dgoIdDgoNovedadesElect,
    "descripcion": descripcion == null ? null : descripcion,
    "idGenEstado": idGenEstado == null ? null : idGenEstado,
    "delLog": delLog == null ? null : delLog,
    "usuario": usuario == null ? null : usuario,
    "fecha": fecha == null ? null : fecha,
    "ip": ip == null ? null : ip,
  };
}
