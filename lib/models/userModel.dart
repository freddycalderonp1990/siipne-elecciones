// To parse this JSON data, do
//
//     final usuarioModel = usuarioModelFromJson(jsonString);

part of 'models.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

class UserModel {
  UserModel({
    this.usuario,
  });

  List<Usuario> usuario;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        usuario: json["datos"] == null
            ? null
            : List<Usuario>.from(json["datos"].map((x) => Usuario.fromJson(x))),
      );
}

class Usuario {
  Usuario(
      {this.idGenUsuario,
      this.idGenPersona,
      this.nombreUsuario,
      this.apenom,
      this.documento,
      this.sexo,
      this.foto,
      this.fotoString,
      this.ubicacionSeleccionada,
      this.actualizarApp = false,
      this.session = false,
      this.motivo});

  String idGenUsuario;
  String idGenPersona;
  String nombreUsuario;
  String apenom;
  String documento;
  String sexo;
  Uint8List foto;
  String fotoString;
  LatLng ubicacionSeleccionada;
  bool actualizarApp;
  bool session;
  String motivo;


  factory Usuario.fromJson(Map<String, dynamic> json) {
    String img = json["foto"];

    Uint8List imgDecode = null;
    String imgDefault;
    imgDefault=AppConfig.imgNoImagenPolicia;
    if (img != null) {
      final decodedBytes = base64Decode(img);
      print(decodedBytes);
      imgDecode = decodedBytes;
    }else{
      final decodedBytes = base64Decode(imgDefault);
      print(decodedBytes);
      imgDecode = decodedBytes;
    }




    return Usuario(
        idGenUsuario:  ParseModel.parseToString(json["idGenUsuario"]),
        idGenPersona: ParseModel.parseToString(json["idGenPersona"]),
        nombreUsuario:
            json["nombreUsuario"] == null ? "null" : json["nombreUsuario"],
        apenom: ParseModel.parseToString(json["apenom"]),
        documento: json["documento"] == null ? "null" : json["documento"],
        fotoString: json["foto"] == null ? imgDefault : json["foto"],
        actualizarApp:
            json["actualizarApp"] == null ? false : json["actualizarApp"],
        sexo: json["sexoPerson"] == null ? "null" : json["sexoPerson"],
        session: json["session"] == null ? false : json["session"],
        motivo: json["motivo"] == null ? "vacio" : json["motivo"],
        foto: imgDecode);
  }


}
