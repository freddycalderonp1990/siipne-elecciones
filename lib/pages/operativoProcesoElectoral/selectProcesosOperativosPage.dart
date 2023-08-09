part of '../pages.dart';

class selectProcesosOperativosPage extends StatefulWidget {
  @override
  _selectProcesosOperativosPageState createState() => _selectProcesosOperativosPageState();
}

class _selectProcesosOperativosPageState extends State<selectProcesosOperativosPage> {
  var peticionServer = false;
  UserProvider _UserProvider;
  ProcesoOperativoProvider _ProcesoOperativoProvider;
  bool cargaInicial = true;

  ProcesosOperativosApi _ProcesosOperativosApi = new ProcesosOperativosApi();
  List<ProcesosOperativo> _listProcesosOperativo = new List();
  String procesoOperativo;
  int idProcesoOperativo = 0;

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
    _ProcesoOperativoProvider = ProcesoOperativoProvider.of(context);

    String Bienvenido = _UserProvider.getUser.sexo == 'HOMBRE'
        ? VariablesUtil.Bienvenido
        : VariablesUtil.Bienvenida;

    return WorkAreaPageWidget(
      mostrarVersion: false,
      btnAtras: true,

      peticionServer: peticionServer,
      title: VariablesUtil.OPERATIVOS,
      sizeTittle: 7,
      contenido: [
        Container(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(AppConfig.radioBordecajas),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white60.withOpacity(0.3),
                            blurRadius: 10)
                      ]),
                  child: Text(
                    Bienvenido + _UserProvider.getUser.apenom,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: responsive.anchoP(3.5)),
                  )),
              SizedBox(
                height: responsive.altoP(2),
              ),
              MyUbicacionWidget(
                callback: (_) {
                  _getProcesosOperativos();
                },
              ),
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

            ],
          ),
        ),
      ],
    );
  }

  _cerrarSession() {
    //Aquí (Route <dynamic> route) => false se asegurará de que se eliminen todas las rutas antes de hacer push de la ruta .
    Navigator.of(context).pushNamedAndRemoveUntil(
        AppConfig.pantallaLogin, (Route<dynamic> route) => false);

    //Navigator.pushReplacementNamed(context, AppConfig.pantallaLogin);
  }

  List<String> getDatosProcesosOperativos(
      List<ProcesosOperativo> listProcesosOperativos) {
    List<String> datos = new List();

    try {
      for (int i = 0; i < listProcesosOperativos.length; i++) {
        //datos.add(_recintosElectorales[i].nomRecintoElec + "\n(Distancia " +_recintosElectorales[i].distance+"m)");
        datos.add(listProcesosOperativos[i].descProcElecc);
      }
      return datos;
    }
    catch(e){
      return List();
    }

  }

  int getIdProcesosOperativos(String descProcElecc) {
    int id = 0;
    try {
      for (int i = 0; i < _listProcesosOperativo.length; i++) {
        if (_listProcesosOperativo[i].descProcElecc == descProcElecc) {
          id = int.parse(_listProcesosOperativo[i].idDgoProcElec);

          _ProcesoOperativoProvider.setProcesoOperativo(
              _listProcesosOperativo[i]);
          return id;
        }
      }
      return id;
    }
    catch(e){
      return 0;
    }
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

                  title: VariablesUtil.Operativos,
                  searchHint: 'Seleccione el ' + VariablesUtil.Operativos,
                  datos: datos,
                  selectValue: procesoOperativo,
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
      if(_listProcesosOperativo!=null) {
        if (_listProcesosOperativo.length == 1) {
          procesoOperativo = _listProcesosOperativo[0].descProcElecc;
          idProcesoOperativo = getIdProcesosOperativos(procesoOperativo);

          _ProcesoOperativoProvider.setProcesoOperativo(
              _listProcesosOperativo[0]);

        //  Navigator.of(context).pop();

          Navigator.pushNamed(context, AppConfig.pantallaTipoEjes);
          /*UtilidadesUtil.pantallasAbrirNuevaCerrarTodas(
              context: context, pantalla: AppConfig.pantallaTipoEjes);*/
        }
      }


    } catch (e) {
      setState(() {
        peticionServer = false;
        cargaInicial=false;
      });
    }
  }

  Widget btnContinuar(ResponsiveUtil responsive) {
    return idProcesoOperativo > 0
        ? Container(
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                VerificarGpsPage(pantalla: SelectTipoServiciosEjesPage())));

                  });
                }),
          )
        : Container();
  }



}
