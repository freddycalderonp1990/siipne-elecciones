part of  'apisMiUpc.dart';

class MiUpcItemsServiciosApi{

  Future <ItemsServiciosModel> consultarServicos(context,String id) async{
    ItemsServiciosModel itemsServiciosModel;
    Map<String, String> parametros;
    parametros={
      MiUpcConstApi.varOpn:MiUpcConstApi.ITEMSFLUTTER,
      MiUpcConstApi.varLatitud:"0",
      MiUpcConstApi.varLongitud:"0",
      MiUpcConstApi.varOpcion:id,
    };

    var datos="";
    datos=await MiUpcUrlApi.getUrl( context:context,parametros:parametros);
    log(datos);
    itemsServiciosModel = itemsServiciosModelFromJson(datos);
    return itemsServiciosModel;
  }
}