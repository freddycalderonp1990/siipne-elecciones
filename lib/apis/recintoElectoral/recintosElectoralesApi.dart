part of '../apis.dart';

class RecintosElectoralesApi {
  static const String tag = "RecintosElectorales";

  Future<List<RecintosElectoral>> getRecintosElectoralesCercanos({
    @required BuildContext context,
    @required String latitud,
    @required String longitud,
    @required String idDgoProcElec,
    @required String idDgoTipoEje,
    String msj1='',  String title=''
  }) async {
    try {
      String titleJson = "recintosElectorales";

      Map<String, String> parametros;
      parametros = {
        ConstApi.varOpc: ConstApi.ConsultarRecintosElectorales,
        "latitud": latitud,
        "longitud": longitud,
        "idDgoProcElec": idDgoProcElec,
        "idDgoTipoEje": idDgoTipoEje,

      };

      String msgMostar='No existen Recintos Electorales Cercanos',titleMostrar='Recintos Electorales';
      if(msj1!=''){
        msgMostar=msj1;
      }

      if(title!=''){
        titleMostrar=title;
      }


      //cUANDO SE NECESITA LOS METODOS ESPECIFICO PARA CADA MODULO SE ENVIA POR PARAMETRO EL MODULO CORRESPONDIENTE

      final json = await UrlApi.getUrl(context, parametros,
          modulo: ConstApi.moduloRecintoElectoral);

      if (json == null) {
        return null;
      }

      //se verifica que el servidor envie una respuesta valida
      String msj =
          ResponseApi.validateConsultas(json: json, titleJson: titleJson);

      if (msj == ConstApi.varTrue) {
        String datos = getDatosModelFromString(json, titleJson);
        print("el mensjae ${datos}");
        List<RecintosElectoral> list =
            RecintosElectoralsModelFromJson(datos).RecintosElectorals;

        if (list.length > 0) {
          return list;
        } else {


          DialogosWidget.alert(context,
              title: titleMostrar,
              message: msgMostar);
          return new List();
        }
      } else {
        if (msj == ConstApi.varNoExiste) {
          DialogosWidget.alert(context, onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
              title: titleMostrar,
              message: msgMostar);
        } else {
          DialogosWidget.error(context, message: msj);
        }

        return new List();
      }
    } catch (e) {
      String msj = tag + " No se cargan los Recintos Cercanos ${e.toString()}";
      print(msj);
      DialogosWidget.error(context, message: msj);

      throw new Exception('[${msj}]');
    }
  }



  Future<List<RecintosElectoral>> getAllUnidadesPoliciales({
    @required BuildContext context,
    @required String usuario,

  }) async {
    try {
      String titleJson = "recintosElectorales";

      Map<String, String> parametros;
      parametros = {
        ConstApi.varOpc: ConstApi.ConsultarAllUnidadesPoliciales,
        "usuario": usuario,

      };

      String titleMostrar='Unidades Policiales';

      String msgMostar='No existen Unidades Policiales';



      //cUANDO SE NECESITA LOS METODOS ESPECIFICO PARA CADA MODULO SE ENVIA POR PARAMETRO EL MODULO CORRESPONDIENTE

      final json = await UrlApi.getUrl(context, parametros,
          modulo: ConstApi.moduloSiipneMovil);

      if (json == null) {
        return null;
      }

      //se verifica que el servidor envie una respuesta valida
      String msj =
      ResponseApi.validateConsultas(json: json, titleJson: titleJson);



      if (msj == ConstApi.varTrue) {
        String datos = getDatosModelFromString(json, titleJson);
        print("el mensjae ${datos}");
        List<RecintosElectoral> list =
            RecintosElectoralsModelFromJson(datos).RecintosElectorals;

        if (list.length > 0) {
          return list;
        } else {


          DialogosWidget.alert(context,
              title: titleMostrar,
              message: msgMostar);
          return new List();
        }
      } else {
        if (msj == ConstApi.varNoExiste) {
          DialogosWidget.alert(context, onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
              title: titleMostrar,
              message: msgMostar);
        } else {
          DialogosWidget.error(context, message: msj);
        }

        return new List();
      }
    } catch (e) {
      String msj = tag + " No se cargan las Unidades Policiales  ${e.toString()}";
      print(msj);
      DialogosWidget.error(context, message: msj);

      throw new Exception('[${msj}]');
    }
  }

