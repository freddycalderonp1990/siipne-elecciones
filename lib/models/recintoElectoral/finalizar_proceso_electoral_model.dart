part of '../models.dart';


class FinalizarProcesoElectoralModel {
  FinalizarProcesoElectoralModel({
     this.finalizarRecintoElectoral,
  });

  final FinalizarRecintoElectoral finalizarRecintoElectoral;

  factory FinalizarProcesoElectoralModel.fromJson(String str) => FinalizarProcesoElectoralModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FinalizarProcesoElectoralModel.fromMap(Map<String, dynamic> json) => FinalizarProcesoElectoralModel(
    finalizarRecintoElectoral: FinalizarRecintoElectoral.fromMap(json["finalizarRecintoElectoral"]),
  );

  Map<String, dynamic> toMap() => {
    "finalizarRecintoElectoral": finalizarRecintoElectoral.toMap(),
  };
}

class FinalizarRecintoElectoral {
  FinalizarRecintoElectoral({
     this.codeError,
     this.msj,
     this.datos,
  });

  final int codeError;
  final String msj;
  final datosFinalizarProceso datos;

  factory FinalizarRecintoElectoral.fromJson(String str) => FinalizarRecintoElectoral.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FinalizarRecintoElectoral.fromMap(Map<String, dynamic> json) => FinalizarRecintoElectoral(
    codeError: json["codeError"],
    msj: json["msj"],
    datos: datosFinalizarProceso.fromMap(json["datos"]),
  );

  Map<String, dynamic> toMap() => {
    "codeError": codeError,
    "msj": msj,
    "datos": datos.toMap(),
  };
}

class datosFinalizarProceso {
  datosFinalizarProceso({
     this.horaServer,
     this.horaValidate,
  });

  final String horaServer;
  final String horaValidate;

  factory datosFinalizarProceso.fromJson(String str) => datosFinalizarProceso.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory datosFinalizarProceso.fromMap(Map<String, dynamic> json) => datosFinalizarProceso(
    horaServer: json["horaServer"],
    horaValidate: json["horaValidate"],
  );

  Map<String, dynamic> toMap() => {
    "horaServer": horaServer,
    "horaValidate": horaValidate,
  };
}
