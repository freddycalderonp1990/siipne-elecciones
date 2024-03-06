part of  'modelsMiUpc.dart';

GetDatosUpcModel getDatosUpcModelFromJson(String str) =>
    GetDatosUpcModel.fromJson(json.decode(str));

String getDatosUpcModelToJson(GetDatosUpcModel data) =>
    json.encode(data.toJson());

class GetDatosUpcModel {
  List<Miupc> miupc;

  GetDatosUpcModel({
    this.miupc,
  });

  factory GetDatosUpcModel.fromJson(Map<String, dynamic> json){

    try{
      return   GetDatosUpcModel(
        miupc: List<Miupc>.from(json["Miupc"].map((x) {


          return Miupc.fromJson(x);


        }

        )),
      );
    }
    catch(e){
      return null;
    }

  }



  Map<String, dynamic> toJson() => {
        "Miupc": List<dynamic>.from(miupc.map((x) => x.toJson())),
      };
}

class Miupc {
  String idGenUpc;
  String descripcionUpc;
  String latitudUpc;
  String longitudUpc;
  String fonoUpc;
  String fotoUpc;
  String dirUpc;
  String mailUpc;
  String distance;

  Miupc({
    this.idGenUpc,
    this.descripcionUpc,
    this.latitudUpc,
    this.longitudUpc,
    this.fonoUpc,
    this.fotoUpc,
    this.dirUpc,
    this.mailUpc,
    this.distance,
  });

  factory Miupc.fromJson(Map<String, dynamic> json) {
    String pone = json["fonoUpc"];

    String newValue = pone.replaceAll("(", "").replaceAll(")", "");

    int poneInt = int.parse(newValue.substring(1, 2));


    if (poneInt <= 0) {
      pone = MiUpcAppConfig.num911;
    }

    double distancia=double.parse(json["distance"]);
    distancia=UtilidadesUtil.redondearDecimalesN(distancia, 2);

    return Miupc(

      idGenUpc: ParseModel.parseToString(json["idGenUpc"]),
      descripcionUpc: json["descripcionUpc"],
      latitudUpc: json["latitudUpc"],
      longitudUpc: json["longitudUpc"],
      fonoUpc: pone,
      fotoUpc: json["fotoUpc"],
      dirUpc: json["dirUpc"],
      mailUpc: json["mailUpc"],
      distance: distancia.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "idGenUpc": idGenUpc,
        "descripcionUpc": descripcionUpc,
        "latitudUpc": latitudUpc,
        "longitudUpc": longitudUpc,
        "fonoUpc": fonoUpc,
        "fotoUpc": fotoUpc,
        "dirUpc": dirUpc,
        "mailUpc": mailUpc,
        "distance": distance,
      };
}
class Failure {
  // Use something like "int code;" if you want to translate error messages
  final String message;
  Failure(this.message);
  @override
  String toString() => message;
}