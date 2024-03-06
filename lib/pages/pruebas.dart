
part of 'pages.dart';

//===================================================

// This class uses awesome dialog Package
// Link to it :  https://pub.dev/packages/awesome_dialog

//===================================================

class AwesomeDialogScreen extends StatefulWidget {
  static const routeName = '/AwesomeDialogScreen';
  @override
  _AwesomeDialogScreenState createState() => _AwesomeDialogScreenState();
}

class _AwesomeDialogScreenState extends State<AwesomeDialogScreen> {



  var peticionServer = false;
  UserProvider _UserProvider;
  ProcesoOperativoProvider _ProcesoOperativoProvider;
  bool cargaInicial = true;

  ProcesosOperativosApi _ProcesosOperativosApi=new ProcesosOperativosApi();
  List<ProcesosOperativo> _listProcesosOperativo= new List();
  String procesoOperativo;
  int idProcesoOperativo=0;

  //CONFIGURACIONES
  final anchoContenedor = AppConfig.anchoContenedor;
  final anchoContenedorHijos = AppConfig.anchoContenedorHijos;
  final paddingContenido = 10.0;



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
    _UserProvider = UserProvider.of(context);
    _ProcesoOperativoProvider=ProcesoOperativoProvider.of(context);

    String Bienvenido = _UserProvider.getUser.sexo == 'HOMBRE'
        ? VariablesUtil.Bienvenido
        : VariablesUtil.Bienvenida;


    return WorkAreaPageWidget(
      mostrarVersion: false,
      btnAtras: true,

      imgFondo: AppConfig.imgFondoLogin,
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
              cabecera(context),
              SizedBox(
                height: responsive.altoP(1),
              ),
              getComboProcesosRecintos(),
              SizedBox(
                height: responsive.altoP(1),
              ),
              btnContinuar(responsive),

              SizedBox(
                height: responsive.altoP(4),
              ),
              Container(
                width: responsive.anchoP(30),
                child: BtnIconWidget(
                  iconData: Icons.exit_to_app,
                  title: VariablesUtil.Salir,
                  colorTextoIcon: Colors.white,
                  color: Colors.blue,
                  onTap: () => _cerrarSession(),
                ),
              ),
            ],
          ),
        ),
      ],);
  }


  _cerrarSession() {
    //Aquí (Route <dynamic> route) => false se asegurará de que se eliminen todas las rutas antes de hacer push de la ruta .
    Navigator.of(context).pushNamedAndRemoveUntil(AppConfig.pantallaLogin, (Route<dynamic> route) => false);

    //Navigator.pushReplacementNamed(context, AppConfig.pantallaLogin);
  }
  Widget cabecera(BuildContext context) {
    final responsive = ResponsiveUtil(context);

    return ContenedorDesingWidget(
        anchoPorce: anchoContenedor,
        child: BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
            builder: (context, state) => getUbicacion(responsive, state)));
  }

  Widget getUbicacion(ResponsiveUtil responsive, MiUbicacionState state) {
    if (!state.existeUbicacion)
      return Center(child: Text('Obteniendo Ubicando...'));


    _UserProvider.getUser.ubicacionSeleccionada = state.ubicacion;


    String latitud =
    _UserProvider.getUser.ubicacionSeleccionada.latitude.toString();
    String longitud =
    _UserProvider.getUser.ubicacionSeleccionada.longitude.toString();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getProcesosOperativos();
    });

    return Container();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          Container(
            width: responsive.anchoP(anchoContenedor),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Icon(
                    Icons.location_on_outlined,
                    color: Colors.red,
                    size: responsive.isVertical()
                        ? responsive.altoP(2)
                        : responsive.anchoP(5),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 5),
                  child: Text(
                    VariablesUtil.Ubicacion,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: responsive.anchoP(AppConfig.tamTextoTitulo)),
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: responsive.anchoP(15.5),
                            child: Text(
                              "Latitud: ",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                  responsive.anchoP(AppConfig.tamTexto)),
                            ),
                          ),
                          Text(
                            latitud,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                responsive.anchoP(AppConfig.tamTexto)),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: responsive.anchoP(15.5),
                            child: Text(
                              "Longitud: ",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                  responsive.anchoP(AppConfig.tamTexto)),
                            ),
                          ),
                          Text(
                            longitud,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                responsive.anchoP(AppConfig.tamTexto)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: responsive.anchoP(1),
                ),
              ],
            ),
          ),
          SizedBox(
            height: responsive.altoP(0.4),
          )
        ],
      ),
    );
  }

  List<String> getDatosProcesosOperativos( List<ProcesosOperativo> listProcesosOperativos) {
    List<String> datos = new List();
    for (int i = 0; i < listProcesosOperativos.length; i++) {
      //datos.add(_recintosElectorales[i].nomRecintoElec + "\n(Distancia " +_recintosElectorales[i].distance+"m)");
      datos.add(listProcesosOperativos[i].descProcElecc);
    }
    return datos;
  }

  int getIdProcesosOperativos(String descProcElecc) {
    int id = 0;
    for (int i = 0; i < _listProcesosOperativo.length; i++) {
      if (_listProcesosOperativo[i].descProcElecc == descProcElecc) {
        id = int.parse(_listProcesosOperativo[i].idDgoProcElec);

        _ProcesoOperativoProvider.setProcesoOperativo(_listProcesosOperativo[i]);
        return id;
      }
    }
    return id;
  }

  Widget getComboProcesosRecintos() {
    List<String> datos = getDatosProcesosOperativos(_listProcesosOperativo);

    return ContenedorDesingWidget(
        anchoPorce: anchoContenedor,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: paddingContenido),
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: paddingContenido),
                child: ComboConBusqueda(
                  title: VariablesUtil.UnidadesPoliciales,
                  searchHint: 'Seleccione el ' + VariablesUtil.UnidadesPoliciales,
                  datos: datos,
                  complete: (dato) {
                    setState(() {
                      procesoOperativo = dato;
                      idProcesoOperativo =
                          getIdProcesosOperativos(procesoOperativo);
                    });
                  },
                ))));
  }

  _getProcesosOperativos() async {
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

      _listProcesosOperativo =
      await _ProcesosOperativosApi.getProcesosOperativos(
          context: context, latitud: latitud, longitud: longitud);



      setState(() {
        peticionServer = false;
        cargaInicial = false;
      });
    } catch (e) {
      setState(() {
        peticionServer = false;
      });
    }
  }


  Widget btnContinuar(ResponsiveUtil responsive) {
    return idProcesoOperativo>0? Container(
      width: responsive.anchoP(anchoContenedor),
      child: BotonesWidget(
          iconData: Icons.navigate_next,
          padding: EdgeInsets.symmetric(horizontal: 10),
          title: VariablesUtil.CONTINUAR,
          onPressed: () {
            DialogosWidget.alertSiNo(context,
                title: "OPERATIVO",
                message:
                "Usted ha seleccionado el operativo \n\n ${procesoOperativo}. \n\n¿Desea Continuar?",
                onTap: () {
                  Navigator.of(context).pop();

                  UtilidadesUtil.pantallasAbrirNuevaCerrarTodas(
                      context: context, pantalla: AppConfig.pantallaMenuCrearCodigo);

                });
          }),
    ):Container();
  }
}
