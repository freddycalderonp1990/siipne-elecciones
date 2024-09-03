part of  'modelsMiUpc.dart';

ItemsServiciosModel itemsServiciosModelFromJson(String str) => ItemsServiciosModel.fromJson(json.decode(str));

String itemsServiciosModelToJson(ItemsServiciosModel data) => json.encode(data.toJson());

class ItemsServiciosModel {
  List<DServicio> dServicio;

  ItemsServiciosModel({
    this.dServicio,
  });

  factory ItemsServiciosModel.fromJson(Map<String, dynamic> json) => ItemsServiciosModel(
    dServicio: List<DServicio>.from(json["dServicio"].map((x) => DServicio.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "dServicio": List<dynamic>.from(dServicio.map((x) => x.toJson())),
  };
}

class DServicio {
  String descripcion;
  DServicio({
    this.descripcion,
  });

  factory DServicio.fromJson(Map<String, dynamic> json) => DServicio(
    descripcion: json["descripcion"],
  );

  Map<String, dynamic> toJson() => {
    "descripcion": descripcion,
  };
}
