part of  'apisMiUpc.dart';

class MiUpcActualizaUsuarioApi{
  Future <ActualizaUsuarioModel> realizaActualizaUsuario(context, String detalle) async{
    ActualizaUsuarioModel actualizaUsuarioModel;
    Map<String, String> parametros;
    parametros={
      MiUpcConstApi.varOpn:MiUpcConstApi.ACTUALIZAUSUARIO,
      MiUpcConstApi.varLatitud:"0",
      MiUpcConstApi.varLongitud:"0",
      MiUpcConstApi.varOpcion:detalle,
    };

    var datos="";
    try
    {
      datos=await MiUpcUrlApi.getUrl( context:context,parametros:parametros);
      log("-----------------"+datos);
      if (datos!=null){
        actualizaUsuarioModel = actualizaUsuarioModelFromJson(datos);
        return actualizaUsuarioModel;
      }else
      {
        return null;
      }
    }catch(e){
      //  AlertasWidget.alerta(ctxt: context, title: 'ErrorAI', msj: e.toString());
    }



  }
}