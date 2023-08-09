part of  'apisMiUpc.dart';

class MiUpcListaNoticiasApi{
  Future <ListaNoticiasModel> getListaNoticia(context) async{
    ListaNoticiasModel listaNoticiasModel;
    Map<String, String> parametros;
    parametros={
      MiUpcConstApi.varOpn:MiUpcConstApi.NOTICIAS,
      MiUpcConstApi.varLatitud:"0",
      MiUpcConstApi.varLongitud:"0",
      MiUpcConstApi.varOpcion:"0",
    };

    var datos="";
    try
    {
      datos=await MiUpcUrlApi.getUrl( context:context,parametros:parametros);
      log("-----------------"+datos);
      if (datos!=null){
        listaNoticiasModel = listaNoticiasModelFromJson(datos);
        return listaNoticiasModel;
      }else
      {
        return null;
      }
    }catch(e){

      //  AlertasWidget.alerta(ctxt: context, title: 'ErrorAI', msj: e.toString());
    }



  }
}