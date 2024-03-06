part of  'apisMiUpc.dart';

class MiUpcRegistroUsuarioApi{
  Future <RegistroUsuarioModel> registrarUsuarioMiUpc(context, Map<String, String> parametros) async{
    RegistroUsuarioModel registroUsuarioModel;


    var datos="";
    try
    {
      datos=await MiUpcUrlApi.getUrl( context:context,parametros:parametros);
      log(datos);
      if (datos!=null){
        registroUsuarioModel = registroUsuarioModelFromJson(datos);
        return registroUsuarioModel;
      }else
      {
        return null;
      }
    }catch(e){
      MiUpcDialogosWidget.alertasV(
          context: context,
          txt:
          "No hay conexión con el Servidor");
      return null;
    }

  }


}