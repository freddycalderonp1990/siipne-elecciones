part of '../../pages.dart';

class CrearCodigoOtrosPage extends StatefulWidget {
  final int idDgoTipoEje;

  const CrearCodigoOtrosPage({Key key, this.idDgoTipoEje}) : super(key: key);
  @override
  _CrearCodigoOtrosPageState createState() => _CrearCodigoOtrosPageState();
}

class _CrearCodigoOtrosPageState extends State<CrearCodigoOtrosPage> {
  UserProvider _UserProvider;
  ProcesoOperativoProvider _ProcesoOperativoProvider;

  double sizeIcons;
  var controllerTelefono = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool peticionServer = false;
  bool cargarRecintosElectorales = false, cargaInicial = true;

  List<RecintosElectoral> _recintosUnidadesPoliciales = new List();
  String recintoUnidadesPoliciales;
  int idRecintoUnidadPolicial = 0;

  //CONFIGURACIONES
  final anchoContenedor = AppConfig.anchoContenedor;
  final anchoContenedorHijos = AppConfig.anchoContenedorHijos;
  final paddingContenido = 10.0;

  List<RecintosElectoral> _recintosInstalaciones = new List();
  AbrirRecintoElectoral _abrirRecintoElectoral = new AbrirRecintoElectoral();

  String recintoInstalaciones;
  int idRecintoInstalaciones = 0;
  String textoDistancia;

  RecintosElectoralesApi _recintosElectoralesApi = new RecintosElectoralesApi();
  bool selectPadre = true;
  bool selectHija = true;
  TiposEjesApi _TiposEjesApi = new TiposEjesApi();
  List<UnidadesPoliciale> _listUnidadesPolicialesPadres = new List();
  List<UnidadesPoliciale> _listUnidadesPolicialesHijas = new List();
  List<UnidadesPoliciale> _listUnidadesPolicialesNietas = new List();
  String unidadPolicialPadre, unidadPolicialHija, unidadPolicialNieta;
  int idUnidadPolicialPadre = 0,
      idUnidadPolicialHija = 0,
      idUnidadPolicialNieta = 0;
  int ideje = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    UtilidadesUtil.getTheme();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //Variable para obtener el tamaño de la pantalla

    final responsive = ResponsiveUtil(context);

    _UserProvider = UserProvider.of(context);
    _ProcesoOperativoProvider = ProcesoOperativoProvider.of(context);

    sizeIcons =
        responsive.isVertical() ? responsive.altoP(3) : responsive.anchoP(5);

