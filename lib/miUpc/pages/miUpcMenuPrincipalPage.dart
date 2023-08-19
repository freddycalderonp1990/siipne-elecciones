part of 'miUpcPages.dart';

class MiUpcMenuPrincipalPage extends StatefulWidget {
  @override
  _MiUpcMenuPrincipalPageState createState() => _MiUpcMenuPrincipalPageState();
}

class _MiUpcMenuPrincipalPageState extends State<MiUpcMenuPrincipalPage> {
  List<Modulo> listaModulo = new List();
  List<String> modulosNoMostrar = new List();
  var imgMemory = null;
  List<Lnoti> listaD = new List();
  List<Lnoti> listaV = new List();
  List<Lnoti> listaM = new List();
  List<Lnoti> listaNt = new List();

  String general1 = "", general2 = "", imagen = "";
  String n1 = "", n2 = "", n3 = "", n4 = "", n5 = "", n6 = "", n7 = "", n8 = "";

  bool cargarDatos = true;
  bool peticionServer = false; //variable para que solo carge una vez los datos

  String nombre = '';
  String cedula = '';
  String direc = "";
  String fecha;
  String estadoConex = "";
  final prefs = new MiUpcPreferenciasUsuario();

  bool resgitrarToken = true;

  @override
  void initState() {
    // TODO: implement initState
//    initPlatformState();
    //  initPlatformImei();
    super.initState();
    modulosNoMostrar.add("ALERTA VEHÍCULOS ROBADOS");
    nombre = prefs.getnombresMiUpc();

    cargarListaInicial();
  }

