part of '../pages.dart';

class AddPersonalPage extends StatefulWidget {
  @override
  _AddPersonalPageState createState() => _AddPersonalPageState();
}

class _AddPersonalPageState extends State<AddPersonalPage> {
  UserProvider _UserProvider;
  RecintoAbiertoProvider _RecintoProvider;

  bool peticionServer = false;
  bool cargaInicial = true;

  List<RecintosElectoral> _recintosUnidadesPoliciales = new List();
  String recintoUnidadesPoliciales;
  int idRecintoUnidadPolicial = 0;

  //CONFIGURACIONES
  final anchoContenedor = AppConfig.anchoContenedor;
  final anchoContenedorHijos = AppConfig.anchoContenedorHijos;
  final paddingContenido = 10.0;

  RecintosElectoralesApi _recintosElectoralesApi = new RecintosElectoralesApi();
  GenPersonaApi _genPersonaApi = new GenPersonaApi();

  double sizeIcons;

  String idGenPersona = "0";

  DatosPer _datosPers = new DatosPer(idGenPersona: "0");

  final _formKeyDocumento = GlobalKey<FormState>();
  var controllerDocumento = new TextEditingController();
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
    final responsive = ResponsiveUtil(context);
    sizeIcons =
        responsive.isVertical() ? responsive.altoP(3) : responsive.anchoP(5);
    _UserProvider = UserProvider.of(context);
    _RecintoProvider = RecintoAbiertoProvider.of(context);
    final separcion = 0.5;

    String imgFondo = AppConfig.imgFondoDefault;
    if (_RecintoProvider.getRecintoAbierto.isRecinto) {
      imgFondo = AppConfig.imgFondoElecciones;
    }

