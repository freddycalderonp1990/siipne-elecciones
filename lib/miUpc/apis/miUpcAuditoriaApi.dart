part of  'apisMiUpc.dart';

class MiUpcAuditoriaApi{
  Future <AuditoriaModel> realizaAuditoria(context,double lat, double long,String detalle) async{
    AuditoriaModel auditoriaModel;
    Map<String, String> parametros;
    parametros={
      MiUpcConstApi.varOpn:MiUpcConstApi.SERVICIOS,
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
        auditoriaModel = auditoriaModelFromJson(datos);
        return auditoriaModel;
      }else
      {
        return null;
      }
    }catch(e){
      //  AlertasWidget.alerta(ctxt: context, title: 'ErrorAI', msj: e.toString());
    }



  }



  Future <bool>  grabaAccion(String la, String lo, String tipoAccion,
      String DetalleAccion,String usuario,String ip ,BuildContext ctx) async{
    String imei=await UtilidadesUtil.getMac();
    String datos;
    datos = imei + "|" + tipoAccion + "|" + DetalleAccion+ "|" + usuario+ "|" + ip;
    MiUpcAuditoriaApi auditoriaApi = new MiUpcAuditoriaApi();
    AuditoriaModel auditoriaModel;
    auditoriaModel = await auditoriaApi.realizaAuditoria(ctx, double.parse(la),double.parse(lo), datos);
  }
}