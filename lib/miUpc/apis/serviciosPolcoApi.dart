part of  'apisMiUpc.dart';

class ServiciosPolcoApi{

  Future <ServiciosPolcoModel> consultarServicos(context,String id) async{
    ServiciosPolcoModel serviciosPolcoModel;
    Map<String, String> parametros;
    parametros={
      MiUpcConstApi.varOpn:MiUpcConstApi.SERVICIOSFLUTTER,
      MiUpcConstApi.varLatitud:"0",
      MiUpcConstApi.varLongitud:"0",
      MiUpcConstApi.varOpcion:id,
    };

    var datos="";
    datos=await MiUpcUrlApi.getUrl( context:context,parametros:parametros);
    log(datos);
    serviciosPolcoModel = serviciosPolcoModelFromJson(datos);
    return serviciosPolcoModel;
  }
}