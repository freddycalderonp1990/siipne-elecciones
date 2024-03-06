
part of 'models.dart';

UnidadesPolicialesId unidadesPolicialesIdFromJson(String str) => UnidadesPolicialesId.fromJson(json.decode(str));

String unidadesPolicialesIdToJson(UnidadesPolicialesId data) => json.encode(data.toJson());

class UnidadesPolicialesId {
  UnidadesPolicialesIdClass unidadesPolicialesId;

  UnidadesPolicialesId({
    this.unidadesPolicialesId,
  });

  factory UnidadesPolicialesId.fromJson(Map<String, dynamic> json) => UnidadesPolicialesId(
    unidadesPolicialesId: UnidadesPolicialesIdClass.fromJson(json["unidadesPolicialesId"]),
  );

  Map<String, dynamic> toJson() => {
    "unidadesPolicialesId": unidadesPolicialesId.toJson(),
  };
}

class UnidadesPolicialesIdClass {
  int codeError;
  String msj;
  List<DatosUnidadesId> datosUnidadesId;

  UnidadesPolicialesIdClass({
    this.codeError,
    this.msj,
    this.datosUnidadesId,
  });

  factory UnidadesPolicialesIdClass.fromJson(Map<String, dynamic> json) => UnidadesPolicialesIdClass(
    codeError: json["codeError"],
    msj: json["msj"],
    datosUnidadesId: List<DatosUnidadesId>.from(json["datos"].map((x) => DatosUnidadesId.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "codeError": codeError,
    "msj": msj,
    "datos": List<dynamic>.from(datosUnidadesId.map((x) => x.toJson())),
  };
}

class DatosUnidadesId {
  String idDgoTipoEje;
  String dgoIdDgoTipoEje;
  String ejeHijo2;
  String ejeHijo3;
  String ejeHijo4;
  String ejePadre;

  DatosUnidadesId({
    this.idDgoTipoEje,
    this.dgoIdDgoTipoEje,
    this.ejeHijo2,
    this.ejeHijo3,
    this.ejeHijo4,
    this.ejePadre,
  });

  factory DatosUnidadesId.fromJson(Map<String, dynamic> json) => DatosUnidadesId(
    idDgoTipoEje: ParseModel.parseToString(json["idDgoTipoEje"]),
    dgoIdDgoTipoEje: ParseModel.parseToString(json["dgo_idDgoTipoEje"]),
    ejeHijo2: json["ejeHijo2"],
    ejeHijo3: json["ejeHijo3"],
    ejeHijo4: json["ejeHijo4"],
    ejePadre: json["ejePadre"],
  );

  Map<String, dynamic> toJson() => {
    "idDgoTipoEje": idDgoTipoEje,
    "dgo_idDgoTipoEje": dgoIdDgoTipoEje,
    "ejeHijo2": ejeHijo2,
    "ejeHijo3": ejeHijo3,
    "ejeHijo4": ejeHijo4,
    "ejePadre": ejePadre,
  };
}
