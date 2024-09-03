part of 'models.dart';

ProcesosImgModel procesosImgModelFromJson(String str) =>
    ProcesosImgModel.fromJson(json.decode(str));

String procesosImgModelToJson(ProcesosImgModel data) =>
    json.encode(data.toJson());

class ProcesosImgModel {
  final ProcesosOperativosActivos procesosOperativosActivos;

  ProcesosImgModel({
    this.procesosOperativosActivos,
  });

  factory ProcesosImgModel.fromJson(Map<String, dynamic> json) =>
      ProcesosImgModel(
        procesosOperativosActivos: ProcesosOperativosActivos.fromJson(
            json["procesosOperativosActivos"]),
      );

  Map<String, dynamic> toJson() => {
        "procesosOperativosActivos": procesosOperativosActivos.toJson(),
      };
}

class ProcesosOperativosActivos {
  final List<DatosProcesoImg> datosProcesoImg;

  ProcesosOperativosActivos({
    this.datosProcesoImg,
  });

  factory ProcesosOperativosActivos.fromJson(Map<String, dynamic> json) =>
      ProcesosOperativosActivos(
        datosProcesoImg: List<DatosProcesoImg>.from(
            json["datos"].map((x) => DatosProcesoImg.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "datosProcesoImg":
            List<dynamic>.from(datosProcesoImg.map((x) => x.toJson())),
      };
}

class DatosProcesoImg {
  final int idDgoProcElec;
  final String descProcElecc;
  final String urlImagen;
  final String imgBase64;

  DatosProcesoImg({
    this.idDgoProcElec,
    this.descProcElecc,
    this.urlImagen,
    this.imgBase64,
  });

  factory DatosProcesoImg.fromJson(Map<String, dynamic> json) =>
      DatosProcesoImg(
        idDgoProcElec: ParseModel.parseToInt(json["idDgoProcElec"]),
        descProcElecc: ParseModel.parseToString(json["descProcElecc"]),
        urlImagen: ParseModel.parseToString(json["urlImagen"]),
        imgBase64: ParseModel.parseToString(json["imgBase64"]),
      );

  Map<String, dynamic> toJson() => {
        "idDgoProcElec": idDgoProcElec,
        "descProcElecc": descProcElecc,
        "urlImagen": urlImagen,
        "imgBase64": imgBase64,
      };
}