  Future<AbrirRecintoElectoral> abrirRecintoElectoral({
    @required BuildContext context,
    @required String usuario,
    @required String idGenPersona,
    @required String idDgoReciElect,
    @required String latitud,
    @required String longitud,
    @required String idDgoProcElec,
    @required String idDgoReciUnidadPolicial,
    @required String telefono,

  }) async {
    try {
      String titleJson = "AbrirRecintoElectoral";

      Map<String, String> parametros;
      String ip = await UtilidadesUtil.getIp();
      parametros = {
        ConstApi.varOpc: ConstApi.AbrirRecintoElectoral,
        "usuario": usuario,
        "idGenPersona": idGenPersona,
        "idDgoReciElect": idDgoReciElect,
        "ip": ip,
        "latitud": latitud,
        "longitud": longitud,
        "idDgoProcElec": idDgoProcElec,
        "idDgoReciUnidadPolicial": idDgoReciUnidadPolicial,
        "telefono": telefono,
      };

      print("abrirRecintoElectoral");

      //cUANDO SE NECESITA LOS METODOS ESPECIFICO PARA CADA MODULO SE ENVIA POR PARAMETRO EL MODULO CORRESPONDIENTE

      final json = await UrlApi.getUrl(context, parametros,
          modulo: ConstApi.moduloRecintoElectoral);

      if (json == null) {
        return null;
      }

      //se verifica que el servidor envie una respuesta valida
      String msj =
          ResponseApi.validateConsultas(json: json, titleJson: titleJson);

      print(msj);

      if (msj == ConstApi.varTrue) {


        String datos = getDatosModelFromString(json, titleJson);

        print(datos);
        AbrirRecintoElectoral abrirRecintoElectoral =
            abrirRecintoElectoralModelFromJson(datos).abrirRecintoElectoral;





        return abrirRecintoElectoral;
      }
      else{

        DialogosWidget.alert(context,
            title: "Recintos Electorales",
            message: "No se realizó el registro. " + msj);
      }


    } catch (e) {
      String msj = tag + " No se crea el código ${e.toString()}";
      print(msj);
      DialogosWidget.error(context, message: msj);

      throw new Exception('[${msj}]');
    }
  }

//Sirve para agregar y registrar personal en recinto electoral
  Future<ResgistroPersEnRecElectoral> asignarPersonalEnRecintoElectoral({
    @required BuildContext context,
    @required String idDgoCreaOpReci,
    @required String idGenPersona,
    @required String usuario,
    @required String latitud,
    @required String longitud,
    @required String idDgoReciElect,
    @required String idDgoTipoEje,
    @required String idRecintoElectoral

  }) async {
    try {
      String titleJson = "resgistroPersEnRecElectoral";

      Map<String, String> parametros;
      String ip = await UtilidadesUtil.getIp();
      parametros = {
        ConstApi.varOpc: ConstApi.AsignarPersonalEnRecintoElectoral,
        "idDgoCreaOpReci": idDgoCreaOpReci,
        "idGenPersona": idGenPersona,
        "usuario": usuario,
        "ip": ip,
        "latitud": latitud,
        "longitud": longitud,
        "idDgoReciElect": idDgoReciElect,
        "idDgoTipoEje": idDgoTipoEje,
        "idRecintoElectoral": idRecintoElectoral,
      };

      //cUANDO SE NECESITA LOS METODOS ESPECIFICO PARA CADA MODULO SE ENVIA POR PARAMETRO EL MODULO CORRESPONDIENTE

      final json = await UrlApi.getUrl(context, parametros,
          modulo: ConstApi.moduloRecintoElectoral);

      if (json == null) {
        return null;
      }

      //se verifica que el servidor envie una respuesta valida
      String msj =
          ResponseApi.validateConsultasExiste(json: json, titleJson: titleJson);

      //Verificamos si existe

      ResgistroPersEnRecElectoral _resgistroPersEnRecElectoral =
          new ResgistroPersEnRecElectoral(nomRecintoElec: "");

      if (msj == ConstApi.varExiste) {
        String datos = getDatosModelFromString(json, titleJson);
        _resgistroPersEnRecElectoral =
            resgistroPersEnRecElectoralModelFromJson(datos)
                .resgistroPersEnRecElectoral;

        DialogosWidget.alert(context,
            title: "Recintos Electorales",
            message: "Ya se encuentra asignado al recinto electoral \n" +
                _resgistroPersEnRecElectoral.nomRecintoElec +
              /*  "\n\nJefe/Encargado\n" +
                _resgistroPersEnRecElectoral.encargado +*/
                "\n\nPara poder ser asignado a un nuevo recinto electoral abandone el recinto anterior y vuelva a intentar.");

        return _resgistroPersEnRecElectoral;
      } else {
        //validamos de que se inserte
        //se verifica que el servidor envie una respuesta valida
        String msj =
            ResponseApi.validateConsultas(json: json, titleJson: titleJson);

        if (msj == ConstApi.varTrue) {
          DialogosWidget.alert(context, onTap: () {
            UtilidadesUtil.pantallasAbrirNuevaCerrarTodas(context: context,pantalla: AppConfig.pantallaVerificarOperativoRecintoAbierto);
            /*Navigator.pushReplacementNamed(
                context, AppConfig.pantallaMenuRecintoElectoral);*/
          },
              title: "Recintos Electorales",
              message: "Registro Realizado con éxito!.");
        } else {
          DialogosWidget.alert(context,
              title: "Recintos Electorales",
              message: "No se realizó el registro. " + msj);
        }
      }
    } catch (e) {
      String msj = tag + " No se asigna el Personal ${e.toString()}";
      print(msj);
      DialogosWidget.error(context, message: msj);

      throw new Exception('[${msj}]');
    }
  }

