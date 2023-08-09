part of  'modelsMiUpc.dart';

ListaNoticiasModel listaNoticiasModelFromJson(String str) => ListaNoticiasModel.fromJson(json.decode(str));

String listaNoticiasModelToJson(ListaNoticiasModel data) => json.encode(data.toJson());

class ListaNoticiasModel {
  ListaNoticiasModel({
    this.noticias,
  });

  List<Noticia> noticias;

  factory ListaNoticiasModel.fromJson(Map<String, dynamic> json) => ListaNoticiasModel(
    noticias: List<Noticia>.from(json["noticias"].map((x) => Noticia.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "noticias": List<dynamic>.from(noticias.map((x) => x.toJson())),
  };
}

class Noticia {
  Noticia({
    this.idUpcNoticias,
    this.descripcionNocticia,
    this.fechaNoticia,
    this.hashtagNoticia,
    this.idGenEstado,
    this.imagenNoticia,
    this.urlVideo,
    this.tieneVideo,
    this.linkHashtag,
  });

  String idUpcNoticias;
  String descripcionNocticia;
  DateTime fechaNoticia;
  String hashtagNoticia;
  String idGenEstado;
  String imagenNoticia;
  String urlVideo;
  String tieneVideo;
  String linkHashtag;

  factory Noticia.fromJson(Map<String, dynamic> json) => Noticia(
    idUpcNoticias: json["idUpcNoticias"],
    descripcionNocticia: json["descripcionNocticia"],
    fechaNoticia: DateTime.parse(json["fechaNoticia"]),
    hashtagNoticia: json["hashtagNoticia"],
    idGenEstado: json["idGenEstado"],
    imagenNoticia: json["imagenNoticia"],
    urlVideo: json["urlVideo"],
    tieneVideo: json["tieneVideo"],
    linkHashtag: json["linkHashtag"],
  );

  Map<String, dynamic> toJson() => {
    "idUpcNoticias": idUpcNoticias,
    "descripcionNocticia": descripcionNocticia,
    "fechaNoticia": fechaNoticia.toIso8601String(),
    "hashtagNoticia": hashtagNoticia,
    "idGenEstado": idGenEstado,
    "imagenNoticia": imagenNoticia,
    "urlVideo": urlVideo,
    "tieneVideo": tieneVideo,
    "linkHashtag": linkHashtag,
  };
}
