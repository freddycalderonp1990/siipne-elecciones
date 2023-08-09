part of 'pages.dart';

class NovedadesDetallePage extends StatefulWidget {
  @override
  _NovedadesDetallePageState createState() =>
      _NovedadesDetallePageState();
}

class _NovedadesDetallePageState extends State<NovedadesDetallePage> {
  UserProvider _UserProvider;
  RecintoAbiertoProvider _RecintoProvider;
  bool peticionServer = false;
  bool cargaInicial = true;
  double sizeIcons;

  String encargado;

  RecintosElectoralesApi _recintosElectoralesApi = new RecintosElectoralesApi();
  NovedadesElectoralesApi _novedadesElectoralesApi =new NovedadesElectoralesApi();

  List<PersonalRecintoElectoral> _ListPersonalRecintoElectoral = new List();
  List<PersonalRecintoElectoral> _ListPersonalActivo = new List();
  List<PersonalRecintoElectoral> _ListPersonalInactivo = new List();

  List<NovedadesElectoralesDetalle> _ListNovedadesRecinto= new List();

  //CONFIGURACIONES
  final anchoContenedor = AppConfig.anchoContenedor;
  final anchoContenedorHijos = AppConfig.anchoContenedorHijos;
  final paddingContenido = 10.0;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil(context);
    sizeIcons =
        responsive.isVertical() ? responsive.altoP(3) : responsive.anchoP(5);
    _UserProvider = UserProvider.of(context);
    _RecintoProvider = RecintoAbiertoProvider.of(context);
    final separcion = 0.5;

    _ConusltarPersonalAsignado();
    String imgFondo=AppConfig.imgFondoDefault;
    if(_RecintoProvider.getRecintoAbierto.isRecinto){
      imgFondo=AppConfig.imgFondoElecciones;
    }


