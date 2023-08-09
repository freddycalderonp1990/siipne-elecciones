// To parse this JSON data, do
//
//     final RecintosElectoralsModel = RecintosElectoralsModelFromJson(jsonString);

part of '../models.dart';

RecintosElectoralsModel RecintosElectoralsModelFromJson(String str) => RecintosElectoralsModel.fromJson(json.decode(str));

String RecintosElectoralsModelToJson(RecintosElectoralsModel data) => json.encode(data.toJson());

class RecintosElectoralsModel {
  RecintosElectoralsModel({
    this.RecintosElectorals,
  });

  List<RecintosElectoral> RecintosElectorals;

  factory RecintosElectoralsModel.fromJson(Map<String, dynamic> json) => RecintosElectoralsModel(
    RecintosElectorals: json["datos"] == null ? null : List<RecintosElectoral>.from(json["datos"].map((x) => RecintosElectoral.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "RecintosElectorals": RecintosElectorals == null ? null : List<dynamic>.from(RecintosElectorals.map((x) => x.toJson())),
  };
}

class RecintosElectoral {
  RecintosElectoral({
    this.numElectores='0',
    this.numJuntMascu='0',
    this.numJuntFeme='0',
    this.idDgoReciElect='0',
    this.idGenGeoSenplades='0',
    this.idGenDivPolitica='0',
    this.codRecintoElec='',
    this.nomRecintoElec='',
    this.direcRecintoElec='',
    this.latitud='',
    this.longitud='',
    this.usuario='',
    this.fecha='',
    this.ip='',
    this.distance='0',
  });

  String numElectores;
  String numJuntMascu;
  String numJuntFeme;
  String idDgoReciElect;
  String idGenGeoSenplades;
  String idGenDivPolitica;
  String codRecintoElec;
  String nomRecintoElec;
  String direcRecintoElec;
  String latitud;
  String longitud;
  String usuario;
  String fecha;
  String ip;
  String distance;

  factory RecintosElectoral.fromJson(Map<String, dynamic> json) {
    String nomRecinto=json["nomRecintoElec"] == null ? null : json["nomRecintoElec"];

    String dist=json["distance"] == null ? '' :"\nDistancia:"+json["distance"]+"m";

    nomRecinto=nomRecinto+dist;





    return RecintosElectoral(
      numElectores: json["numElectores"] == null ? null : json["numElectores"],
      numJuntMascu: json["numJuntMascu"] == null ? null : json["numJuntMascu"],
      numJuntFeme: json["numJuntFeme"] == null ? null : json["numJuntFeme"],
      idDgoReciElect: json["idDgoReciElect"] == null ? null : json["idDgoReciElect"],
      idGenGeoSenplades: json["idGenGeoSenplades"],
      idGenDivPolitica: json["idGenDivPolitica"],
      codRecintoElec: json["codRecintoElec"] == null ? null : json["codRecintoElec"],
      nomRecintoElec: nomRecinto,
      direcRecintoElec: json["direcRecintoElec"] == null ? null : json["direcRecintoElec"],
      latitud: json["latitud"] == null ? null : json["latitud"],
      longitud: json["longitud"] == null ? null : json["longitud"],
      usuario: json["usuario"] == null ? null : json["usuario"],
      fecha: json["fecha"] == null ? null : json["fecha"],
      ip: json["ip"] == null ? null : json["ip"],
      distance: json["distance"] == null ? null : json["distance"],
    );

  }

  Map<String, dynamic> toJson() => {
    "numElectores": numElectores == null ? null : numElectores,
    "numJuntMascu": numJuntMascu == null ? null : numJuntMascu,
    "numJuntFeme": numJuntFeme == null ? null : numJuntFeme,
    "idDgoReciElect": idDgoReciElect == null ? null : idDgoReciElect,
    "idGenGeoSenplades": idGenGeoSenplades,
    "idGenDivPolitica": idGenDivPolitica,
    "codRecintoElec": codRecintoElec == null ? null : codRecintoElec,
    "nomRecintoElec": nomRecintoElec == null ? null : nomRecintoElec,
    "direcRecintoElec": direcRecintoElec == null ? null : direcRecintoElec,
    "latitud": latitud == null ? null : latitud,
    "longitud": longitud == null ? null : longitud,
    "usuario": usuario == null ? null : usuario,
    "fecha": fecha == null ? null : fecha,
    "ip": ip == null ? null : ip,
    "distance": distance == null ? null : distance,
  };
}
