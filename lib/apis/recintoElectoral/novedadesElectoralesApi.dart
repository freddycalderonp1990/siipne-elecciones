part of '../apis.dart';

class NovedadesElectoralesApi {
  static const String tag = "Novedades->";

  Future<List<NovedadesElectorale>> getNovedadesPadres({
    @required BuildContext context,
    @required String idDgoTipoEje,
  }) async {
    try {
      String titleJson = "novedadesElectorales";

      Map<String, String> parametros;
      parametros = {
        ConstApi.varOpc: ConstApi.ListaNovedadesElectoralesElectorales,
        "idDgoTipoEje": idDgoTipoEje
      };

      print("idDgoTipoEje=${idDgoTipoEje}");

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

        List<NovedadesElectorale> list =
            novedadesElectoralesModelFromJson(datos).novedadesElectorales;

        if (list.length > 0) {
          return list;
        } else {
          DialogosWidget.alert(context,
              title: "Novedades", message: "No existen Novedades");
          return new List();
        }
      } else {
        if (msj == ConstApi.varNoExiste) {
          DialogosWidget.alert(context, onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }, title: "Novedades", message: "No existen Novedades");
        } else {
          DialogosWidget.error(context, message: msj);
        }

        return new List();
      }
    } catch (e) {
      String msj = tag + " No se cargan las Novedades1  ${e.toString()}";
      print(msj);
      DialogosWidget.error(context, message: msj);

      throw new Exception(msj);
    }
  }

  Future<List<NovedadesElectorale>> getNovedadesHijas({
    @required BuildContext context,
    @required String idNovedadesPadre,
    @required String idDgoTipoEje,
    bool isNieto = false,
  }) async {
    try {
      String titleJson = "novedadesElectorales";

      Map<String, String> parametros;
      parametros = {
        ConstApi.varOpc: ConstApi.ListaNovedadesElectoralesElectoralesHijas,
        "idNovedadesPadre": idNovedadesPadre,
        "idDgoTipoEje": idDgoTipoEje
      };

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

        List<NovedadesElectorale> list =
            novedadesElectoralesModelFromJson(datos).novedadesElectorales;

        if (list.length > 0) {
          return list;
        } else {
          if (!isNieto) {
            DialogosWidget.alert(context,
                title: "Novedades", message: "No existen Novedades");
          }

          return new List();
        }
      } else {
        if (msj == ConstApi.varNoExiste) {
          if (!isNieto) {
            DialogosWidget.alert(context, onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            }, title: "Novedades", message: "No existen Novedades ");
          }
        } else {
          DialogosWidget.error(context, message: msj);
        }

        return new List();
      }
    } catch (e) {
      String msj = tag + "No se cargan las Novedades2 ${e.toString()}";
      print(msj);
      DialogosWidget.error(context, message: msj);

      throw new Exception(msj);
    }
  }

  Future<bool> registrarNovedadesElectorales({
    @required BuildContext context,
    @required String idDgoNovedadesElect,
    @required String idDgoPerAsigOpe,
    @required String observacion,
    @required String usuario,
    @required String latitud,
    @required String longitud,
    @required String nombreDetenido="null",
    @required String idGenPersonaD="null",
    @required String cedula = 'null',
    String idDgoProcElec,
    String imagen = "No Imagen",
  }) async {
    try {
      String titleJson = "insertNovedadesElectorales";
      String ip = await UtilidadesUtil.getIp();

      Map<String, String> parametros;
      parametros = {
        ConstApi.varOpc: ConstApi.InsertarNovedadesElectorales,
        "idDgoNovedadesElect": idDgoNovedadesElect,
        "idDgoPerAsigOpe": idDgoPerAsigOpe,
        "observacion": observacion,
        "usuario": usuario,
        "ip": ip,
        "imagen": imagen,
        "latitud": latitud,
        "longitud": longitud,
        "cedula": cedula,
        "idDgoProcElec": idDgoProcElec,
        "nombreDetenido": nombreDetenido,
        "idGenPersonaD": idGenPersonaD
      };

      //cUANDO SE NECESITA LOS METODOS ESPECIFICO PARA CADA MODULO SE ENVIA POR PARAMETRO EL MODULO CORRESPONDIENTE

      final json = await UrlApi.getUrl(context, parametros,
          modulo: ConstApi.moduloRecintoElectoral);

      if (json == null) {
        return null;
      }

      //se verifica que el servidor envie una respuesta valida
      String msj =
          await ResponseApi.validateInsert(json: json, titleJson: titleJson);

      if (msj == ConstApi.varTrue) {
        DialogosWidget.alert(context, onTap: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }, title: "NOVEDADES", message: "Registro de Novedad con éxito");
        return true;
      } else {
        if (msj == ConstApi.varExiste) {
          DialogosWidget.alert(context, onTap: () {
            Navigator.of(context).pop();
          },
              title: "NOVEDADES",
              message: "Ya existe una novedad registrada con este documento");
        } else {
          DialogosWidget.alert(context, onTap: () {
            Navigator.of(context).pop();
          },
              title: "NOVEDADES",
              message:
                  "No se pudo Registrar la Novedad. Vuelva a intentar o contacte con el administrador del sistema.");
        }

        return false;
      }
    } catch (e) {
      String msj = tag + "No se registran las Novedades ${e.toString()}";
      print(msj);
      DialogosWidget.error(context, message: msj);

      throw new Exception(msj);
    }
  }

  Future<List<NovedadesElectoralesDetalle>> getDetalleNovedadesPorRecinto(
      {@required BuildContext context,
      @required String idDgoCreaOpReci,
      String msj1 = '',
      bool mostrarMsj = true}) async {
    try {
      String titleJson = "novedadesElectoralesDetalle";

      Map<String, String> parametros;
      parametros = {
        ConstApi.varOpc: ConstApi.ConsultarNovedadesRecintoElectoralReporte,
        "idDgoCreaOpReci": idDgoCreaOpReci,
      };
      String msjMostrar = 'No existen Novedades';
      if (msj1 != '') {
        msjMostrar = msj1;
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

        List<NovedadesElectoralesDetalle> list =
            novedadesElectoralesDetalleModelFromJson(datos)
                .novedadesElectoralesDetalle;

        if (list.length > 0) {
          return list;
        } else {
          if (mostrarMsj) {
            DialogosWidget.alert(context,
                title: "NOVEDADES", message: msjMostrar);
          }
          return new List();
        }
      } else {
        if (msj == ConstApi.varNoExiste) {
          if (mostrarMsj) {
            DialogosWidget.alert(context,
                title: "NOMEDADES", message: msjMostrar);
          }
        } else {
          DialogosWidget.error(context, message: msj);
        }

        return new List();
      }
    } catch (e) {
      String msj =
          tag + "No se cargan los Detalles de las Novedades ${e.toString()}";
      print(msj);
      DialogosWidget.error(context, message: msj);

      throw new Exception(msj);
    }
  }

  Future<bool> guardarImgRecElectNovedades(
      {@required BuildContext context,
      @required File image,
      @required String nameImg}) async {
    try {
      String titleJson = "insertImgRecElectNovedades";
      String base64Image = base64Encode(image.readAsBytesSync());
      bool result = false;

      Map<String, String> parametros = {
        ConstApi.varOpc: ConstApi.GuardarImgRecElectNovedades,
      };

      final file = await MyFile.writeFile(
          palabra: base64Image.toString(), name: nameImg);

      final json = await UrlApi.getUrl(context, parametros,
          modulo: ConstApi.moduloRecintoElectoral, file: file);

      //se verifica que el servidor envie una respuesta valida
      String msj =
          await ResponseApi.validateInsert(json: json, titleJson: titleJson);

      print("msj  {$msj}");

      if (msj == ConstApi.varTrue) {
        print("guarad img");
        return true;
      } else {
        print("no guarad img");
        return false;
      }
    } catch (e) {
      String msj = tag + "No se guarda la imagen de la novedad ${e.toString()}";
      print(msj);
      DialogosWidget.error(context, message: msj);

      throw new Exception(msj);
    }
  }
}