    return WorkAreaPageWidget(
      imgFondo: imgFondo,
      btnAtras: true,
      peticionServer: peticionServer,
      title: VariablesUtil.recElecAgregarpersonal,
      contenido: [
        _RecintoProvider.getRecintoAbierto.isJefe
            ? Container(
                width: responsive.anchoP(70),
                child: BtnIconWidget(
                  iconData: Icons.person,
                  title: "VER PERSONAL",
                  colorTextoIcon: Colors.white,

                  onTap: () {
                    Navigator.pushNamed(
                        context, AppConfig.pantallaRecElecPersonalDetalle);
                  },
                ),
              )
            : Container(),
        SizedBox(
          height: responsive.anchoP(1),
        ),
        MyUbicacionWidget(
          callback: (_) {
            _getAllUnidadesPoliciales();
          },
        ),
        SizedBox(
          height: responsive.altoP(separcion),
        ),
        wgConsultaIdGenPersonaPorDocumento(),
        SizedBox(
          height: responsive.altoP(separcion),
        ),
        wgDatosPersona(),
        SizedBox(
          height: responsive.altoP(0.5),
        ),
        getCombos1(responsive),
        SizedBox(
          height: responsive.altoP(3),
        ),
        btnAsignar(responsive),
      ],
    );
  }

  Widget wgConsultaIdGenPersonaPorDocumento() {
    final responsive = ResponsiveUtil(context);
    final sizeTxt = responsive.anchoP(AppConfig.tamTexto + 2.0);

    return ContenedorDesingWidget(
      anchoPorce: anchoContenedor,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),

        // handle your onTap here
        child: Container(
          margin: EdgeInsets.only(left: 0.0, right: 20.0),
          width: responsive.anchoP(55),
          height: responsive.anchoP(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: responsive.altoP(1),
              ),
              Expanded(
                  child: Form(
                key: _formKeyDocumento,
                child: ImputTextWidget(
                  keyboardType: TextInputType.number,
                  controller: controllerDocumento,
                  icono: Icon(
                    Icons.assignment_sharp,
                    color: AppConfig.colorIcons,
                    size: sizeIcons,
                  ),
                  label: VariablesUtil.cedula,
                  fonSize: responsive.anchoP(AppConfig.tamTextoTitulo),
                  validar: validateDocumento,
                ),
              )),
              SizedBox(
                width: responsive.altoP(1),
              ),
              BtnIconWidget(
                onTap: () => _EventoBuscaridGenPersonaPorDocumento(),
                iconData: Icons.search,
                colorTextoIcon: Colors.white,

              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget wgDatosPersona() {
    final responsive = ResponsiveUtil(context);

    return _datosPers.idGenPersona != "0"
        ? ContenedorDesingWidget(
            anchoPorce: anchoContenedor,
            child: ExpansionTile(
              initiallyExpanded: true,
              title: Text(
                'DATOS',
                style: TextStyle(
                  fontSize: responsive.anchoP(AppConfig.tamTextoTitulo),
                ),
              ),
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: responsive.altoP(1),
                        ),
                        TituloDetalleTextWidget(
                          title: "Nombres",
                          detalle: _datosPers.siglas.length > 0
                              ? _datosPers.siglas + "." + _datosPers.apenom
                              : _datosPers.apenom,
                          mostrarBorder: true,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        : Container();
  }

  Widget btnAsignar(ResponsiveUtil responsive) {
    return ideje != 0
        ? Container(
            width: responsive.anchoP(anchoContenedor),
            child: BotonesWidget(
              iconData: Icons.app_registration,
              padding: EdgeInsets.symmetric(horizontal: 10),
              title: VariablesUtil.AGREGAR,
              onPressed: () => {
                _asignarPersonalEnRecintoElectoral(
                  idGenPersona: _datosPers.idGenPersona,
                  usuario: _UserProvider.getUser.idGenUsuario,
                  idDgoCreaOpReci:
                      _RecintoProvider.getRecintoAbierto.idDgoCreaOpReci,
                )
              },
            ),
          )
        : Container();
  }

  String validateDocumento(String value) {
    if (value.length < 10) {
      return VariablesUtil.errorCedulaNoValida;
    } else if (_UserProvider.getUser.documento == controllerDocumento.text) {
      return VariablesUtil.ingreseCedulaDistinta;
    }

    return null;
  }

  _EventoBuscaridGenPersonaPorDocumento() async {
    if (peticionServer) return;
    final isValid = _formKeyDocumento.currentState.validate();

    if (isValid) {
      _consultarDatosPersonaPorDocumento(
          usuario: _UserProvider.getUser.idGenUsuario,
          cedula: controllerDocumento.text);
    }
  }

  _consultarDatosPersonaPorDocumento(
      {@required String cedula, @required String usuario}) async {
    try {
      if (peticionServer) return;

      setState(() {
        peticionServer = true;
      });

      _datosPers = await _genPersonaApi.getDatosPersona(
          context: context, usuario: usuario, cedula: cedula);
      if ((!_datosPers.poliRegistrado)) {
        DialogosAwesome.getInformation(
            context: context,
            descripcion: 'Persona no es Servidor Policial',
            title: 'Información');
        setState(() {
          _datosPers.apenom = "";
          _datosPers.documento = "";
          _datosPers.idGenPersona = "0";
          _datosPers.poliRegistrado = false;
          _datosPers.siglas = "";
          peticionServer = false;
        });
        return;
      }
      print("_datosPers.apenom");

      print(_datosPers.idGenPersona);

      setState(() {
        peticionServer = false;
      });
    } catch (e) {
      print("un error ${e.toString()}");
      setState(() {
        peticionServer = false;
      });
    }
  }

  _asignarPersonalEnRecintoElectoral(
      {@required String idDgoCreaOpReci,
      @required String usuario,
      @required String idGenPersona}) async {
    try {
      if (peticionServer) return;

      setState(() {
        peticionServer = true;
      });
      if ((!_datosPers.poliRegistrado)) {
        peticionServer = false;
        DialogosAwesome.getInformation(
            context: context,
            descripcion: 'Persona no es Servidor Policial',
            title: 'Información');
        setState(() {
          peticionServer = true;
        });
        return;
      }
      String latitud =
          _UserProvider.getUser.ubicacionSeleccionada.latitude.toString();
      String longitud =
          _UserProvider.getUser.ubicacionSeleccionada.longitude.toString();

      await _recintosElectoralesApi.asignarPersonalEnRecintoElectoral(
          context: context,
          idDgoCreaOpReci: idDgoCreaOpReci,
          usuario: usuario,
          idGenPersona: idGenPersona,
          latitud: latitud,
          longitud: longitud,
          idDgoTipoEje: ideje.toString(),
          idDgoReciElect: _RecintoProvider.getRecintoAbierto.idDgoReciElect,
          idRecintoElectoral: idRecintoUnidadPolicial.toString());

      setState(() {
        peticionServer = false;
      });
    } catch (e) {
      print("un error ${e.toString()}");
      setState(() {
        peticionServer = false;
      });
    }
  }

  Widget getCombos(ResponsiveUtil responsive) {
    return _datosPers.idGenPersona != "0"
        ? getComboInstalacionesUnidadesPoliciales()
        : Container();
  }

  List<String> getDatosInstalaciones(
      List<RecintosElectoral> _recintosUnidadesPoliciales) {
    List<String> datos = new List();

    print('getDatosInstalaciones');
    for (int i = 0; i < _recintosUnidadesPoliciales.length; i++) {
      //datos.add(_recintosElectorales[i].nomRecintoElec + "\n(Distancia " +_recintosElectorales[i].distance+"m)");
      datos.add(_recintosUnidadesPoliciales[i].nomRecintoElec);
    }
    print('datos ${datos.length}');
    return datos;
  }

  int getIdInstalaciones(String nomRecintoElec) {
    int id = 0;
    for (int i = 0; i < _recintosUnidadesPoliciales.length; i++) {
      if (_recintosUnidadesPoliciales[i].nomRecintoElec == nomRecintoElec) {
        id = int.parse(_recintosUnidadesPoliciales[i].idDgoReciElect);
        return id;
      }
    }
    return id;
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
                          idRecintoUnidadPolicial =
                              getIdInstalaciones(recintoUnidadesPoliciales);
                        });
                      },
                    ),
                  ],
                ))));
  }

  _getAllUnidadesPoliciales() async {
    try {
      if (!cargaInicial) return;

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
