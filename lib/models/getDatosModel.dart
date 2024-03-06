// To parse this JSON data, do
// permite extraer los datos del modelo de json recibido
//     final getDatosModel = getDatosModelFromJson(jsonString);

part of 'models.dart';

String getDatosModelFromString(String str, @required String jsonName) =>
    GetDatosModel.fromString(json.decode(str), jsonName);

class GetDatosModel {
  static String fromString(
      Map<String, dynamic> jsonDatos, @required String jsonName) {
    Map<String, dynamic> str = jsonDatos[jsonName];

    return json.encode(str);
  }
}
