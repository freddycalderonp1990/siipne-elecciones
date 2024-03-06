part of 'apis.dart';

class GenDivPolitica {
  static const String tag = "GenDivPolitica";

  Future< List<Provincia>> getProvincia(BuildContext context) async {
    try {
      String titleJson = "provincias";
      Map<String, String> parametros;
      parametros = {
        ConstApi.varOpc: ConstApi.ConsultarProvincias,
      };

      final json = await UrlApi.getUrl(context, parametros,);

      //se verifica que el servidor envie una respuesta valida
      String msj =
          ResponseApi.validateConsultas(json: json, titleJson: titleJson);

      if (msj == ConstApi.varTrue) {

        String datos= getDatosModelFromString(json, titleJson);


        List<Provincia> _ProvinciaModel = provinciaModelFromJson(datos).provincias;
        return _ProvinciaModel;

      } else {
        DialogosWidget.error(context, message: msj);
        return null;
      }
    }  catch (e) {
      String msj = tag + " No se pudo cargar las Provincias [ ${e.toString()} ]";
      msj=ConstApi.msjError;
      DialogosWidget.error(context, message: msj);
      throw new Exception('[${msj}]');
      return null;
    }
  }

  Future< List<Provincia>> getCantones(BuildContext context,int idGenProvincia) async {
    try {
      String titleJson = "cantones";
      Map<String, String> parametros;
      parametros = {
        ConstApi.varOpc: ConstApi.ConsultarCantones,
        "idGenProvincia": idGenProvincia.toString(),
      };

      final json = await UrlApi.getUrl(context, parametros,);

      //se verifica que el servidor envie una respuesta valida
      String msj =
      ResponseApi.validateConsultas(json: json, titleJson: titleJson);

      if (msj == ConstApi.varTrue) {

        String datos= getDatosModelFromString(json, titleJson);


        List<Provincia> _ProvinciaModel = provinciaModelFromJson(datos).provincias;
        return _ProvinciaModel;

      } else {
        DialogosWidget.error(context, message: msj);
        return null;
      }
    }  catch (e) {
      String msj = tag + " No se pudo cargar los Cantones [ ${e.toString()} ]";
      msj=ConstApi.msjError;
      DialogosWidget.error(context, message: msj);
      throw new Exception('[${msj}]');
      return null;
    }
  }
}
