part of  'apisMiUpc.dart';

class MiUpcModulosApi{

  Future <ModulosModel> consultarModulos(context) async{
    ModulosModel modulosModel;
    Map<String, String> parametros;
    parametros={
      MiUpcConstApi.varOpn:MiUpcConstApi.MODULOS,
      MiUpcConstApi.varLatitud:"0",
      MiUpcConstApi.varLongitud:"0",
      MiUpcConstApi.varOpcion:"0",
    };

    var datos="";
    datos=await MiUpcUrlApi.getUrl( context:context,parametros:parametros);
    if(datos!= null) {
      modulosModel = modulosModelFromJson(datos);
      return modulosModel;
    }
    else{
      return null;
    }

  }
}