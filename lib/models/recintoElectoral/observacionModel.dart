part of '../models.dart';

ObservacionModel observacionModelFromJson(String str) => ObservacionModel.fromJson(json.decode(str));

String observacionModelToJson(ObservacionModel data) => json.encode(data.toJson());

String observacionModelToJson2(ObservacionModel data) =>data.getJsonString() ;

class ObservacionNombreValue{
  String nombre;
  String value;
  ObservacionNombreValue({@required this.nombre,@required this.value});
}
class ObservacionModel {
  ObservacionModel({
    this.idDgoNovedadesElect,
    this.cedula,
    this.numBoleta,
    this.numCitacion,
    this.hora,
    this.motivo,
    this.organizacion,
    this.dirigente,
    this.cantidad,
    this.telefono,
    this.nombre,
    this.cargo,
    this.grado,
    this.funcion,
    this.instalacion,
    this.medioComunicacion,
    this.descripcion,
    this.direccion,
    this.unidad,
    this.numerico

  });



  String idDgoNovedadesElect;
  String cedula;
  String numBoleta;
  String numCitacion;
  String hora;
  String motivo;
  String organizacion;
  String dirigente;
  String cantidad;
  String telefono;
  String nombre;
  String cargo;
  String grado;
  String funcion;
  String instalacion;
  String medioComunicacion;
  String descripcion;
  String direccion;
  String unidad;
  String numerico;

  factory ObservacionModel.fromJson(Map<String, dynamic> json) => ObservacionModel(
    idDgoNovedadesElect: ParseModel.parseToString(json["idDgoNovedadesElect"]),
    cedula: ParseModel.parseToString(json["cedula"]),
    numBoleta: ParseModel.parseToString(json["numBoleta"]),
    numCitacion: ParseModel.parseToString(json["numCitacion"] ),
    hora: ParseModel.parseToString(json["hora"] ),
    motivo: ParseModel.parseToString(json["motivo"] ),
    organizacion: ParseModel.parseToString(json["organizacion"] ),
    dirigente: ParseModel.parseToString(json["dirigente"] ),
    cantidad: ParseModel.parseToString(json["cantidad"] ),
    telefono: ParseModel.parseToString(json["telefono" ]),
    nombre: ParseModel.parseToString(json["nombre"] ),
    cargo: ParseModel.parseToString(json["cargo"]),
    grado: ParseModel.parseToString(json["grado"] ),
    funcion:ParseModel.parseToString( json["funcion"] ),
    instalacion: ParseModel.parseToString(json["instalacion"] ),
    medioComunicacion:ParseModel.parseToString( json["medioComunicacion"] ),
    descripcion: ParseModel.parseToString(json["descripcion"] ),
    direccion: ParseModel.parseToString(json["direccion"] ),
    unidad: ParseModel.parseToString(json["unidad"]),
  );

  Map<String, dynamic> toJson() => {
    "idDgoNovedadesElect": idDgoNovedadesElect == null ? null : idDgoNovedadesElect,
    "cedula": cedula == null ? null : cedula,
    "numBoleta": numBoleta == null ? null : numBoleta,
    "numCitacion": numCitacion == null ? null : numCitacion,
    "hora": hora == null ? null : hora,
    "motivo": motivo == null ? null : motivo,
    "organizacion": organizacion == null ? null : organizacion,
    "dirigente": dirigente == null ? null : dirigente,
    "cantidad": cantidad == null ? null : cantidad,
    "telefono": telefono == null ? null : telefono,
    "nombre": nombre == null ? null : nombre,
    "cargo": cargo == null ? null : cargo,
    "grado": grado == null ? null : grado,
    "funcion": funcion == null ? null : funcion,
    "instalacion": instalacion == null ? null : instalacion,
    "medioComunicacion": medioComunicacion == null ? null : medioComunicacion,
    "descripcion": descripcion == null ? null : descripcion,
    "direccion": direccion == null ? null : direccion,
    "unidad": unidad == null ? null : unidad,
  };

 String getJsonString(){




    List<ObservacionNombreValue> datos=new List();

    datos.add(ObservacionNombreValue(nombre: "idDgoNovedadesElect",value: idDgoNovedadesElect));
    datos.add(ObservacionNombreValue(nombre: "cedula",value: cedula));
    datos.add(ObservacionNombreValue(nombre: "numBoleta",value: numBoleta));
    datos.add(ObservacionNombreValue(nombre: "numCitacion",value: numCitacion));
    datos.add(ObservacionNombreValue(nombre: "hora",value: hora));
    datos.add(ObservacionNombreValue(nombre: "motivo",value: motivo));
    datos.add(ObservacionNombreValue(nombre: "organizacion",value: organizacion));
    datos.add(ObservacionNombreValue(nombre: "dirigente",value: dirigente));
    datos.add(ObservacionNombreValue(nombre: "cantidad",value: cantidad));
    datos.add(ObservacionNombreValue(nombre: "telefono",value: telefono));
    datos.add(ObservacionNombreValue(nombre: "nombre",value: nombre));
    datos.add(ObservacionNombreValue(nombre: "cargo",value: cargo));
    datos.add(ObservacionNombreValue(nombre: "grado",value: grado));
    datos.add(ObservacionNombreValue(nombre: "funcion",value: funcion));
    datos.add(ObservacionNombreValue(nombre: "instalacion",value: instalacion));
    datos.add(ObservacionNombreValue(nombre: "medioComunicacion",value: medioComunicacion));
    datos.add(ObservacionNombreValue(nombre: "descripcion",value: descripcion));
    datos.add(ObservacionNombreValue(nombre: "direccion",value: direccion));
    datos.add(ObservacionNombreValue(nombre: "unidad",value: unidad));
    datos.add(ObservacionNombreValue(nombre: "numerico",value: numerico));

    String resulJson='{';

    for(int i=0;i<datos.length;i++){
      resulJson=resulJson+getData(datos[i]);
    }


    resulJson=resulJson+"}";

     resulJson = resulJson.replaceAll(",}", "}");


return resulJson;
  }






  String getData(ObservacionNombreValue data){
    String result='';
    if(data.value != null){
      result='"'+data.nombre+'":"'+data.value+'",';
    }
    return result;

  }
}
