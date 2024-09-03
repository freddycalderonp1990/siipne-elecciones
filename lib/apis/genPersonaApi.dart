part of 'apis.dart';

class GenPersonaApi {
  static const String tag = "Persona";

  Future<DatosPer> getDatosPersona(
      {@required BuildContext context,
        @required String cedula,
        @required String usuario}) async {
    try {
      String titleJson = "dataPersona";
      Map<String, String> parametros;
      parametros = {
        ConstApi.varOpc: ConstApi.ConsultarDatosPersonaPorCedula,
        "cedula": cedula,
        "usuario": usuario,
      };

      DatosPer _datos=new DatosPer(apenom: "",idGenPersona: "0");
      String json = await UrlApi.getUrl(context, parametros,
          modulo: ConstApi.moduloSiipneMovil);


      //se verifica que el servidor envie una respuesta valida
      String msj =
      ResponseApi.validateConsultasExiste(json: json, titleJson: titleJson);
      print("existen datos");
      print(msj);

      if (msj == ConstApi.varExiste) {

        print("existen ssii datos");

        String datos = getDatosModelFromString(json, titleJson);
        print("existen datos");
        print(datos);

        List<DatosPer> datosPers = datosPersModelFromJson(datos).datosPers;

        if (datosPers.length > 0) {
          _datos = datosPers[0];
        }

      } else {
        DialogosWidget.error(context, message: msj);

      }

      return _datos;
    } catch (e) {
      String msj = tag + "[ ${e.toString()} ]";
      msj=ConstApi.msjError;
      DialogosWidget.error(context, message: msj);
      throw new Exception('[No se obtiene los datos de la Persona -${msj}]');
      return null;
    }
  }


}
