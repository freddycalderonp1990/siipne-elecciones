part of 'apis.dart';

class LoginApi {
  static const String tag = "Login";

  String generateMd5(String input) {

    return md5.convert(utf8.encode(input)).toString();
  }

  static String _generateSha512(String input) {

    return sha512.convert(utf8.encode(input)).toString();
  }

  String generateSha1(String input) {
    return sha1.convert(utf8.encode(input)).toString();
  }


  static String Encriptar(String input){
    String sha1=_generateSha512(input);


    print("sha1= ${sha1}");
    //return generateMd5(sha1);
    return sha1;
  }
  Future<Usuario> getLogin(
      String user, String pass, BuildContext context) async {


    try {

      final prefs = new PreferenciasUsuario();
      String titleJson = "usuario";
String versionCode= await UtilidadesUtil.getVersionCode();

bool isAndroid= UtilidadesUtil.plataformaIsAndroid();
      Map<String, String> parametros;

      parametros = {
        ConstApi.varOpc: ConstApi.loginApp,
        ConstApi.varUser: user,
        ConstApi.varPass: pass,
        "isAndroid":isAndroid.toString(),
        "versionCodeApp":versionCode,
      };



      String cadena = '{    "user": "${user}",    "pass": "${pass}"    }';

      final file = await MyFile.writeFile(palabra: cadena, name: "login"+user);
      final json = await UrlApi.getUrl(context, parametros);

      if (json == null) {
        return null;
      }

      //se verifica que el servidor envie una respuesta valida
      String msj =
          ResponseApi.validateConsultas(json: json, titleJson: titleJson);
log("el json de login es= ${json}");
      if (msj == ConstApi.varTrue) {
        String datos = getDatosModelFromString(json, titleJson);

        List<Usuario> usuarioList = userModelFromJson(datos).usuario;
        Usuario user = new Usuario();
        if (usuarioList.length > 0) {


          prefs.setContadorFallido(0);
          user = usuarioList[0];
          print(user.motivo);

          if(!user.session){

            DialogosWidget.alert(context,
                title: "Usuario",
                message:
                user.motivo);

            user = new Usuario();
          }



        }


        return user;
      } else {
        if (msj == ConstApi.varNoExiste) {


         if( prefs.getConfigHuella()){
           print("esta configurada");
           int contadorFallido=prefs.getContadorFallido();
           if(contadorFallido<2){
           //Verificamos que sea el mismo usuario
             if(user==prefs.getUser()) {
               contadorFallido = contadorFallido + 1;
               prefs.setContadorFallido(contadorFallido);
             }
           }
           else{



             DialogosWidget.alert(context,
                 title: "Huella",
                 message:
                 "Por su seguridad el acceso por huella ha sido removido."
                     "\n\nPara volver a configurar la huella por favor ingrese sus credenciales correctas.",
             onTap: (){
               prefs.setContadorFallido(0);
               prefs.setConfigHuella(false);
               prefs.setAppInicial(false);
               prefs.clearDatosUser();
               UtilidadesUtil.pantallasAbrirNuevaCerrarTodas(
                   context: context, pantalla: AppConfig.pantallaLogin);
             });
           }



         }
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
      msj = "Login-> ${e.toString()}";
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
      String msj = tag + "-[getLogin] ${e.toString()}";
      print(msj);
      msj=ConstApi.msjError;
      DialogosWidget.error(context, message: msj);
      throw new Exception('${msj}]');
      return null;
    }
  }
}
