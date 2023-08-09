part of 'apis.dart';

class ProcesosOperativosApi {
  static const String tag = "Operativos";
  Future< List<ProcesosOperativo>> getProcesosOperativos({BuildContext context,String latitud,String longitud}) async {
    try {
      String titleJson = "procesosOperativos";
      Map<String, String> parametros;
      parametros = {
        ConstApi.varOpc: ConstApi.ConsultarProcesosOperativos,
        "latitud": latitud,
        "longitud":longitud
      };

      final json = await UrlApi.getUrl(context, parametros,);

      //se verifica que el servidor envie una respuesta valida
      String msj =
      ResponseApi.validateConsultas(json: json, titleJson: titleJson);

      if (msj == ConstApi.varTrue) {

        String datos= getDatosModelFromString(json, titleJson);


        List<ProcesosOperativo> _ProcesosOperativo = procesosOperativosModelFromJson(datos).procesosOperativos;
        return _ProcesosOperativo;

      } else {
        DialogosWidget.error(context, message: msj);
        return null;
      }
    }  catch (e) {
      String msj = tag + " No se pudo cargar las Procesos-Operativos [ ${e.toString()} ]";
      msj=ConstApi.msjError;
      DialogosWidget.error(context, message: msj);
      throw new Exception('[${msj}]');
    
    }
  }
}