    return WorkAreaPageWidget(
      btnAtras: true,
      peticionServer: _recintosInstalaciones.length > 0 ? peticionServer : true,
      title: "GENERAR CÓDIGO",
      contenido: [
        MyUbicacionWidget(
          callback: (_) {
            getRecintosElectoralesInstalaciones();

          },
        ),
        SizedBox(
          height: responsive.altoP(1),
        ),
        getComboInstalaciones(),
        SizedBox(
          height: responsive.altoP(0.5),
        ),
        _recintosInstalaciones.length > 0
            ? getCombos1(responsive)
            : Container(),
        SizedBox(
          height: responsive.altoP(1),
        ),
        ideje > 0? btnAbrir(responsive) : Container(),
      ],
    );
  }

  Widget getComboInstalaciones() {
    List<String> datos = getDatosInstalaciones(_recintosInstalaciones);

    return ContenedorDesingWidget(
        anchoPorce: anchoContenedor,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: paddingContenido),
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: paddingContenido),
                child: ComboConBusqueda(
                  selectValue: recintoInstalaciones,
                  title: VariablesUtil.Instalacion,
                  searchHint: 'Seleccione la ' + VariablesUtil.Instalacion,
                  datos: datos,
                  complete: (dato) {
                    if (dato == null) {
                      recintoUnidadesPoliciales = null;
                      idRecintoUnidadPolicial = 0;
                    }
                    setState(() {
                      recintoInstalaciones = dato;
                      idRecintoInstalaciones = getIdInstalaciones(
                          recintoInstalaciones, _recintosInstalaciones);
                    });
                  },
                ))));
  }

  Widget btnAbrir(ResponsiveUtil responsive) {
    return Container(
        width: responsive.anchoP(anchoContenedor),
        child: Column(
          children: [
            ContenedorDesingWidget(
                margin: EdgeInsets.symmetric(vertical: 10),
                anchoPorce: anchoContenedor,
                child: Column(
                  children: [
                    wgTxtTelefono(responsive),
                    SizedBox(
                      height: responsive.altoP(1.5),
                    )
                  ],
                )),
            SizedBox(
              height: responsive.altoP(1.5),
            ),
            BotonesWidget(
                iconData: Icons.open_in_browser_outlined,
                padding: EdgeInsets.symmetric(horizontal: 10),
                title: VariablesUtil.ABRIR,
                onPressed: () {
                  DialogosWidget.alertSiNo(context,
                      title: "Abrir Operativo",
                      message:
                          "Usted es la persona encargada o jefe designada a este Operativo"
                          "\n \nRecuerde crear el código si se encuentra de servicio en el operativo, para prevenir el mal uso todo será registrado."
                          "\n \nUtilice la aplicación con responsabilidad.",
                      onTap: () {
                    Navigator.of(context).pop();
                    _AbrirRecintoElectoral(_UserProvider.getUser.idGenUsuario,
                        idRecintoInstalaciones.toString());
                  });
                }),
          ],
        ));
  }

  Widget wgTxtTelefono(responsive) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ImputTextWidget(
            keyboardType: TextInputType.number,
            controller: controllerTelefono,
            icono: Icon(
              Icons.phone_android,
              color: Colors.black38,
              size: sizeIcons,
            ),
            label: "Teléfono",
            fonSize: responsive.anchoP(AppConfig.tamTextoTitulo),
            validar: validateTelefono,
          )
        ],
      ),
    );
  }

  String validateTelefono(String value) {
    if (value.length < 8) {
      return "Ingrese el número de Teléfono";
    }

    return null;
  }

  List<String> getDatosInstalaciones(
      List<RecintosElectoral> _recintosElectorales) {
    List<String> datos = new List();
    for (int i = 0; i < _recintosElectorales.length; i++) {
      //datos.add(_recintosElectorales[i].nomRecintoElec + "\n(Distancia " +_recintosElectorales[i].distance+"m)");
      datos.add(_recintosElectorales[i].nomRecintoElec);
    }
    return datos;
  }

  int getIdInstalaciones(
      String nomRecintoElec, List<RecintosElectoral> _recintosElectorales) {
    int id = 0;
    for (int i = 0; i < _recintosElectorales.length; i++) {
      if (_recintosElectorales[i].nomRecintoElec == nomRecintoElec) {
        id = int.parse(_recintosElectorales[i].idDgoReciElect);
        return id;
      }
    }
    return id;
  }

  getRecintosElectoralesInstalaciones() async {
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

      String idDgoProcElec =
          _ProcesoOperativoProvider.getProcesosOperativo.idDgoProcElec;
      //le asigno 1 porque es el id que le corresponde a recintos electorales
      //para solo mostrar los recintos electorales
      String idDgoTipoEje = widget.idDgoTipoEje.toString();

      _recintosInstalaciones =
          await _recintosElectoralesApi.getRecintosElectoralesCercanos(
              title: VariablesUtil.Instalacion,
              msj1: "No existen Instalaciones Cercanas",
              context: context,
              latitud: latitud,
              longitud: longitud,
              idDgoProcElec: idDgoProcElec,
              idDgoTipoEje: idDgoTipoEje);

      await _getAllUnidadesPoliciales();

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

  _AbrirRecintoElectoral(String usuario, String idRecintoElectoral) async {
    try {
      bool isValid = _formKey.currentState.validate();
      if (!isValid) return;
      if (peticionServer) return;

      setState(() {
        peticionServer = true;
      });

      String latitud =
          _UserProvider.getUser.ubicacionSeleccionada.latitude.toString();
      String longitud =
          _UserProvider.getUser.ubicacionSeleccionada.longitude.toString();

      String idDgoProcElec =
          _ProcesoOperativoProvider.getProcesosOperativo.idDgoProcElec;

      _abrirRecintoElectoral =
          await _recintosElectoralesApi.abrirRecintoElectoral(
              context: context,
              idDgoReciElect: idRecintoElectoral,
              idGenPersona: _UserProvider.getUser.idGenPersona,
              usuario: usuario,
              latitud: latitud,
              longitud: longitud,
              idDgoProcElec: idDgoProcElec,
              idDgoReciUnidadPolicial: idRecintoElectoral,
              idDgoTipoEje:ideje.toString(),
              telefono: controllerTelefono.text);

      if (_abrirRecintoElectoral.estado == "A") {
        DialogosWidget.alert(context,
            title: VariablesUtil.INFORMACION,
            message: _abrirRecintoElectoral.apenom +
                "\nYa existe un Código asignado ${_abrirRecintoElectoral.idDgoCreaOpReci}\n\n" +
                recintoInstalaciones +
                "\nFECHA INICIO: " +
                _abrirRecintoElectoral.fechaIni +
                "\n\nSi usted necesita abrir el encargado [${_abrirRecintoElectoral.apenom}] debe eliminar o finalizar el Operativo.");
      } else {
        DialogosWidget.alert(context,
            title: "CÓDIGO",
            message: "El Código para que el personal se anexe  es: " +
                _abrirRecintoElectoral.idDgoCreaOpReci, onTap: () {
          UtilidadesUtil.pantallasAbrirNuevaCerrarTodas(
              context: context,
              pantalla: AppConfig.pantallaVerificarOperativoRecintoAbierto);

          /* Navigator.pushReplacementNamed(
              context, AppConfig.pantallaMenuRecintoElectoral);*/
        });
      }

      setState(() {
        peticionServer = false;
        cargaInicial = false;
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        cargaInicial = false;
        peticionServer = false;
      });
    }
  }

  Widget getCombos(ResponsiveUtil responsive) {
    return recintoInstalaciones != null
        ? getComboInstalacionesUnidadesPoliciales()
        : Container();
  }

  Widget getComboInstalacionesUnidadesPoliciales() {
    List<String> datos = getDatosInstalaciones(_recintosUnidadesPoliciales);

    return ContenedorDesingWidget(
        anchoPorce: anchoContenedor,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: paddingContenido),
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: paddingContenido),
                child: Column(
                  children: [
                    TituloTextWidget(
                      title:
                          "Seleccione la Unidad a la que pertenece el Servidor Policial ",
                      textAlign: TextAlign.center,
                    ),
                    ComboConBusqueda(
                      selectValue: recintoUnidadesPoliciales,
                      title: VariablesUtil.UnidadPolicial,
                      searchHint:
                          'Seleccione la ' + VariablesUtil.UnidadPolicial,
                      datos: datos,
                      complete: (dato) {
                        setState(() {
                          recintoUnidadesPoliciales = dato;
                          idRecintoUnidadPolicial = getIdInstalaciones(
                              recintoUnidadesPoliciales,
                              _recintosUnidadesPoliciales);
                        });
                      },
                    ),
                  ],
                ))));
  }

  _getAllUnidadesPoliciales() async {
    try {
      setState(() {
        peticionServer = true;
      });

      _recintosUnidadesPoliciales =
          await _recintosElectoralesApi.getAllUnidadesPoliciales(
        context: context,
        usuario: _UserProvider.getUser.idGenUsuario,
      );

      print("_recintosElectorales ${_recintosUnidadesPoliciales.length}");

      setState(() {
        peticionServer = false;
        cargaInicial = false;
      });
    } catch (e) {
      print("un error");
      print(e.toString());
      setState(() {
        peticionServer = false;
        cargaInicial = false;
      });
    }
  }

  Widget getCombos1(ResponsiveUtil responsive) {
    _getUnidadesPoliciales();
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
              unidadPolicialHija != null
                  ? getComboNovedadesNietas(responsive)
                  : Container(),
            ],
          ),
        ));
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

  Widget getComboNovedadesHijos(ResponsiveUtil responsive) {
    List<String> datos =
        getDatosUnidadesPoliciales(_listUnidadesPolicialesHijas);
    return _listUnidadesPolicialesHijas.length > 0
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: paddingContenido),
            child: ComboConBusqueda(
              selectValue: unidadPolicialHija,
              title: 'Dirección',
              searchHint: 'Seleccione la ' + VariablesUtil.UnidadPolicial,
              datos: datos,
              complete: (dato) {
                selectHija = true;
                setState(() async {
                  unidadPolicialHija = dato;
                  unidadPolicialNieta = null;
                  idUnidadPolicialNieta = 0;
                  _listUnidadesPolicialesNietas = [];
                  if (unidadPolicialHija != null) {
                    if (_listUnidadesPolicialesNietas.length > 0) {
                      unidadPolicialHija =
                          _listUnidadesPolicialesNietas[0].descripcion;
                      idUnidadPolicialHija = 0;
                      idUnidadPolicialHija = int.parse(
                          _listUnidadesPolicialesNietas[0].idDgoTipoEje);
                    }
                    int idNovedadHija = getIdUnidadPolicial(
                        unidadPolicialHija, _listUnidadesPolicialesHijas);
                    await _getUnidadesPolicialesHijasNivel2(idNovedadHija);
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

  _getUnidadesPoliciales() async {
    try {
      peticionServer = false;
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

  Widget getComboNovedadesNietas(ResponsiveUtil responsive) {
    List<String> datos =
        getDatosUnidadesPoliciales(_listUnidadesPolicialesNietas);
    if (datos.length == 0) {
      return Container();
    }
    if (selectHija) {
      unidadPolicialNieta = datos[0];
    }
    try {
      Widget wg = _listUnidadesPolicialesNietas.length > 0
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: paddingContenido),
              child: ComboConBusqueda(
                selectValue: unidadPolicialNieta,
                title: "Unidad Polcial",
                searchHint: 'Seleccione la ' + VariablesUtil.UnidadPolicial,
                datos: datos,
                complete: (dato) {
                  selectHija = false;
                  print(unidadPolicialNieta);
                  print(dato);
                  setState(() {
                    unidadPolicialNieta = dato;
                    idUnidadPolicialNieta = 0;
                    if (unidadPolicialNieta != null) {
                      idUnidadPolicialNieta = getIdUnidadPolicial(
                          unidadPolicialNieta, _listUnidadesPolicialesNietas);
                      ideje = getIdUnidadPolicial(
                          unidadPolicialNieta, _listUnidadesPolicialesNietas);
                    }
                  });
                },
              ))
          : Container(
              child: DetalleTextWidget(
                detalle: "No exiten Unidades Policiales 2",
              ),
            );

      return wg;
    } catch (e) {
      setState(() {
        unidadPolicialNieta = null;
        idUnidadPolicialNieta = 0;
      });

      return Container();
    }
  }

  _getUnidadesPolicialesHijasNivel2(int idUnidadPolicialHija) async {
    try {
      if (peticionServer) return;
      setState(() {
        peticionServer = true;
      });

      print("consulto Nietos");

      _listUnidadesPolicialesNietas = await _TiposEjesApi.getTipoEjePorIdPadre(
          context: context,
          usuario: _UserProvider.getUser.idGenUsuario,
          idDgoTipoEje: idUnidadPolicialHija.toString());

      idUnidadPolicialHija =
          int.parse(_listUnidadesPolicialesNietas[0].idDgoTipoEje);

      setState(() {
        peticionServer = false;
      });
    } catch (e) {
      setState(() {
        peticionServer = false;
        cargaInicial = false;
        idUnidadPolicialNieta = 0;
      });
    }
  }
}
