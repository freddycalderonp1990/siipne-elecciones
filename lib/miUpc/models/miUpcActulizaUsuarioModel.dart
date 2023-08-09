part of  'modelsMiUpc.dart';

ActualizaUsuarioModel actualizaUsuarioModelFromJson(String str) => ActualizaUsuarioModel.fromJson(json.decode(str));

String actualizaUsuarioModelToJson(ActualizaUsuarioModel data) => json.encode(data.toJson());

class ActualizaUsuarioModel {
  ActualizaUsuarioModel({
    this.code,
    this.msj,
    this.nombre,
    this.id,
    this.idGenPersona
  });

  bool code;
  String msj;
  String nombre;
  String id;
  String idGenPersona;

  factory ActualizaUsuarioModel.fromJson(Map<String, dynamic> json) => ActualizaUsuarioModel(
    code: json["code"],
    msj: json["msj"],
    nombre: json["nombre"],
    id: json["id"],
    idGenPersona: json["idGenPersona"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msj": msj,
    "nombre": nombre,
    "id": id,
  };
}
