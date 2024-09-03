//Clase para validar las respuestas del servidor
part of  'apis.dart';

class ResponseApi{

  static String validateConsultas({String json, String titleJson}){
    try {
      print("json");
      print(json);
      final MsjServerModel = MsjServerModelFromJson(json, titleJson);
      print(MsjServerModel);
      if (MsjServerModel.item.msj == ConstApi.varTrue ||
          MsjServerModel.item.msj == ConstApi.varExiste) {
        return ConstApi.varTrue;
      }
      else {
        return MsjServerModel.item.msj;
      }
    }  catch (e) {
     String msj=ConstApi.msjError;
     if(msj=="noExiste"){
       msj="No existen Datos";
     }
      throw new Exception(msj);
     //throw new Exception('[Validar COnsultas -${e.toString()}]');
      return null;
    }

  }



  static String validateConsultasExiste({String json, String titleJson}){
    try {



      final MsjServerModel = MsjServerModelFromJson(json, titleJson);


      if ( MsjServerModel.item.msj == ConstApi.varExiste) {
        return ConstApi.varExiste;
      }
      else {
        return MsjServerModel.item.msj;
      }
    }  catch (e) {
      String msj=ConstApi.msjError;
      if(msj=="noExiste"){
        msj="No existen Datos";
      }
      throw new Exception(msj);
      //throw new Exception('[validar Consultas Existe-${e.toString()}]');
      return null;
    }

  }

  static Future<String> validateInsert({String json, String titleJson}) async{
    try{
    final MsjServerModel = MsjServerModelFromJson(json,titleJson);
    if(MsjServerModel.item.msj==ConstApi.varTrue ) {
      return ConstApi.varTrue;
    }
    else{
      return MsjServerModel.item.msj;
    }
    }  catch (e) {
      String msj=ConstApi.msjError;
      throw new Exception(msj);
     // throw new Exception('[Validar Insertar -${e.toString()}]');
      return null;
    }

  }


  static String validateUpdate({String json, String titleJson}){
    try{
      final MsjServerModel = MsjServerModelFromJson(json,titleJson);
      return MsjServerModel.item.msj;
    }  catch (e) {
      String msj=ConstApi.msjError;
      throw new Exception(msj);
      //throw new Exception('[Validar Actualizar-${e.toString()}]');
      return null;
    }

  }
}