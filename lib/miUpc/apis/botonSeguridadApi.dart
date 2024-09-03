part of  'apisMiUpc.dart';
class BotonSeguridadApi{
  Future <BotonSeguridadModel> getBotonSeguridad(context,String lat, String long,String detalle) async{
    BotonSeguridadModel botonSeguridadModel;
    Map<String, String> parametros;
    parametros={
      MiUpcConstApi.varOpn:MiUpcConstApi.BOTONSEG,
      MiUpcConstApi.varLatitud:lat.toString(),
      MiUpcConstApi.varLongitud:long.toString(),
      MiUpcConstApi.varOpcion:detalle,
    };

    var datos="";
    try
    {
      datos=await MiUpcUrlApi.getUrl( context:context,parametros:parametros);
      log("-----------------"+datos);
      if (datos!=null){
        botonSeguridadModel = botonSeguridadModelFromJson(datos);
        return botonSeguridadModel;
      }else
      {
        return null;
      }
    }catch(e){
      //  AlertasWidget.alerta(ctxt: context, title: 'ErrorAI', msj: e.toString());
    }



  }
}