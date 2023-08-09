part of 'models.dart';


UnidadesPolicialesModel unidadesPolicialesModelFromJson(String str) => UnidadesPolicialesModel.fromJson(json.decode(str));

String unidadesPolicialesModelToJson(UnidadesPolicialesModel data) => json.encode(data.toJson());

class UnidadesPolicialesModel {
  UnidadesPolicialesModel({
    this.unidadesPoliciales,
  });

  List<UnidadesPoliciale> unidadesPoliciales;

  factory UnidadesPolicialesModel.fromJson(Map<String, dynamic> json) => UnidadesPolicialesModel(
    unidadesPoliciales: json["datos"] == null ? null : List<UnidadesPoliciale>.from(json["datos"].map((x) => UnidadesPoliciale.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "datos": unidadesPoliciales == null ? null : List<dynamic>.from(unidadesPoliciales.map((x) => x.toJson())),
  };
}

class UnidadesPoliciale {
  UnidadesPoliciale({
    this.idDgoTipoEje,
    this.dgoIdDgoTipoEje,
    this.descripcion,
  });

  String idDgoTipoEje;
  String dgoIdDgoTipoEje;
  String descripcion;

  factory UnidadesPoliciale.fromJson(Map<String, dynamic> json) => UnidadesPoliciale(
    idDgoTipoEje: json["idDgoTipoEje"] == null ? null : json["idDgoTipoEje"],
    dgoIdDgoTipoEje: json["dgo_idDgoTipoEje"] == null ? null : json["dgo_idDgoTipoEje"],
    descripcion: json["descripcion"] == null ? null : json["descripcion"],
  );

  Map<String, dynamic> toJson() => {
    "idDgoTipoEje": idDgoTipoEje == null ? null : idDgoTipoEje,
    "dgo_idDgoTipoEje": dgoIdDgoTipoEje == null ? null : dgoIdDgoTipoEje,
    "descripcion": descripcion == null ? null : descripcion,
  };
}
