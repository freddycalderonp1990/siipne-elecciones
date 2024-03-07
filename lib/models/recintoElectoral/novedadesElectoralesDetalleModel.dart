part of '../models.dart';

NovedadesElectoralesDetalleModel novedadesElectoralesDetalleModelFromJson(String str) => NovedadesElectoralesDetalleModel.fromJson(json.decode(str));

String novedadesElectoralesDetalleModelToJson(NovedadesElectoralesDetalleModel data) => json.encode(data.toJson());

class NovedadesElectoralesDetalleModel {
  NovedadesElectoralesDetalleModel({
    this.novedadesElectoralesDetalle,
  });

  List<NovedadesElectoralesDetalle> novedadesElectoralesDetalle;

  factory NovedadesElectoralesDetalleModel.fromJson(Map<String, dynamic> json) => NovedadesElectoralesDetalleModel(
    novedadesElectoralesDetalle: json["datos"] == null ? null : List<NovedadesElectoralesDetalle>.from(json["datos"].map((x) => NovedadesElectoralesDetalle.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "novedadesElectoralesDetalle": novedadesElectoralesDetalle == null ? null : List<dynamic>.from(novedadesElectoralesDetalle.map((x) => x.toJson())),
  };
}

class NovedadesElectoralesDetalle {
  NovedadesElectoralesDetalle({
    this.idDgoCreaOpReci,
    this.nomRecintoElec,
    this.cargo,
    this.reporta,
    this.fechaIni,
    this.tipo,
    this.novedad,
    this.observacion,
    this.fechaNovedad,
  });

  String idDgoCreaOpReci;
  String nomRecintoElec;
  String cargo;
  String reporta;
  String fechaIni;
  String tipo;
  String novedad;
  String observacion;
  String fechaNovedad;

  factory NovedadesElectoralesDetalle.fromJson(Map<String, dynamic> json) => NovedadesElectoralesDetalle(
    idDgoCreaOpReci: ParseModel.parseToString(json["idDgoCreaOpReci"]),
    nomRecintoElec: ParseModel.parseToString(json["nomRecintoElec"] ),
    cargo: ParseModel.parseToString(json["cargo"] ),
    reporta: ParseModel.parseToString(json["reporta"] ),
    fechaIni: ParseModel.parseToString(json["fechaIni"]),
    tipo: ParseModel.parseToString(json["tipo"]),
    novedad: ParseModel.parseToString(json["novedad"] ),
    observacion: ParseModel.parseToString(json["observacion"] ),
    fechaNovedad: ParseModel.parseToString(json["fechaNovedad"] ),
  );

  Map<String, dynamic> toJson() => {
    "idDgoCreaOpReci": idDgoCreaOpReci == null ? null : idDgoCreaOpReci,
    "nomRecintoElec": nomRecintoElec == null ? null : nomRecintoElec,
    "cargo": cargo == null ? null : cargo,
    "reporta": reporta == null ? null : reporta,
    "fechaIni": fechaIni == null ? null : fechaIni,
    "tipo": tipo == null ? null : tipo,
    "novedad": novedad == null ? null : novedad,
    "observacion": observacion == null ? null : observacion,
    "fechaNovedad": fechaNovedad == null ? null : fechaNovedad,
  };
}
