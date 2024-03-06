part of  'apisMiUpc.dart';

class GetDatosUpcApi{
  Future <GetDatosUpcModel> consultarDatosUpc(context,String lat,String long) async{
    GetDatosUpcModel getDatosUpcModel;
    Map<String, String> parametros;
    parametros={
      MiUpcConstApi.varOpn:MiUpcConstApi.UPC,
      MiUpcConstApi.varLatitud:lat,
      MiUpcConstApi.varLongitud:long,
      MiUpcConstApi.varOpcion:"0",
    };

    print('Consultando');

    var datos="";
    datos=await MiUpcUrlApi.getUrl( context:context,parametros:parametros);
    log(datos);
    getDatosUpcModel = getDatosUpcModelFromJson(datos);
    return getDatosUpcModel;

    if (datos!=null){

    }else{

    }


  }
}