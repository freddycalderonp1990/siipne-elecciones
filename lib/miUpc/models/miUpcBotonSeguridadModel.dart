part of  'modelsMiUpc.dart';

BotonSeguridadModel botonSeguridadModelFromJson(String str) => BotonSeguridadModel.fromJson(json.decode(str));
String botonSeguridadModelToJson(BotonSeguridadModel data) => json.encode(data.toJson());
class BotonSeguridadModel {
  BotonSeguridadModel({
    this.boton,
  });

  List<String> boton;
  factory BotonSeguridadModel.fromJson(Map<String, dynamic> json) => BotonSeguridadModel(
    boton: List<String>.from(json["boton"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "boton": List<dynamic>.from(boton.map((x) => x)),
  };
}
