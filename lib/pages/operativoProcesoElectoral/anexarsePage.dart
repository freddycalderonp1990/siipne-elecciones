part of '../pages.dart';

class AnexarsePage extends StatefulWidget {
  @override
  _AnexarsePageState createState() => _AnexarsePageState();
}

class _AnexarsePageState extends State<AnexarsePage> {
  UserProvider _UserProvider;
  RecintoAbiertoProvider _RecintoProvider;
  bool peticionServer = false;

  bool cargaInicial = true;
  List<DatosUnidadesId> _datosUnidadesId = new List();
  List<RecintosElectoral> _recintosElectorales = new List();
  String recintoElectoral;
  int idRecintoElectoral = 0;
  int ideje = 0;
  bool band = true;
  //CONFIGURACIONES
  final anchoContenedor = AppConfig.anchoContenedor;
  final anchoContenedorHijos = AppConfig.anchoContenedorHijos;
  final paddingContenido = 10.0;

  String idDgoCreaOpReci = "0";

  RecintosElectoralesApi _recintosElectoralesApi = new RecintosElectoralesApi();

  double sizeIcons;

  final _formKey = GlobalKey<FormState>();
  var controllerCodigoRecinto = new TextEditingController();

  DatosRecintoElectoralClass _datosRecintoElectoralClass =
      new DatosRecintoElectoralClass(nomRecintoElec: "");
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
      btnAtras: true,
      imgFondo: imgFondo,
      peticionServer: peticionServer,
      title: "ANEXARSE",
      contenido: [
        MyUbicacionWidget(
          callback: (_) {
            // _getAllUnidadesPoliciales();
          },
        ),
        SizedBox(
          height: responsive.altoP(separcion),
        ),
        wgConsultarRecinto(),
        SizedBox(
          height: responsive.altoP(separcion),
        ),
        wgDatosRecinto(),
        SizedBox(
          height: responsive.altoP(0.5),
        ),
        _datosRecintoElectoralClass.idDgoTipoEje == "1" || _datosRecintoElectoralClass.nomRecintoElec == "PROCESO VOTO EN CASA" || _datosRecintoElectoralClass.idDgoTipoEje == "34"
            ? getCombos1(responsive)
            : getCombos(),
        SizedBox(
          height: responsive.altoP(3),
        ),
        _datosRecintoElectoralClass.nomRecintoElec != ""
            ? btnRegistrarse(responsive)
            : Container(),
      ],
    );
  }

  Widget wgConsultarRecinto() {
    final responsive = ResponsiveUtil(context);
    final sizeTxt = responsive.anchoP(AppConfig.tamTexto + 2.0);
    peticionServer = false;
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
                key: _formKey,
                child: ImputTextWidget(
                  keyboardType: TextInputType.number,
                  controller: controllerCodigoRecinto,
                  icono: Icon(
                    Icons.assignment_sharp,
                    color: AppConfig.colorIcons,
                    size: sizeIcons,
                  ),
                  label: VariablesUtil.codigo,
                  fonSize: responsive.anchoP(AppConfig.tamTextoTitulo),
                  validar: validateCodigoRecinto,
                ),
              )),
              SizedBox(
                width: responsive.altoP(1),
              ),
              BtnIconWidget(
                onTap: () => _EventoBuscarRecintoElectoralPorCodigo(),
                iconData: Icons.search,
                colorTextoIcon: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget wgDatosRecinto() {
    final responsive = ResponsiveUtil(context);

    return _datosRecintoElectoralClass.nomRecintoElec != ""
        ? ContenedorDesingWidget(
            anchoPorce: anchoContenedor,
            child: ExpansionTile(
              initiallyExpanded: true,
              title: Text(
                'DATOS DEL OPERATIVO',
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
                          title: "Instalación",
                          detalle: _datosRecintoElectoralClass.nomRecintoElec,
                          mostrarBorder: true,
                        ),
                        TituloDetalleTextWidget(
                          title: "Encargado",
                          detalle: _datosRecintoElectoralClass.encargado,
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

  Widget btnRegistrarse(ResponsiveUtil responsive) {
    return idRecintoElectoral != 0 || idUnidadPolicialNieta != 0
        ? Container(
            width: responsive.anchoP(anchoContenedor),
            child: BotonesWidget(
              iconData: Icons.app_registration,
              padding: EdgeInsets.symmetric(horizontal: 10),
              title: VariablesUtil.REGISTRARSE,
              onPressed: () => {
                if (band)
                  {
                    _asignarPersonalEnRecintoElectoral(
                      idGenPersona: _UserProvider.getUser.idGenPersona,
                      usuario: _UserProvider.getUser.idGenUsuario,
                      idDgoCreaOpReci: idDgoCreaOpReci,
                      idTipoEje: ideje.toString(),
                    )
                  }
                else
                  {
                    DialogosAwesome.getInformation(
                        context: context,
                        descripcion: "Seleccione una Unidad Policial",
                        title: 'Información')
                  }
              },
            ),
          )
        : Container();
  }

  String validateCodigoRecinto(String value) {
    if (value.length == 0) {
      return VariablesUtil.codigoOperativoNoValido;
    }

    return null;
  }

  _EventoBuscarRecintoElectoralPorCodigo() async {
    if (peticionServer) return;
    final isValid = _formKey.currentState.validate();

    if (isValid) {
      _consultarDatosEncargadoRecintoPoridCreaRecinto(
          controllerCodigoRecinto.text);
    }
  }

  _consultarDatosEncargadoRecintoPoridCreaRecinto(idDgoCreaOpReci) async {
    try {
      if (peticionServer) return;
      setState(() {
        peticionServer = true;
      });
      _datosRecintoElectoralClass.documento = "";
      _datosRecintoElectoralClass.encargado = "";
      _datosRecintoElectoralClass.idDgoReciElect = "";
      _datosRecintoElectoralClass.idDgoTipoEje = "";
      _datosRecintoElectoralClass.nomRecintoElec = "";
      _datosRecintoElectoralClass.sexoPerson = "";
      _datosRecintoElectoralClass =
      new DatosRecintoElectoralClass(nomRecintoElec: "");
      _datosRecintoElectoralClass = await _recintosElectoralesApi.consultarDatosEncargadoRecintoPoridCreaRecinto(context: context, idDgoCreaOpReci: idDgoCreaOpReci);
      this.idDgoCreaOpReci = idDgoCreaOpReci;
      print("_datosRecintoElectoralClass.idDgoTipoEje-------" + _datosRecintoElectoralClass.idDgoTipoEje);
      if (_datosRecintoElectoralClass.idDgoTipoEje == "34") {
        band = false;
        _getUnidadesPoliciales();
        setState(() {
          peticionServer = false;
          return;
        });
      }
      if (_datosRecintoElectoralClass.nomRecintoElec == "PROCESO VOTO EN CASA") {
        band = false;
        _getUnidadesPoliciales();
        setState(() {
          peticionServer = false;
          return;
        });
      }
      if (_datosRecintoElectoralClass.idDgoTipoEje == "1") {
        band = false;
        _getUnidadesPoliciales();
        setState(() {
          peticionServer = false;
          return;
        });
      }
      if (int.parse(_datosRecintoElectoralClass.idDgoTipoEje) > 1) {
        band = true;
        _getAllUnidadesPolicialesid(_datosRecintoElectoralClass.idDgoTipoEje);
        setState(() {
          peticionServer = false;
          return;
        });
      }


    } catch (e) {
      _datosRecintoElectoralClass.documento = "";
      _datosRecintoElectoralClass.encargado = "";
      _datosRecintoElectoralClass.idDgoReciElect = "";
      _datosRecintoElectoralClass.idDgoTipoEje = "";
      _datosRecintoElectoralClass.nomRecintoElec = "";
      _datosRecintoElectoralClass.sexoPerson = "";
      print("un error ${e.toString()}");
      setState(() {
        peticionServer = false;
      });
    }
  }

  _asignarPersonalEnRecintoElectoral(
      {@required String idDgoCreaOpReci,
      @required String usuario,
      @required String idGenPersona,
      @required String idTipoEje}) async {
    try {
      if (peticionServer) return;
      setState(() {
        peticionServer = true;
      });

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
          idDgoReciElect: _datosRecintoElectoralClass.idDgoReciElect,
          idRecintoElectoral: idDgoCreaOpReci);
      print(_recintosElectoralesApi);
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

  Widget getCombos() {
    return _datosRecintoElectoralClass.nomRecintoElec != ""
        ? getComboInstalacionesUnidadesPoliciales()
        : Container();
  }

  List<String> getDatosInstalaciones(List<DatosUnidadesId> _datosUnidadesId) {
    List<String> datos = new List();
    print('getDatosInstalaciones');
    for (int i = 0; i < _datosUnidadesId.length; i++) {
      datos.add(_datosUnidadesId[i].ejePadre);
    }
    print('datos ${datos.length}');
    return datos;
  }

  int getIdInstalaciones(String eje) {
    ideje = 0;
    for (int i = 0; i < _datosUnidadesId.length; i++) {
      if (_datosUnidadesId[i].ejePadre == eje) {
        ideje = int.parse(_datosUnidadesId[i].idDgoTipoEje);
        print("idejeeeeeee=" + _datosUnidadesId[i].idDgoTipoEje);
        ConstApi.nombreUnidad = _datosUnidadesId[i].ejePadre;
        return ideje;
      }
    }
    return ideje;
  }

  Widget getComboInstalacionesUnidadesPoliciales() {
    List<String> datos = List();
    datos.clear();

      datos = getDatosInstalaciones(_datosUnidadesId);

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
                        selectValue: recintoElectoral,
                        title: VariablesUtil.UnidadPolicial,
                        searchHint:
                        'Seleccione la ' + VariablesUtil.UnidadPolicial,
                        datos: datos,
                        complete: (dato) {
                          setState(() {
                            recintoElectoral = dato;
                            idRecintoElectoral =
                                getIdInstalaciones(recintoElectoral);
                          });
                        },
                      ),
                    ],
                  ))));

  }

  _getAllUnidadesPolicialesid(String idDgoTipoEje) async {
    try {
      _listUnidadesPolicialesPadres.clear();
      _listUnidadesPolicialesHijas.clear();
      _listUnidadesPolicialesNietas.clear();
      //if (!cargaInicial) return;
      setState(() {
        peticionServer = true;
      });
      if(  _datosRecintoElectoralClass.idDgoTipoEje == "1" || _datosRecintoElectoralClass.nomRecintoElec == "PROCESO VOTO EN CASA"|| _datosRecintoElectoralClass.idDgoTipoEje == "34"){
        setState(() {
          peticionServer = false;

        });
      }else {
        _datosUnidadesId =
        await _recintosElectoralesApi.getAllUnidadesPolicialesId(
          context: context,
          idDgoTipoEje: idDgoTipoEje,
        );
      }
      print("_recintosElectorales ${_recintosElectorales.length}");
      setState(() {
        peticionServer = false;

      });
    } catch (e) {
      print("un error");
      print(e.toString());
      setState(() {
        peticionServer = false;

      });
    }
  }

  List<String> getDatosUnidadesPoliciales(
      List<UnidadesPoliciale> listUnidadesPoliciale) {
    List<String> datos = new List();
    datos.clear();
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
          ConstApi.nombreUnidad = lista[i].descripcion;
          return id;
        }
      }
      return id;
    } catch (e) {
      return 0;
    }
  }

  Widget getCombos1(ResponsiveUtil responsive) {
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

  Widget getComboNovedadesPadres(ResponsiveUtil responsive) {
    List<String> datos = List();
    datos.clear();
    datos = getDatosUnidadesPoliciales(_listUnidadesPolicialesPadres);
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

  _getUnidadesPoliciales() async {
    try {
      _listUnidadesPolicialesPadres.clear();
      _listUnidadesPolicialesHijas.clear();
      _listUnidadesPolicialesNietas.clear();

      if (peticionServer) return;
      setState(() {
        peticionServer = true;
      });
      _listUnidadesPolicialesPadres = await _TiposEjesApi.getUnidadesPoliciales(
          context: context, usuario: _UserProvider.getUser.idGenUsuario);
      setState(() {
        peticionServer = false;
      //  cargaInicial = false;
      });
    } catch (e) {
      setState(() {
        peticionServer = false;
        //cargaInicial = false;
      });
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

  _getUnidadesPolicialesHijasNivel1(int idUnidadPolicialPadre) async {
    try {
      _listUnidadesPolicialesHijas.clear();
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
      _listUnidadesPolicialesNietas.clear();
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
      band = true;

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
