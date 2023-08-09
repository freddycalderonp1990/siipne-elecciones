// To parse this JSON data, do
//
//     final getNotificacionesModel = getNotificacionesModelFromJson(jsonString);

import 'dart:convert';

GetNotificacionesModel getNotificacionesModelFromJson(String str) => GetNotificacionesModel.fromJson(json.decode(str));

String getNotificacionesModelToJson(GetNotificacionesModel data) => json.encode(data.toJson());

class GetNotificacionesModel {
  GetNotificacionesModel({
    this.code,
    this.lnoti,
  });

  int code;
  List<Lnoti> lnoti;

  factory GetNotificacionesModel.fromJson(Map<String, dynamic> json) {

    int code=json["code"];
    return  GetNotificacionesModel(
      code: code,
      lnoti: code==1? List<Lnoti>.from(json["lnoti"].map((x) => Lnoti.fromJson(x))): new List(),
    );
  }

  Map<String, dynamic> toJson() => {
    "code": code,
    "lnoti": List<dynamic>.from(lnoti.map((x) => x.toJson())),
  };
}

class Lnoti {
  Lnoti({
    this.idUpcNotificacionMovil,
    this.titulo,
    this.mensaje,
    this.tipo,
    this.fecha,
    this.localizado=false,
    this.estadoAlerta,
    this.observacion
  });

  String idUpcNotificacionMovil;
  String titulo;
  String mensaje;
  String tipo;
  String fecha;
  bool localizado;
  String estadoAlerta;
  String observacion;

  factory Lnoti.fromJson(Map<String, dynamic> json) => Lnoti(
    idUpcNotificacionMovil: json["idUpcNotificacionMovil"],
    titulo:json["titulo"],
    mensaje: json["mensaje"],
    tipo: json["tipo"],
    fecha:json["fecha"],
    localizado: json["estado"]=='LOCALIZADO'?true:false,
    estadoAlerta:json["estado"],
    observacion: json["observacion"] == null ? null : json["observacion"],
  );

  Map<String, dynamic> toJson() => {
    "idUpcNotificacionMovil": idUpcNotificacionMovil,
    "titulo": titulo,
    "mensaje": mensaje,
    "tipo": tipo,
    "fecha": fecha,
  };
}