  verificaTConexion() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        estadoConex = 'S';
        print('connected');
      }
    } on SocketException catch (_) {
      estadoConex = 'N';
      MiUpcDialogosWidget.alertasV(
          context: context,
          txt:
              "No Existe Conexión a Internet, asegurese de estar conectado a una red wifi o plan de datos");
      Navigator.of(context).pop();
    }
  }

  cargarListaInicial() async {
    cargarDatos = true;
    // final size = MediaQuery.of(context).size;
    await cargarModulos(context);
  }

  getAppBar() {
    return AppBar(
      title: Text('Mi UPC'),
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            color: MiUpcAppConfig.colorBarras,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
    );
  }

  getCabecera(ResponsiveUtil responsive) {
    fecha = 'Hoy es ' + UtilidadesUtil.getFechaActual();

    return Column(
      children: [
        Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  child: Image.asset(MiUpcAppConfig.imgCabecera_menu_principal),
                  width: responsive.altoP(30),
                ),
              ),
              Container(
                color: Colors.blue[900],
                child: Column(
                  children: <Widget>[
                    Divider(
                      color: Colors.transparent,
                      height: 5.0,
                    ),
                    Text(
                      'BIENVENID@ ' + nombre,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    Divider(
                      color: Colors.transparent,
                      height: 3.0,
                    ),
                    Container(
                      color: Colors.white,
                      child: Text(
                        fecha,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: MiUpcAppConfig.colorBarras,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.transparent,
                      height: 3.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil(context);
    verificaTConexion();

    return Scaffold(
      key: _key,
      drawer: MiUpcMyDrawerWidget(myKey: _key),
      appBar: getAppBar(),
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage(MiUpcAppConfig.imgFondo),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              getCabecera(responsive),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: listaModulo != null ? listaModulo.length : 0,
                    itemBuilder: (context, ind) {
                      imgMemory = PhotoHelper.convertStringToUint8List(
                          listaModulo[ind].imgBase64);
                      return InkWell(
                        onTap: () => muestraPantalla(ind, context),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    imgMemory != null
                                        ? Container(
                                            height: responsive.altoP(8),
                                            width: responsive.altoP(8),
                                            child: Image.memory(imgMemory),
                                          )
                                        : Container(
                                            height: responsive.altoP(8),
                                            width: responsive.altoP(8),
                                            child: Image.asset(
                                                MiUpcAppConfig.imgEscpolicia)),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "     " +
                                                listaModulo[ind]
                                                    .tituloModulo
                                                    .toUpperCase(),
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: MiUpcAppConfig.colorBarras,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: MiUpcAppConfig.colorBarras,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: MiUpcAppConfig.colorBarras,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          CargandoWidget(mostrar: peticionServer),
        ],
      )),
    );
  }

  _launchURLFace() async {
    const url = 'https://www.facebook.com/policia.ecuador';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLTwitter() async {
    const url = 'https://twitter.com/PoliciaEcuador';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLInsta() async {
    const url = 'https://www.instagram.com/policiaecuadoroficial';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLYou() async {
    const url = 'https://www.youtube.com/user/policiaecuador2';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget imgBanner(
      {GestureTapCallback onTap, String ruta, ResponsiveUtil responsive}) {
    double size =
        responsive.isVertical() ? responsive.altoP(8) : responsive.anchoP(8);
    return Container(
        height: size,
        width: size,
        child: InkWell(
          onTap: onTap,
          child: Container(
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                ruta,
              ),
            ),
          ),
        ));
  }

  Widget bannerInferior(ResponsiveUtil responsive) {
    return Container(
      color: Colors.blue,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          imgBanner(
              onTap: _launchURLFace,
              ruta: MiUpcAppConfig.imgFacebook,
              responsive: responsive),
          imgBanner(
              onTap: _launchURLTwitter,
              ruta: MiUpcAppConfig.imgTwitter,
              responsive: responsive),
          imgBanner(
              onTap: _launchURLInsta,
              ruta: MiUpcAppConfig.imgInstagran,
              responsive: responsive),
          imgBanner(
              onTap: _launchURLYou,
              ruta: MiUpcAppConfig.imgYoutube,
              responsive: responsive),
        ],
      ),
    );
  }

  Widget img(String ruta, ResponsiveUtil responsive) {
    return Image.asset(ruta,
        width: responsive.anchoP(20), height: responsive.anchoP(20));
  }

  cargarModulos(BuildContext context) async {
    if (cargarDatos) {
      if (peticionServer) {
        return;
      }
      setState(() {
        peticionServer = true;
      });
      print('cargarDatosLista');
      MiUpcModulosApi modulosApi = new MiUpcModulosApi();
      ModulosModel modulosModel;
      modulosModel = await modulosApi.consultarModulos(context);
      setState(() {
        listaModulo = modulosModel.modulos;

        for (int i = 0; i < listaModulo.length; i++) {
          for (int m = 0; m < modulosNoMostrar.length; m++) {
            print(listaModulo[i].tituloModulo);
            print(modulosNoMostrar[m]);

            if (listaModulo[i].tituloModulo.trim().toUpperCase() ==
                modulosNoMostrar[m].trim().toUpperCase()) {
              listaModulo.removeAt(i);
              print("remover");
            }
          }
        }

        cargarDatos = false;
        peticionServer = false;
      });
    }
  }

  Widget listaMenu(ResponsiveUtil responsive, orientation) {
    return Container(
      color: Colors.transparent,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: listaModulo != null ? listaModulo.length : 0,
        itemBuilder: (context, ind) {
          return InkWell(
            onTap: () => muestraPantalla(ind, context),
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        ImagenesWidget(
                          imgString: listaModulo[ind].imagenModulo,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "     " +
                                    listaModulo[ind].tituloModulo.toUpperCase(),
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: MiUpcAppConfig.colorBarras,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: MiUpcAppConfig.colorBarras,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: MiUpcAppConfig.colorBarras,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ingresaMapa() async {
    String _ip = await UtilidadesUtil.getIp();
    MiUpcAuditoriaApi auditoria = new MiUpcAuditoriaApi();
    auditoria.grabaAccion(MiUpcConstApi.latitud, MiUpcConstApi.longitud,
        'COUSULTAS', 'UPC CERCANOS', prefs.getidUsuarioMiUpc(), _ip, context);
    //Navigator.pop(context);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VerificarGpsPage(
                isElecciones: false, pantalla: MiUpcMapaUpcPage())));
  }

  registrOBotonSeguridad(BuildContext ctx) async {
    peticionServer = false;
    if (peticionServer) {
      return;
    }
    setState(() {
      peticionServer = true;
    });

    String _ip = await UtilidadesUtil.getIp();
    BotonSeguridadApi botonSeguridadApi = new BotonSeguridadApi();
    BotonSeguridadModel botonSeguridadModel;
    String datos = prefs.getimeiMiUpc() +
        "|" +
        prefs.getnombresMiUpc() +
        "|" +
        prefs.getcedulaMiUpc() +
        "|" +
        direc +
        "|" +
        _ip +
        "|" +
        prefs.getidUsuarioMiUpc() +
        "|" +
        prefs.getcelularMiUpc();

    botonSeguridadModel = await botonSeguridadApi.getBotonSeguridad(
        ctx, MiUpcConstApi.latitud, MiUpcConstApi.longitud, datos);
    setState(() {
      List<String> datosRegistro = botonSeguridadModel.boton;
      if (datosRegistro[0].toString() == "Correcto") {
        print(datosRegistro);
        peticionServer = false;
        MiUpcAuditoriaApi auditoria = new MiUpcAuditoriaApi();
        auditoria.grabaAccion(
            MiUpcConstApi.latitud,
            MiUpcConstApi.longitud,
            'REGISTRO',
            'ALERTA CIUDADANA',
            prefs.getidUsuarioMiUpc(),
            _ip,
            ctx);
        MiUpcDialogosWidget.alertasV(
            context: context,
            txt: datosRegistro[1],
            exitApp: false,
            llamar911: false);
      } else {
        MiUpcDialogosWidget.alertasV(
            context: context, txt: "Problemas de Conexión Intente Nuevamente");
        peticionServer = false;
      }
    });
  }

  static void llamarEcu(BuildContext ctx) async {
    final prefs = new MiUpcPreferenciasUsuario();
    String url = 'tel:911';
    if (await canLaunch(url)) {
      await launch(url);

      String _ip = await UtilidadesUtil.getIp();
      MiUpcAuditoriaApi auditoria = new MiUpcAuditoriaApi();
      auditoria.grabaAccion(
          MiUpcConstApi.latitud,
          MiUpcConstApi.longitud,
          'LLAMADA',
          'ECU-911-BOTON DE EMERGENCIA',
          prefs.getidUsuarioMiUpc(),
          _ip,
          ctx);
    } else {
      throw 'Could not launch $url';
    }
  }

  muestraPantalla(index, BuildContext ctx) async {
    switch (index) {
      case 0:
        ingresaMapa();
        break; // The switch statement must be told to exit, or it will execute every case.
      case 1:
        MiUpcDialogosWidget.alertaComunitaria(
            context: ctx,
            onPressed: () {
              Navigator.of(context).pop();
              registrOBotonSeguridad(ctx);
            });
        break;
      case 2:
        if (index == 2) {
          llamarEcu(ctx);
        }
        break;

      case 3:
        String _ip = await UtilidadesUtil.getIp();
        MiUpcAuditoriaApi auditoria = new MiUpcAuditoriaApi();
        auditoria.grabaAccion(
            MiUpcConstApi.latitud,
            MiUpcConstApi.longitud,
            'COUSULTA',
            'OPCIONES VIOLENCIA DE GÉNERO',
            prefs.getidUsuarioMiUpc(),
            _ip,
            context);
        Navigator.pushNamed(context, MiUpcAppConfig.listaViolenciaPage);
        break;

      /* case 4:
        String _ip = await UtilidadesUtil.getIp();
        MiUpcAuditoriaApi auditoria = new MiUpcAuditoriaApi();
        auditoria.grabaAccion(MiUpcConstApi.latitud, MiUpcConstApi.longitud, 'COUSULTA',
            'OPCIONES COVID', prefs.getidUsuarioMiUpc(), _ip, context);
        MiUpcDialogosWidget.alertOpcionesCovid(context: ctx);
        break;*/

      case 4:
        String _ip = await UtilidadesUtil.getIp();
        MiUpcAuditoriaApi auditoria = new MiUpcAuditoriaApi();
        auditoria.grabaAccion(
            MiUpcConstApi.latitud,
            MiUpcConstApi.longitud,
            'COUSULTA',
            'LISTA SERVICIOS POLCO',
            prefs.getidUsuarioMiUpc(),
            _ip,
            context);
        Navigator.pushNamed(context, MiUpcAppConfig.listaServiciosPolcoPage);
        break;

      case 5:
        String _ip = await UtilidadesUtil.getIp();
        MiUpcAuditoriaApi auditoria = new MiUpcAuditoriaApi();
        auditoria.grabaAccion(
            MiUpcConstApi.latitud,
            MiUpcConstApi.longitud,
            'COUSULTA',
            'MEDIDAS DE AUTOPROTECCIÓN',
            prefs.getidUsuarioMiUpc(),
            _ip,
            context);
        Navigator.pushNamed(
            context, MiUpcAppConfig.listaMedidasAutoproteccionPage);
        break;

      case 6:
        String _ip = await UtilidadesUtil.getIp();
        MiUpcAuditoriaApi auditoria = new MiUpcAuditoriaApi();
        auditoria.grabaAccion(MiUpcConstApi.latitud, MiUpcConstApi.longitud,
            'ACCESO', 'NOTICIAS', prefs.getidUsuarioMiUpc(), _ip, context);
        Navigator.pushNamed(context, MiUpcAppConfig.ListaNoticiasPage,
            arguments: '8888888888888888888881');
        break;

      default:
        print('choose a different number!');
    }
  }

  pasarPantalla() {
    Navigator.of(context).pop();
    Navigator.pushNamed(context, MiUpcAppConfig.LoginPage);
  }
}