  Future<RecintosElectoralesAbiertos>
      verificarPersonalEncargadoAsignadoRecElectPorIdGenPersona({
    @required BuildContext context,
    @required String idGenPersona,
  }) async {
    try {
      String titleJson = "recintosElectoralesAbiertos";
      Map<String, String> parametros;

      parametros = {
        ConstApi.varOpc:
            ConstApi.VerificarPersonalEncargadoAsignadoRecElectPorIdGenPersona,
        "idGenPersona": idGenPersona,
      };

      print("consulto");

      //cUANDO SE NECESITA LOS METODOS ESPECIFICO PARA CADA MODULO SE ENVIA POR PARAMETRO EL MODULO CORRESPONDIENTE

      final json = await UrlApi.getUrl(context, parametros,
          modulo: ConstApi.moduloRecintoElectoral);

      if (json == null) {
        return null;
      }

      //se verifica que el servidor envie una respuesta valida
      String msj =
          ResponseApi.validateConsultas(json: json, titleJson: titleJson);

      //Verificamos si existe

      RecintosElectoralesAbiertos _RecintosElectoralesAbiertos =
          new RecintosElectoralesAbiertos(
              nomRecintoElec: "", idDgoCreaOpReci: "0",idDgoReciElect: "0");

      if (msj == ConstApi.varTrue) {
        String datos = getDatosModelFromString(json, titleJson);
        _RecintosElectoralesAbiertos =
            recintosElectoralesAbiertosModelFromJson(datos)
                .recintosElectoralesAbiertos;
      }

      return _RecintosElectoralesAbiertos;
    } catch (e) {
      String msj = tag +
          "${e.toString()}";
      print(msj);
      DialogosWidget.error(context, message: msj);

      throw new Exception(
          '[No se Verifica el Personal -${msj}]');
    }
  }

  Future<DatosRecintoElectoralClass>
      consultarDatosEncargadoRecintoPoridCreaRecinto({
    @required BuildContext context,
    @required String idDgoCreaOpReci,
  }) async {
    try {
      String titleJson = "datosRecintoElectoral";

      Map<String, String> parametros;

      parametros = {
        ConstApi.varOpc:
            ConstApi.ConsultarDatosEncargadoRecintoPoridCreaRecinto,
        "idDgoCreaOpReci": idDgoCreaOpReci,
      };

      //CUANDO SE NECESITA LOS METODOS ESPECIFICO PARA CADA MODULO SE ENVIA POR PARAMETRO EL MODULO CORRESPONDIENTE

      final json = await UrlApi.getUrl(context, parametros,
          modulo: ConstApi.moduloRecintoElectoral);

      if (json == null) {
        return null;
      }

      //se verifica que el servidor envie una respuesta valida
      String msj =
          ResponseApi.validateConsultas(json: json, titleJson: titleJson);
      print("validateConsultas");
      print(msj);

      if (msj == ConstApi.varTrue) {
        String datos = getDatosModelFromString(json, titleJson);

        print(datos);
        DatosRecintoElectoralClass _datos =
            datosRecintoElectoralFromJson(datos).datosRecintoElectoral;

        return _datos;
      } else {
        DialogosWidget.alert(context,
            title: "Operativos",
            message:
                "No existen Operativos con este Código");
        return new DatosRecintoElectoralClass(nomRecintoElec: "");
      }
    } catch (e) {
      String msj = tag +
          "${e.toString()}";
      print(msj);
      DialogosWidget.error(context, message: msj);

      throw new Exception(
          '[No Consulta datos del Encargado -${msj}]');
    }
  }