    return WorkAreaPageWidget(

      imgFondo: imgFondo,
      btnAtras: true,
      peticionServer: peticionServer,
      title: "REPORTE DE NOVEDADES",
      contenido: [
        _ListPersonalRecintoElectoral.length > 0
            ? getContenido(responsive)
            : Container(),
      ],
    );
  }

  getDatos() {
    for (int i = 0; i < _ListPersonalRecintoElectoral.length; i++) {
      PersonalRecintoElectoral personal = _ListPersonalRecintoElectoral[i];

      if (personal.cargo == "J") {
        encargado = personal.personal;
      } else {
        if (personal.estadoPersonal == "ACTIVO") {
          _ListPersonalActivo.add(personal);
        } else {
          _ListPersonalInactivo.add(personal);
        }
      }
    }
  }

  Widget getContenido(ResponsiveUtil responsive) {
    return ContenedorDesingWidget(
        anchoPorce: anchoContenedor,
        child: Column(
          children: [
            TituloTextWidget(
              textAlign: TextAlign.center,
              title: _RecintoProvider.getRecintoAbierto.nomRecintoElec,
            ),
            _wgJefe(responsive),
            _wgNovedades(responsive),
            _PersonalNoActivo(responsive)
          ],
        ));
  }

  Widget _wgJefe(ResponsiveUtil responsive) {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(
        "Datos Encargado",
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
                  title: "Encargado",
                  detalle: encargado,
                  mostrarBorder: true,
                ),
                TituloDetalleTextWidget(
                  title: "Fecha Inicio",
                  detalle: _ListPersonalRecintoElectoral[0].fechaIni,
                  mostrarBorder: true,
                ),

                TituloDetalleTextWidget(
                  title: "Total Novedades",
                  detalle: (_ListNovedadesRecinto.length).toString(),
                  mostrarBorder: true,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _wgNovedades(ResponsiveUtil responsive) {
    return _ListNovedadesRecinto.length > 0
        ? ExpansionTile(
            initiallyExpanded: true,
            title: Text(
              "Novedades " + _ListNovedadesRecinto.length.toString(),
              style: TextStyle(
                fontSize: responsive.anchoP(AppConfig.tamTextoTitulo),
              ),
            ),
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                    height: responsive.altoP(30),
                    width: responsive.anchoP(anchoContenedor) -
                        anchoContenedorHijos,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _ListNovedadesRecinto.length,
                        itemBuilder: (context, index) {
                          NovedadesElectoralesDetalle novedades = _ListNovedadesRecinto[index];

                          return Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                        color: AppConfig.colorBordecajas,
                                        blurRadius: 1)
                                  ]),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: SingleChildScrollView(
                                scrollDirection:Axis.horizontal ,

                                child: Row(children: [
                                SizedBox(width: responsive.altoP(1),),
                                Text(
                                  (index + 1).toString()+".",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: responsive.anchoP(4),
                                      fontWeight: FontWeight.bold),
                                ),

                                SizedBox(width: responsive.altoP(1),),
                                Column(
                                  children: [
                                    TituloDetalleTextWidget(
                                      title: "Fecha:",
                                      detalle: novedades.fechaNovedad,
                                      mostrarBorder: false,
                                      mostrarLinea: true,
                                    ),
                                    TituloDetalleTextWidget(
                                      title: "Reporta:",
                                      detalle: novedades.reporta,
                                      mostrarBorder: false,
                                      mostrarLinea: true,
                                    ),
                                    TituloDetalleTextWidget(
                                      title: "Tipo:",
                                      detalle: novedades.tipo,
                                      mostrarBorder: false,
                                      mostrarLinea: true,
                                    ),


                                    TituloDetalleTextWidget(
                                      title: "Novedad:",
                                      detalle: novedades.novedad,
                                      mostrarBorder: false,
                                    ),
                            
                                  ],
                                )
                              ],),));
                        })),
              )
            ],
          )
        : Container();
  }

  Widget _PersonalActivo(ResponsiveUtil responsive) {
    return _ListPersonalActivo.length > 0
        ? ExpansionTile(
            initiallyExpanded: true,
            title: Text(
              "Personal Activo " + _ListPersonalActivo.length.toString(),
              style: TextStyle(
                fontSize: responsive.anchoP(AppConfig.tamTextoTitulo),
              ),
            ),
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                    height: responsive.altoP(15),
                    width: responsive.anchoP(anchoContenedor) -
                        anchoContenedorHijos,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _ListPersonalActivo != null
                            ? _ListPersonalActivo.length
                            : 0,
                        itemBuilder: (context, index) {
                          PersonalRecintoElectoral personal =
                              _ListPersonalActivo[index];

                          return DisingPersonal(
                            index: index,
                            nombrePersonal: personal.personal,
                          );
                        })),
              )
            ],
          )
        : Container();
  }

  Widget _PersonalNoActivo(ResponsiveUtil responsive) {
    return _ListPersonalInactivo.length > 0
        ? ExpansionTile(
            initiallyExpanded: true,
            title: Text(
              "Personal No Activo " + _ListPersonalInactivo.length.toString(),
              style: TextStyle(
                fontSize: responsive.anchoP(AppConfig.tamTextoTitulo),
              ),
            ),
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                    height: responsive.altoP(15),
                    width: responsive.anchoP(anchoContenedor) -
                        anchoContenedorHijos,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _ListPersonalInactivo != null
                            ? _ListPersonalInactivo.length
                            : 0,
                        itemBuilder: (context, index) {
                          PersonalRecintoElectoral personal =
                              _ListPersonalInactivo[index];

                          return DisingPersonal(
                            index: index,
                            nombrePersonal: personal.personal,
                          );
                        })),
              )
            ],
          )
        : Container();
  }

  _ConusltarPersonalAsignado() async {
    try {
      if (!cargaInicial) return;
      if (peticionServer) return;

      setState(() {
        peticionServer = true;
      });

      _ListPersonalRecintoElectoral = await _recintosElectoralesApi
          .consultarDatosPersonalAsignadoRecintoElectoral(
        context: context,
        idDgoCreaOpReci: _RecintoProvider.getRecintoAbierto.idDgoCreaOpReci,
      );
      getDatos();

      setState(() {
        peticionServer = false;

      });

      _ConusltarNovedadesRecinto();
    } catch (e) {
      print("un error ${e.toString()}");
      setState(() {
        peticionServer = false;

      });
    }
  }

  _ConusltarNovedadesRecinto() async {
    try {
      if (!cargaInicial) return;
      if (peticionServer) return;

      setState(() {
        peticionServer = true;
      });

      String msj='';
      if(!_RecintoProvider.getRecintoAbierto.isRecinto){
        msj='';
      }

      _ListNovedadesRecinto = await _novedadesElectoralesApi
          .getDetalleNovedadesPorRecinto(
        context: context,
        idDgoCreaOpReci: _RecintoProvider.getRecintoAbierto.idDgoCreaOpReci,
      );


      setState(() {
        peticionServer = false;
        cargaInicial = false;
      });
    } catch (e) {
      print("un error ${e.toString()}");
      setState(() {
        peticionServer = false;
        cargaInicial = false;
      });
    }
  }
}
