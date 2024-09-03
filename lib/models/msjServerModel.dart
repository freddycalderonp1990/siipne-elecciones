// To parse this JSON data, do
//
//     final MsjServerModel = MsjServerModelFromJson(jsonString);

part of 'models.dart';

//clase que va a recibir cuando se modifica, insertar  registros
MsjServerModel MsjServerModelFromJson(String str,String name) => MsjServerModel.fromJson(json.decode(str),name);

String MsjServerModelToJson(MsjServerModel data,String name) => json.encode(data.toJson(name));

class MsjServerModel {
  Name item;

  MsjServerModel({
    this.item,
  });

  factory MsjServerModel.fromJson(Map<String, dynamic> json,String name) => MsjServerModel(
    item: Name.fromJson(json[name]),
  );

  Map<String, dynamic> toJson(String name) => {
    name: item.toJson(),
  };
}

class Name {
  String msj;

  Name({
    this.msj,
  });

  factory Name.fromJson(Map<String, dynamic> json) {

    print("msj json ${json["msj"]}");
    return Name(
      msj: json["msj"],
    );
  }

  Map<String, dynamic> toJson() => {
    "msj": msj,
  };
}
