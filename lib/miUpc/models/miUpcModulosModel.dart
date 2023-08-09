part of  'modelsMiUpc.dart';

ModulosModel modulosModelFromJson(String str) => ModulosModel.fromJson(json.decode(str));

String modulosModelToJson(ModulosModel data) => json.encode(data.toJson());

class ModulosModel {
  List<Modulo> modulos;

  ModulosModel({
    this.modulos,
  });

  factory ModulosModel.fromJson(Map<String, dynamic> json) => ModulosModel(
    modulos: List<Modulo>.from(json["modulos"].map((x) => Modulo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "modulos": List<dynamic>.from(modulos.map((x) => x.toJson())),
  };
}

class Modulo {
  String idUpcModulosMovil;
  String tituloModulo;
  String descripcionModulo;
  String imagenModulo;
  String ordenModulo;
  String idGenEstado;
  String imgBase64;


  Modulo({
    this.idUpcModulosMovil,
    this.tituloModulo,
    this.descripcionModulo,
    this.imagenModulo,
    this.ordenModulo,
    this.idGenEstado,
    this.imgBase64
  });

  factory Modulo.fromJson(Map<String, dynamic> json) => Modulo(
    idUpcModulosMovil: json["idUpcModulosMovil"],
    tituloModulo: json["tituloModulo"],
    descripcionModulo: json["descripcionModulo"],
    imagenModulo: json["imagenModulo"],
    ordenModulo: json["ordenModulo"],
    idGenEstado: json["idGenEstado"],
    imgBase64: json["imgBase64"],
  );

  Map<String, dynamic> toJson() => {
    "idUpcModulosMovil": idUpcModulosMovil,
    "tituloModulo": tituloModulo,
    "descripcionModulo": descripcionModulo,
    "imagenModulo": imagenModulo,
    "ordenModulo": ordenModulo,
    "idGenEstado": idGenEstado,
    "imgBase64": imgBase64,
  };
}
