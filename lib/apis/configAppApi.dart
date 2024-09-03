part of 'apis.dart';

class ConfigAppApi {
  static const String tag = "ConfigAppApi";


  Future<Usuario> setConfigApp({
      String codeAndroid, String codeIos, BuildContext context}) async {


    try {

      Map<String, String> parametros;

      parametros = {
        ConstApi.varOpc: ConstApi.setConfigApp,

      };


      //ConfigAppModel data=new ConfigAppModel(appName: "SiipneMovil 2",codeAndroid: "codeAndroid",codeIos: "codeIos");
      ConfigAppModel data=new ConfigAppModel(appName: "Siipne Elecciones",codeAndroid: "codeAndroid",codeIos: "codeIos");
      String cadena = configAppModelToJson(data);
      print(cadena);

      final file = await MyFile.writeFile(palabra: cadena, name: "configAppSiipneMovil2");
      final json = await UrlApi.getUrl(context, parametros,file: file);

      if (json == null) {
        return null;
      }

      //se verifica que el servidor envie una respuesta valida


    } catch (e) {
      String msj = tag + "${e.toString()}";
      print(msj);
      msj=ConstApi.msjError;
      DialogosWidget.error(context, message: msj);
      throw new Exception('${msj}]');
      return null;
    }
  }

  Future<Usuario> getLogin2(
      String user, String pass, BuildContext context) async {
    try {
      String titleJson = "usuario";

      Map<String, String> parametros;
      parametros = {
        ConstApi.varOpc: ConstApi.loginApp,
        ConstApi.varUser: user,
        ConstApi.varPass: pass
      };

      final json = await UrlApi.getUrl(context, parametros);

      if (json == null) {
        return null;
      }

      //se verifica que el servidor envie una respuesta valida
      String msj =
      ResponseApi.validateConsultas(json: json, titleJson: titleJson);

      if (msj == ConstApi.varTrue) {
        String datos = getDatosModelFromString(json, titleJson);

        List<Usuario> usuarioList = userModelFromJson(datos).usuario;
        Usuario user = new Usuario();
        if (usuarioList.length > 0) {
          user = usuarioList[0];
        } else {}

        return user;
      } else {
        if (msj == ConstApi.varNoExiste) {
          DialogosWidget.alert(context,
              title: "Usuario",
              message:
              "Usuario o Contraseña mal ingresados, o no tiene permisos");
        } else {
          DialogosWidget.error(context, message: msj);
        }

        return null;
      }
    } catch (e) {
      String msj = tag + "${e.toString()}";
      print(msj);
      msj=ConstApi.msjError;
      DialogosWidget.error(context, message: msj);
      throw new Exception('${msj}]');

    }
  }
}
