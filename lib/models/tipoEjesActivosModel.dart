part of 'models.dart';
TipoEjesActivosModel tipoEjesActivosModelFromJson(String str) => TipoEjesActivosModel.fromJson(json.decode(str));

String tipoEjesActivosModelToJson(TipoEjesActivosModel data) => json.encode(data.toJson());

class TipoEjesActivosModel {
  TipoEjesActivosModel({
    this.tipoEjesActivos,
  });

  TipoEjesActivos tipoEjesActivos;

  factory TipoEjesActivosModel.fromJson(Map<String, dynamic> json) => TipoEjesActivosModel(
    tipoEjesActivos: json["datos"] == null ? null : TipoEjesActivos.fromJson(json["datos"]),
  );

  Map<String, dynamic> toJson() => {
    "tipoEjesActivos": tipoEjesActivos == null ? null : tipoEjesActivos.toJson(),
  };
}

class TipoEjesActivos {
  TipoEjesActivos({
    this.tipoEjeRecintos=false,
    this.tipoEjeUnidadesPoliciales=false,
    this.tipoEjeOtros=false,
  });

  bool tipoEjeRecintos;
  bool tipoEjeUnidadesPoliciales;
  bool tipoEjeOtros;

  factory TipoEjesActivos.fromJson(Map<String, dynamic> json) => TipoEjesActivos(
    tipoEjeRecintos: json["tipoEjeRecintos"] == null ? null : json["tipoEjeRecintos"],
    tipoEjeUnidadesPoliciales: json["tipoEjeUnidadesPoliciales"] == null ? null : json["tipoEjeUnidadesPoliciales"],
    tipoEjeOtros: json["tipoEjeOtros"] == null ? null : json["tipoEjeOtros"],
  );

  Map<String, dynamic> toJson() => {
    "tipoEjeRecintos": tipoEjeRecintos == null ? null : tipoEjeRecintos,
    "tipoEjeUnidadesPoliciales": tipoEjeUnidadesPoliciales == null ? null : tipoEjeUnidadesPoliciales,
    "tipoEjeOtros": tipoEjeOtros == null ? null : tipoEjeOtros,
  };
}