  Future<bool> eliminarRecintoElectoralAbierto({
    @required BuildContext context,
    @required String idDgoCreaOpReci,
    @required String usuario,
    String msj1='',String title=''
  }) async {
    try {
      String titleJson = "eliminarRecintoElectoral";

      Map<String, String> parametros;
      String ip = await UtilidadesUtil.getIp();
      parametros = {
        ConstApi.varOpc: ConstApi.EliminarRecintoElectoralAbierto,
        "usuario": usuario,
        "idDgoCreaOpReci": idDgoCreaOpReci,
        "ip": ip,
      };


      String msjMostrar='Recinto Electoral eliminado con éxito!. ',titleMostrar='Recintos Electorales';
      if(msj1!=''){
        msjMostrar=msj1;
      }
      if(title!=''){
        titleMostrar=title;
      }


      //cUANDO SE NECESITA LOS METODOS ESPECIFICO PARA CADA MODULO SE ENVIA POR PARAMETRO EL MODULO CORRESPONDIENTE

      final json = await UrlApi.getUrl(context, parametros,
          modulo: ConstApi.moduloRecintoElectoral);

      if (json == null) {
        return null;
      }

      print("el json");
      print(json);

      //se verifica que el servidor envie una respuesta valida
      String msj =
      await ResponseApi.validateInsert(json: json, titleJson: titleJson);
      print("el msj");
      print(msj);

      if (msj == ConstApi.varTrue) {
        print("estamos aquii");
        DialogosWidget.alert(context,
            title: titleMostrar,
            message: msjMostrar ,
        onTap: (){
         /* Navigator.pushReplacementNamed(
              context, AppConfig.pantallaMenuRecintoElectoral);*/

          UtilidadesUtil.pantallasAbrirNuevaCerrarTodas(context: context,pantalla: AppConfig.pantallaVerificarOperativoRecintoAbierto);

        
        });
        return true;
      }

      else{

        DialogosWidget.alert(context,
            title: titleMostrar,
            message: "No se pudo eliminar el ${titleMostrar}. Vuelva a intentarlo, o consulte con el administrador del sistema " + msj);
        return false;
      }


   } catch (e) {
      String msj = tag + "${e.toString()}";
      print(msj);
      DialogosWidget.error(context, message: msj);

      throw new Exception('[No se elimina el Operativo-${msj}]');
    }
  }


  Future<bool> abandonarRecintoElectoral({
    @required BuildContext context,
    @required String idDgoPerAsigOpe,
    @required String usuario,
    @required String latitud,
    @required String longitud,
    String msjDialogo,
    String msj1='',String title=''

  }) async {
    try {
      print('abandonar');
      String titleJson = "abandonarRecintoElectoral";

      Map<String, String> parametros;
      String ip = await UtilidadesUtil.getIp();
      parametros = {
        ConstApi.varOpc: ConstApi.AbandonarRecintoElectoral,
        "usuario": usuario,
        "idDgoPerAsigOpe": idDgoPerAsigOpe,
        "ip": ip,
        "latitud": latitud,
        "longitud": longitud,
      };



      String msjMostrar='Usted  Abandonó con éxito el recinto Electoral!.',titleMostrar='Recintos Electorales';

      if(msj1!=''){
        msjMostrar=msj1;
      }
      if(title!=''){
        titleMostrar=title;
      }

      //cUANDO SE NECESITA LOS METODOS ESPECIFICO PARA CADA MODULO SE ENVIA POR PARAMETRO EL MODULO CORRESPONDIENTE

      final json = await UrlApi.getUrl(context, parametros,
          modulo: ConstApi.moduloRecintoElectoral);

      if (json == null) {
        return null;
      }

      //se verifica que el servidor envie una respuesta valida
      String msj =
      await ResponseApi.validateInsert(json: json, titleJson: titleJson);

      print(msj);

      if (msj == ConstApi.varTrue) {

        DialogosWidget.alert(context,
            title: titleMostrar,
            message: msjDialogo==null? msjMostrar: msjDialogo ,
            onTap: (){
             /* Navigator.pushReplacementNamed(
                  context, AppConfig.pantallaMenuRecintoElectoral);*/

              UtilidadesUtil.pantallasAbrirNuevaCerrarTodas(context: context,pantalla: AppConfig.pantallaVerificarOperativoRecintoAbierto);
            });
        return true;
      }

      else{

        DialogosWidget.alert(context,
            title: titleMostrar,
            message: "No pudo abandonar el ${titleMostrar}. Vuelva a intentarlo, o consulte con el administrador del sistema " + msj);
        return false;
      }


    } catch (e) {
      String msj = tag + "No pudo abandonar el ${e.toString()}";
      print(msj);
      DialogosWidget.error(context, message: msj);

      throw new Exception(msj);
    }
  }


