part of '../pages.dart';

class PersonalDetallePage extends StatefulWidget {
  @override
  _PersonalDetallePageState createState() => _PersonalDetallePageState();
}

class _PersonalDetallePageState extends State<PersonalDetallePage> {
  UserProvider _UserProvider;
  RecintoAbiertoProvider _RecintoProvider;
  bool peticionServer = false;
  bool cargaInicial = true;
  double sizeIcons;

  String encargado;

  RecintosElectoralesApi _recintosElectoralesApi = new RecintosElectoralesApi();

  List<PersonalRecintoElectoral> _ListPersonalRecintoElectoral = new List();
  List<PersonalRecintoElectoral> _ListPersonalActivo = new List();
  List<PersonalRecintoElectoral> _ListPersonalInactivo = new List();

  //CONFIGURACIONES
  final anchoContenedor = AppConfig.anchoContenedor;
  final anchoContenedorHijos = AppConfig.anchoContenedorHijos;
  final paddingContenido = 10.0;

  @override
  Widget build(BuildContext context) {
    print("PersonalDetallePage - elecciones");
    final responsive = ResponsiveUtil(context);
    sizeIcons =
        responsive.isVertical() ? responsive.altoP(3) : responsive.anchoP(5);
    _UserProvider = UserProvider.of(context);
    _RecintoProvider = RecintoAbiertoProvider.of(context);
    final separcion = 0.5;

    _ConusltarPersonalAsignado();
    String imgFondo = AppConfig.imgFondoDefault;
    if (_RecintoProvider.getRecintoAbierto.isRecinto) {
      imgFondo = AppConfig.imgFondoElecciones;
    }

    return WorkAreaPageWidget(
      imgFondo: imgFondo,
      btnAtras: true,
      peticionServer: peticionServer,
      title: "REPORTE DEL PERSONAL",
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
            Container(
              padding: EdgeInsets.all(5),
              child: TituloTextWidget(
                textAlign: TextAlign.center,
                title: _RecintoProvider.getRecintoAbierto.nomRecintoElec,
              ),
            ),
            _wgJefe(responsive),
            _PersonalActivo(responsive),
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
                  title: "Total Personal",
                  detalle: (_ListPersonalRecintoElectoral.length).toString(),
                  mostrarBorder: true,
                ),
              ],
            ),
          ),
        )
      ],
    );
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
                            onTap: () {
                              DialogosWidget.alertSiNo(context,
                                  title: "INACTIVAR",
                                  message:
                                      "¿Esta seguro que desea inactivar a ${personal.personal}. del Operativo?",
                                  onTap: () {
                                Navigator.of(context).pop();
                                _AbandonarRecintoElectoral(
                                    usuario: _UserProvider.getUser.idGenUsuario,
                                    idDgoPerAsigOpe: personal.idDgoPerAsigOpe,
                                    nombre: personal.personal);
                              });
                            },
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

  _AbandonarRecintoElectoral(
      {@required String usuario,
      @required String idDgoPerAsigOpe,
      String nombre}) async {
    try {
      if (peticionServer) return;

      setState(() {
        peticionServer = true;
      });
      String latitud =
          _UserProvider.getUser.ubicacionSeleccionada.latitude.toString();
      String longitud =
          _UserProvider.getUser.ubicacionSeleccionada.longitude.toString();

      bool res = await _recintosElectoralesApi.abandonarRecintoElectoral(
          context: context,
          idDgoPerAsigOpe: idDgoPerAsigOpe,
          latitud: latitud,
          longitud: longitud,
          usuario: usuario,
          msjDialogo: "Ha inactivado a ${nombre}, de su recinto electoral.");

      setState(() {
        peticionServer = false;
      });
    } catch (e) {
      setState(() {
        peticionServer = false;
      });
    }
  }
}

class DisingPersonal extends StatelessWidget {
  final int index;
  final String nombrePersonal;
  final GestureTapCallback onTap;
  const DisingPersonal({Key key, this.index, this.nombrePersonal, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil(context);

    return Container(
        margin: EdgeInsets.all(2),
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(color: AppConfig.colorBordecajas, blurRadius: 1)
            ]),
        child: Row(
          children: <Widget>[
            Text(
              (index + 1).toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: responsive.anchoP(4), fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: responsive.altoP(1),
            ),
            Image.asset(
              AppConfig.icon_agregar_personal,
              width: responsive.anchoP(5),
              height: responsive.anchoP(5),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Container(
                    child: Text(
                  nombrePersonal != null ? nombrePersonal : 'Null',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: responsive.anchoP(4),
                  ),
                )),
              ),
            ),
            onTap != null
                ? BtnIconWidget(
                    iconData: Icons.cancel,
                    color: Colors.red.withOpacity(0.2),
                    colorTextoIcon: Colors.white,
                    onTap: onTap,
                    elevation: 2,
                    paddinHorizontal: 0,
                  )
                : Container()
          ],
        ));
  }
}
