// To parse this JSON data, do
//
//     final serviciosPolcoModel = serviciosPolcoModelFromJson(jsonString);

import 'dart:convert';

import 'package:siipnemovil2/models/parse_model.dart';

ServiciosPolcoModel serviciosPolcoModelFromJson(String str) => ServiciosPolcoModel.fromJson(json.decode(str));

String serviciosPolcoModelToJson(ServiciosPolcoModel data) => json.encode(data.toJson());

class ServiciosPolcoModel {
  List<Servicio> servicio;

  ServiciosPolcoModel({
    this.servicio,
  });

  factory ServiciosPolcoModel.fromJson(Map<String, dynamic> json) => ServiciosPolcoModel(
    servicio: List<Servicio>.from(json["Servicio"].map((x) => Servicio.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Servicio": List<dynamic>.from(servicio.map((x) => x.toJson())),
  };
}

class Servicio {
  String idUpcServicio;
  String servicio;
  String resumen;
  String img;
  String imgBase64;

  Servicio({
    this.idUpcServicio,
    this.servicio,
    this.resumen,
    this.img,
    this.imgBase64
  });

  factory Servicio.fromJson(Map<String, dynamic> json) => Servicio(
  idUpcServicio: ParseModel.parseToString(json["idUpcServicio"]),
    servicio: json["servicio"],
    resumen: json["resumen"],
    img: json["img"],
    imgBase64: json["imgBase64"],
  );

  Map<String, dynamic> toJson() => {
    "idUpcServicio": idUpcServicio,
    "servicio": servicio,
    "resumen": resumen,
    "img": img,
    "imgBase64": imgBase64,
  };
}