  Future<bool> finalizarRecintoElectoral({
    @required BuildContext context,
    @required String idDgoCreaOpReci,
    @required String usuario,
    @required String idDgoPerAsigOpe,
    @required String idDgoTipoEje,

    String msj1='',String title=''
  }) async {
    try {
      String titleJson = "finalizarRecintoElectoral";

      Map<String, String> parametros;
      String ip = await UtilidadesUtil.getIp();
      parametros = {
        ConstApi.varOpc: ConstApi.FinalizarRecintoElectoral,
        "usuario": usuario,
        "idDgoCreaOpReci": idDgoCreaOpReci,
        "ip": ip,
        "idDgoPerAsigOpe": idDgoPerAsigOpe,
        "idDgoTipoEje":idDgoTipoEje

      };
      String msjMostrar='Usted finalizó con éxito el recinto Electoral!.',titleMostrar='Recintos Electorales';
      if(msj1!=''){
        msjMostrar=msj1;
      }
      if(title!=''){
        titleMostrar=title;
      }
      //cUANDO SE NECESITA LOS METODOS ESPECIFICO PARA CADA MODULO SE ENVIA POR PARAMETRO EL MODULO CORRESPONDIENTE

      final json = await UrlApi.getUrl(context, parametros,
          modulo: ConstApi.moduloRecintoElectoral);

      if (json == null) {
        return null;
      }

      //se verifica que el servidor envie una respuesta valida
      String msj =
      await ResponseApi.validateInsert(json: json, titleJson: titleJson);

      print(msj);




      if (msj == ConstApi.varTrue) {

        DialogosWidget.alert(context,
            title: titleMostrar,
            message: msjMostrar,
            onTap: (){
             /* Navigator.pushReplacementNamed(
                  context, AppConfig.pantallaMenuRecintoElectoral);*/
              UtilidadesUtil.pantallasAbrirNuevaCerrarTodas(context: context,pantalla: AppConfig.pantallaVerificarOperativoRecintoAbierto);
            });
        return true;
      }

      else{
        print(json);

        FinalizarRecintoElectoral finalizarProcesoElectoralModel=    FinalizarProcesoElectoralModel.fromJson(json).finalizarRecintoElectoral;

        DialogosWidget.alert(context,
            title: titleMostrar,
            message: "No se pudo finalizar  ${titleMostrar}. La Hora para finalizar es ${finalizarProcesoElectoralModel.datos.horaValidate}. ");
        return false;
      }


    } catch (e) {
      String msj = tag + "No finaliza el operativo ${e.toString()}";
      print(msj);
      DialogosWidget.error(context, message: msj);

      throw new Exception(msj);
    }
  }



  Future<List<PersonalRecintoElectoral>>
  consultarDatosPersonalAsignadoRecintoElectoral({
    @required BuildContext context,
    @required String idDgoCreaOpReci,
  }) async {
    try {
      String titleJson = "personalRecintoElectoral";

      Map<String, String> parametros;

      parametros = {
        ConstApi.varOpc:
        ConstApi.ConsultarPersonalAsignadoRecintoElectoral,
        "idDgoCreaOpReci": idDgoCreaOpReci,
      };

      //CUANDO SE NECESITA LOS METODOS ESPECIFICO PARA CADA MODULO SE ENVIA POR PARAMETRO EL MODULO CORRESPONDIENTE
      final json = await UrlApi.getUrl(context, parametros,
          modulo: ConstApi.moduloRecintoElectoral);

      if (json == null) {
        return null;
      }

      //se verifica que el servidor envie una respuesta valida
      String msj =
      ResponseApi.validateConsultas(json: json, titleJson: titleJson);


      if (msj == ConstApi.varTrue) {
        String datos = getDatosModelFromString(json, titleJson);
        List<PersonalRecintoElectoral> _datos =
            personalRecintoElectoralModelFromJson(datos).personalRecintoElectoral;

        return _datos;
      } else {
        DialogosWidget.alert(context,
            title: "Personal",
            message:
            "No existe personal asignado");
        return new List();
      }
    } catch (e) {
      String msj = tag +
          "${e.toString()}";
      print(msj);
      DialogosWidget.error(context, message: msj);

      throw new Exception(
          '[ No consulta los datos del Personal -${msj}]');
    }
  }

}
