part of '../../pages.dart';

class TipoEjeUnidadesPolicialesPage extends StatefulWidget {
  @override
  _TipoEjeUnidadesPolicialesPageState createState() =>
      _TipoEjeUnidadesPolicialesPageState();
}

class _TipoEjeUnidadesPolicialesPageState
    extends State<TipoEjeUnidadesPolicialesPage> {
  var peticionServer = false;
  UserProvider _UserProvider;
  ProcesoOperativoProvider _ProcesoOperativoProvider;
  bool cargaInicial = true;

  bool selectPadre = true;

  TiposEjesApi _TiposEjesApi = new TiposEjesApi();
  List<UnidadesPoliciale> _listUnidadesPolicialesPadres = new List();
  List<UnidadesPoliciale> _listUnidadesPolicialesHijas = new List();
  List<UnidadesPoliciale> _listUnidadesPolicialesNietas = new List();
  String unidadPolicialPadre, unidadPolicialHija, unidadPolicialNieta;
  int idUnidadPolicialPadre = 0,
      idUnidadPolicialHija = 0,
      idUnidadPolicialNieta = 0;

  //CONFIGURACIONES
  final anchoContenedor = AppConfig.anchoContenedor;
  final anchoContenedorHijos = AppConfig.anchoContenedorHijos;
  final paddingContenido = 10.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.bloc<MiUbicacionBloc>().iniciarSeguimiento();
    UtilidadesUtil.getTheme();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil(context);
    _UserProvider = UserProvider.of(context);
    _ProcesoOperativoProvider = ProcesoOperativoProvider.of(context);

    String Bienvenido = _UserProvider.getUser.sexo == 'HOMBRE'
        ? VariablesUtil.Bienvenido
        : VariablesUtil.Bienvenida;

    return WorkAreaPageWidget(
      mostrarVersion: false,
      btnAtras: true,
      peticionServer: peticionServer,
      title: VariablesUtil.UNIDADESPOLICIALES,
      sizeTittle: 7,
      contenido: [
        Container(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: responsive.altoP(2),
              ),
              MyUbicacionWidget(
                callback: (_) {
                  _getUnidadesPoliciales();
                },
              ),
              SizedBox(
                height: responsive.altoP(3),
              ),
              getCombos(responsive),
              SizedBox(
                height: responsive.altoP(8),
              ),
              btnContinuar(responsive),
              SizedBox(
                height: responsive.altoP(4),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<String> getDatosUnidadesPoliciales(
      List<UnidadesPoliciale> listUnidadesPoliciale) {
    List<String> datos = new List();
    try {
      for (int i = 0; i < listUnidadesPoliciale.length; i++) {
        datos.add(listUnidadesPoliciale[i].descripcion);
      }
      return datos;
    } catch (e) {
      return datos;
    }
  }

  int getIdUnidadPolicial(String descripcion, List<UnidadesPoliciale> lista) {
    int id = 0;
    try {
      for (int i = 0; i < lista.length; i++) {
        if (lista[i].descripcion == descripcion) {
          id = int.parse(lista[i].idDgoTipoEje);

          return id;
        }
      }
      return id;
    } catch (e) {
      return 0;
    }
  }

  Widget getCombos(ResponsiveUtil responsive) {
    return ContenedorDesingWidget(
        anchoPorce: anchoContenedor,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: paddingContenido),
          child: Column(
            children: [
              getComboNovedadesPadres(responsive),
              unidadPolicialPadre != null
                  ? getComboNovedadesHijos(responsive)
                  : Container(),
            ],
          ),
        ));
  }

  Widget getComboNovedadesPadres(ResponsiveUtil responsive) {
    List<String> datos =
        getDatosUnidadesPoliciales(_listUnidadesPolicialesPadres);
    return _listUnidadesPolicialesPadres.length > 0
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: paddingContenido),
            child: ComboConBusqueda(
              selectValue: unidadPolicialPadre,
              title: 'Subsistema',
              searchHint: 'Seleccione la ' + VariablesUtil.UnidadPolicial,
              datos: datos,
              complete: (dato) {
                selectPadre = true;
                setState(() async {
                  unidadPolicialPadre = dato;
                  unidadPolicialHija = null;
                  idUnidadPolicialHija = 0;
                  _listUnidadesPolicialesHijas = [];
                  if (unidadPolicialPadre != null) {
                    if (_listUnidadesPolicialesHijas.length > 0) {
                      unidadPolicialHija =
                          _listUnidadesPolicialesHijas[0].descripcion;
                      idUnidadPolicialHija = 0;
                      idUnidadPolicialHija = int.parse(
                          _listUnidadesPolicialesHijas[0].idDgoTipoEje);
                    }
                    int idNovedadPadre = getIdUnidadPolicial(
                        unidadPolicialPadre, _listUnidadesPolicialesPadres);
                    await _getUnidadesPolicialesHijasNivel1(idNovedadPadre);
                  }
                });
              },
            ))
        : Container(
            child: DetalleTextWidget(
              detalle: "No exiten Unidades Policiales",
            ),
          );
  }

  Widget getComboNovedadesHijos(ResponsiveUtil responsive) {
    List<String> datos =
        getDatosUnidadesPoliciales(_listUnidadesPolicialesHijas);
    if (datos.length == 0) {
      return Container();
    }
    if (selectPadre) {
      unidadPolicialHija = datos[0];
    }

    try {
      Widget wg = _listUnidadesPolicialesHijas.length > 0
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: paddingContenido),
              child: ComboConBusqueda(
                selectValue: unidadPolicialHija,
                title: "Unidad Polcial",
                searchHint: 'Seleccione la ' + VariablesUtil.UnidadPolicial,
                datos: datos,
                complete: (dato) {
                  selectPadre = false;
                  print(unidadPolicialHija);
                  print(dato);
                  setState(() {
                    unidadPolicialHija = dato;
                    idUnidadPolicialHija = 0;
                    if (unidadPolicialHija != null) {
                      idUnidadPolicialHija = getIdUnidadPolicial(
                          unidadPolicialHija, _listUnidadesPolicialesHijas);
                    }
                  });
                },
              ))
          : Container(
              child: DetalleTextWidget(
                detalle: "No exiten Unidades Policiales 1",
              ),
            );

      return wg;
    } catch (e) {
      setState(() {
        unidadPolicialHija = null;
        idUnidadPolicialHija = 0;
      });

      return Container();
    }
  }

  _getUnidadesPoliciales() async {
    try {
      String latitud =
          _UserProvider.getUser.ubicacionSeleccionada.latitude.toString();
      String longitud =
          _UserProvider.getUser.ubicacionSeleccionada.longitude.toString();

      if (!cargaInicial) return;

      if (peticionServer) return;

      setState(() {
        peticionServer = true;
      });

      _listUnidadesPolicialesPadres = await _TiposEjesApi.getUnidadesPoliciales(
          context: context, usuario: _UserProvider.getUser.idGenUsuario);
      setState(() {
        peticionServer = false;
        cargaInicial = false;
      });
    } catch (e) {
      setState(() {
        peticionServer = false;
        cargaInicial = false;
      });
    }
  }

  _getUnidadesPolicialesHijasNivel1(int idUnidadPolicialPadre) async {
    try {
      String latitud =
          _UserProvider.getUser.ubicacionSeleccionada.latitude.toString();
      String longitud =
          _UserProvider.getUser.ubicacionSeleccionada.longitude.toString();

      if (peticionServer) return;

      setState(() {
        peticionServer = true;
      });

      print("consulto Hijos");

      _listUnidadesPolicialesHijas = await _TiposEjesApi.getTipoEjePorIdPadre(
          context: context,
          usuario: _UserProvider.getUser.idGenUsuario,
          idDgoTipoEje: idUnidadPolicialPadre.toString());

      idUnidadPolicialHija =
          int.parse(_listUnidadesPolicialesHijas[0].idDgoTipoEje);

      setState(() {
        peticionServer = false;
      });
    } catch (e) {
      setState(() {
        peticionServer = false;
        cargaInicial = false;
        idUnidadPolicialHija = 0;
      });
    }
  }

  Widget btnContinuar(ResponsiveUtil responsive) {
    return idUnidadPolicialHija > 0
        ? Container(
            width: responsive.anchoP(anchoContenedor),
            child: BotonesWidget(
                iconData: Icons.navigate_next,
                padding: EdgeInsets.symmetric(horizontal: 10),
                title: VariablesUtil.CONTINUAR,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VerificarGpsPage(
                                  pantalla: CrearCodigoUnidadPolicialPage(
                                idDgoTipoEje: idUnidadPolicialHija,
                              ))));
                }),
          )
        : Container();
  }
}
