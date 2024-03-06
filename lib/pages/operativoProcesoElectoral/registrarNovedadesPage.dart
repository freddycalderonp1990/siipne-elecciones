part of '../pages.dart';

class registrarNovedadesPage extends StatefulWidget {
  @override
  _registrarNovedadesPageState createState() => _registrarNovedadesPageState();
}

class _registrarNovedadesPageState extends State<registrarNovedadesPage> {
  //aqui voy a guardar lo que selecciono en el combo 1 que seria el tipo de novedad o combo padre
  //leaa el chat de zoo
  String tipoNovedadComboPadre = "";

  UserProvider _UserProvider;
  RecintoAbiertoProvider _RecintoProvider;

  DatosPer _datosPers = new DatosPer(idGenPersona: "0");
  GenPersonaApi _genPersonaApi = new GenPersonaApi();

  bool peticionServer = false;
  bool cargaInicial = true;
  bool validarForm = false;
  bool mostrarFoto = false;
  bool mostrarGuardar = false;
  bool registrarDatosPersona = false;

  bool selectPadre = true;
  String nombreDetenido = "null";
  String idGenPersonaD = "null";
  GaleryCameraModel mGaleryCameraModel =
      new GaleryCameraModel(image: null, nombreImg: "");

  DateTime selectedDate = DateTime.now();
  String fecha;

  String cedula =
      'null'; //varibale para guardar en el campo documento la cedula solo cuando se le asigne un valor diferente de null

  //CONFIGURACIONES
  final anchoContenedor = AppConfig.anchoContenedor;
  final anchoContenedorHijos = AppConfig.anchoContenedorHijos;
  final paddingContenido = 10.0;
  double sizeIcons;

  final _formKey = GlobalKey<FormState>();

  var controllerCedula = new TextEditingController();
  var controllerTelefono = new TextEditingController();
  var controllerNumBoleta = new TextEditingController();
  var controllerNumCitacion = new TextEditingController();
  var controllerObs = new TextEditingController();
  var controllerHora = new TextEditingController();
  var controllerMinuto = new TextEditingController();

  var controllerOrganizacion = new TextEditingController();
  var controllerDirigente = new TextEditingController();
  var controllerCantidad = new TextEditingController();

  var controllerNombre = new TextEditingController();
  var controllerCargo = new TextEditingController();
  var controllerGrado = new TextEditingController();
  var controllerMedioComunicacion = new TextEditingController();

  var controllerFuncion = new TextEditingController();
  var controllerDescripcion = new TextEditingController();
  var controllerInstalacion = new TextEditingController();
  var controllerDireccion = new TextEditingController();
  var controllerUnidad = new TextEditingController();

  var controllerMotivo = new TextEditingController();
  var controllerNumericoPersonal = new TextEditingController();

  var controllerNumerico = new TextEditingController();

  String observaciones = "";

  bool existeNovedades = true;

  Widget wgCajaTextos = Container();
  Widget wgCajaTextosHijas = Container();

  List<NovedadesElectorale> _listNovedadesPadres = new List();
  List<NovedadesElectorale> _listNovedadesHijas = new List();
  List<NovedadesElectorale> _listNovedadesNietos = new List();
  NovedadesElectoralesApi _novedadesElectoralesApi =
      new NovedadesElectoralesApi();

  //Combos
  int selectNovedad = 1; //1=SI, 2=NO

  String novedades;
  String novedadesPadres, novedadesHijas, novedadesNietos;
  String idNovedades = "0";

  Color colorManifestantes = Colors.green;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    UtilidadesUtil.getTheme();
    /*controllerHora.text = "00";
    controllerMinuto.text = "00";*/

    controllerHora.text =
        DateFormat(AppConfig.formatoSoloHora).format(selectedDate);
    controllerMinuto.text =
        DateFormat(AppConfig.formatoSoloMinuto).format(selectedDate);
    print("registrarNovedadesPage - elecciones");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //Variable para obtener el tamaño de la pantalla
    fecha = DateFormat(AppConfig.formatoFechaHora).format(selectedDate);

    final responsive = ResponsiveUtil(context);
    sizeIcons =
        responsive.isVertical() ? responsive.altoP(3) : responsive.anchoP(5);

    _UserProvider = UserProvider.of(context);
    _RecintoProvider = RecintoAbiertoProvider.of(context);

    _getNovedadesPadres();
    String imgFondo = AppConfig.imgFondoDefault;
    if (_RecintoProvider.getRecintoAbierto.isRecinto) {
      imgFondo = AppConfig.imgFondoElecciones;
    }

    return WorkAreaPageWidget(
      imgFondo: imgFondo,
      btnAtras: true,
      peticionServer: peticionServer,
      title: VariablesUtil.recElecRegistrarNovedades,
      contenido: [
        _RecintoProvider.getRecintoAbierto.isJefe
            ? Container(
                width: responsive.anchoP(70),
                child: BtnIconWidget(
                  iconData: Icons.assignment_sharp,
                  title: "Ver Novedades",
                  colorTextoIcon: Colors.white,

                  onTap: () {
                    Navigator.pushNamed(
                        context, AppConfig.pantallaRecElecNovedadesDetalle);
                  },
                ),
              )
            : Container(),
        SizedBox(
          height: responsive.altoP(2),
        ),
        MyUbicacionWidget(
          callback: (_) {},
        ),
        SizedBox(
          height: responsive.altoP(1),
        ),
        getCombos(responsive),
        validarForm ?? int.parse(idNovedades) > 0
            ? ContenedorDesingWidget(
                margin: EdgeInsets.only(top: 10),
                anchoPorce: anchoContenedor,
                child: Column(
                  children: [
                    wgCajaTextos,
                    wgCajaTextosHijas,
                    SizedBox(
                      height: responsive.altoP(2),
                    ),
                  ],
                ),
              )
            : Container(),
        mostrarFoto ? wgFoto(responsive) : Container(),
        SizedBox(
          height: responsive.altoP(3),
        ),
        btnGuardar(responsive, context)
      ],
    );
  }

  Widget widgetCheckBoxNovedades(ResponsiveUtil responsive) {
    return Container(
        padding: EdgeInsets.all(5),
        width: responsive.anchoP(anchoContenedor) - anchoContenedorHijos,
        child: Column(
          children: [
            TituloTextWidget(
              title: "Existe Novedades",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Radio(
                  focusColor: Colors.black,
                  value: 1,
                  groupValue: selectNovedad,
                  onChanged: getNovedad,
                ),
                new Text(
                  VariablesUtil.SI,
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: responsive.anchoP(AppConfig.tamTextoTitulo),
                    color: Colors.black,
                  ),
                ),
                new Radio(
                  focusColor: Colors.black,
                  value: 2,
                  groupValue: selectNovedad,
                  onChanged: getNovedad,
                ),
                new Text(
                  VariablesUtil.NO,
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: responsive.anchoP(AppConfig.tamTextoTitulo),
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Widget wgTxtCedula(
      {ResponsiveUtil responsive, String title = VariablesUtil.cedula}) {
    return Form(
      key: _formKey,
      child: Column(
        children: [getWgCedulaWithFind(responsive)],
      ),
    );
  }

  Widget wgTxtCedulaTelefono(
      {ResponsiveUtil responsive, String title = VariablesUtil.cedula}) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          getWgCedulaWithFind(responsive),
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

  Widget wgTxtObservacion(
      {ResponsiveUtil responsive, String title = VariablesUtil.cedula}) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            child: Text(
              "Observación",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: responsive.diagonalP(1.5),
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
          ),
          Column(
            children: <Widget>[
              Card(
                  color: Colors.white54,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controllerObs,
                      maxLength: 100,
                      maxLines: 4, //or null
                      decoration: InputDecoration.collapsed(
                          hintText: "Ingrese la Observación"),
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }

  //Widget para detenidos

  Widget wgTxtCedulaBoleta(ResponsiveUtil responsive) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controllerNumBoleta,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: sizeIcons,
            ),
            label: VariablesUtil.numBoleta,
            fonSize: responsive.anchoP(AppConfig.tamTextoTitulo),
            validar: validateNumBoleta,
          ),
          getWgCedulaWithFind(responsive)
        ],
      ),
    );
  }

  Widget getWgCedulaWithFind(ResponsiveUtil responsive) {
    var _keyColumna = GlobalKey();

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: ImputTextWidget(
                keyboardType: TextInputType.number,
                controller: controllerCedula,
                icono: Icon(
                  Icons.assignment_sharp,
                  color: Colors.black38,
                  size: sizeIcons,
                ),
                label: VariablesUtil.cedula,
                fonSize: responsive.anchoP(AppConfig.tamTextoTitulo),
                validar: validateCedula,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(10),
                child: BtnIconWidget(
                  onTap: () {
                    _consultarDatosPersonaPorDocumento(
                        cedula: controllerCedula.text,
                        usuario: _UserProvider.getUser.idGenUsuario);
                  },
                  iconData: Icons.search,
                  colorTextoIcon: Colors.white,

                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: responsive.altoP(1),
        ),
        _datosPers.idGenPersona != "0"
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TituloDetalleTextWidget(
                  title: "Nombres:",
                  detalle: _datosPers.siglas.length > 0
                      ? _datosPers.siglas + "." + _datosPers.apenom
                      : _datosPers.apenom,
                ),
              )
            : Container(),
      ],
    );
  }

  Widget wgTxtCedulaCitacion(ResponsiveUtil responsive) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controllerNumCitacion,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: sizeIcons,
            ),
            label: VariablesUtil.numCitacion,
            fonSize: responsive.anchoP(AppConfig.tamTextoTitulo),
            validar: validateNumCitacion,
          ),
          getWgCedulaWithFind(responsive)
        ],
      ),
    );
  }

  Widget wgTxtMotivo(ResponsiveUtil responsive) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controllerMotivo,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: sizeIcons,
            ),
            label: "Motivo",
            fonSize: responsive.anchoP(AppConfig.tamTextoTitulo),
            validar: validateNumCitacion,
          ),
        ],
      ),
    );
  }

  Widget wgTxtNumericoPersonal(ResponsiveUtil responsive) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ImputTextWidget(
            keyboardType: TextInputType.number,
            controller: controllerNumericoPersonal,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: sizeIcons,
            ),
            label: "Númerico del Personal",
            fonSize: responsive.anchoP(AppConfig.tamTextoTitulo),
            validar: validateNumPersonal,
          ),
        ],
      ),
    );
  }

  Widget wgTxtNumeroManifestantes(responsive) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controllerOrganizacion,
            icono: Icon(
              Icons.category,
              color: Colors.black38,
              size: sizeIcons,
            ),
            label: "Organización Social o Política",
            fonSize: responsive.anchoP(AppConfig.tamTextoTitulo),
            validar: validateOrganizacion,
          ),
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controllerDirigente,
            icono: Icon(
              Icons.category,
              color: Colors.black38,
              size: sizeIcons,
            ),
            label: "Dirigente",
            fonSize: responsive.anchoP(AppConfig.tamTextoTitulo),
            validar: validateDirigente,
          ),
          ImputTextWidget(
            keyboardType: TextInputType.number,
            controller: controllerCantidad,
            onChanged: (valor) {
              if (valor != null) {
                if (int.parse(valor) > 100) {}
              }
            },
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: sizeIcons,
            ),
            label: "Cantidad",
            fonSize: responsive.anchoP(AppConfig.tamTextoTitulo),
            validar: validateCantidad,
          ),
        ],
      ),
    );
  }

  Widget wgTxtNumeroQuemaUrnas(responsive) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controllerOrganizacion,
            icono: Icon(
              Icons.category,
              color: Colors.black38,
              size: sizeIcons,
            ),
            label: "Organización Social o Política",
            fonSize: responsive.anchoP(AppConfig.tamTextoTitulo),
            validar: validateOrganizacion,
          ),
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controllerDirigente,
            icono: Icon(
              Icons.category,
              color: Colors.black38,
              size: sizeIcons,
            ),
            label: "Dirigente",
            fonSize: responsive.anchoP(AppConfig.tamTextoTitulo),
            validar: validateDirigente,
          ),
          ImputTextWidget(
            keyboardType: TextInputType.number,
            controller: controllerCantidad,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: sizeIcons,
            ),
            label: "Cantidad",
            fonSize: responsive.anchoP(AppConfig.tamTextoTitulo),
            validar: validateCantidad,
          ),
        ],
      ),
    );
  }

  Widget wgTxtNumeroTomaRecintos(responsive) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controllerCantidad,
            icono: Icon(
              Icons.category,
              color: Colors.black38,
              size: sizeIcons,
            ),
            label: "Organización Social o Política",
            fonSize: responsive.anchoP(AppConfig.tamTextoTitulo),
            validar: validateOrganizacion,
          ),
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controllerDirigente,
            icono: Icon(
              Icons.category,
              color: Colors.black38,
              size: sizeIcons,
            ),
            label: "Dirigente",
            fonSize: responsive.anchoP(AppConfig.tamTextoTitulo),
            validar: validateDirigente,
          ),
          ImputTextWidget(
            keyboardType: TextInputType.number,
            controller: controllerCantidad,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: sizeIcons,
            ),
            label: "Cantidad",
            fonSize: responsive.anchoP(AppConfig.tamTextoTitulo),
            validar: validateCantidad,
          ),
        ],
      ),
    );
  }

  Widget wgTxtDesplazamientosAutoridades(responsive) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controllerNombre,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: sizeIcons,
            ),
            label: "Nombre",
            fonSize: responsive.anchoP(AppConfig.tamTextoTitulo),
            validar: validateNombre,
          ),
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controllerCargo,
            icono: Icon(
              Icons.category,
              color: Colors.black38,
              size: sizeIcons,
            ),
            label: "Cargo/Función",
            fonSize: responsive.anchoP(AppConfig.tamTextoTitulo),
            validar: validateCargo,
          ),
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controllerGrado,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: sizeIcons,
            ),
            label: "Grado (Opcional)",
            fonSize: responsive.anchoP(AppConfig.tamTextoTitulo),
          ),
        ],
      ),
    );
  }

  Widget wgTxtApoyoMediosComunicacion(responsive) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controllerNombre,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: sizeIcons,
            ),
            label: "Nombre",
            fonSize: responsive.anchoP(AppConfig.tamTextoTitulo),
            validar: validateNombre,
          ),
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controllerMedioComunicacion,
            icono: Icon(
              Icons.category,
              color: Colors.black38,
              size: sizeIcons,
            ),
            label: "Medio de Comunicación",
            fonSize: responsive.anchoP(AppConfig.tamTextoTitulo),
            validar: validateMedioComunicacion,
          ),
        ],
      ),
    );
  }

  Widget wgTxtSeguridadPersonasImportantes(responsive) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controllerFuncion,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: sizeIcons,
            ),
            label: "Función",
            fonSize: responsive.anchoP(AppConfig.tamTextoTitulo),
            validar: validateFuncion,
          ),
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controllerNombre,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: sizeIcons,
            ),
            label: "Nombres",
            fonSize: responsive.anchoP(AppConfig.tamTextoTitulo),
            validar: validateNombre,
          ),
        ],
      ),
    );
  }

  Widget wgTxtSeguridadInstalaciones(responsive) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controllerInstalacion,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: sizeIcons,
            ),
            label: "Nombre Instalación",
            fonSize: responsive.anchoP(AppConfig.tamTextoTitulo),
            validar: validateInstalacion,
          ),
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controllerDescripcion,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: sizeIcons,
            ),
            label: "Descripción",
            fonSize: responsive.anchoP(AppConfig.tamTextoTitulo),
            validar: validateDescripcion,
          ),
        ],
      ),
    );
  }

  Widget wgTxtExplosivos(responsive) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controllerDireccion,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: sizeIcons,
            ),
            label: "Dirección",
            fonSize: responsive.anchoP(AppConfig.tamTextoTitulo),
            validar: validateDireccion,
          ),
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controllerDescripcion,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: sizeIcons,
            ),
            label: "Descripción",
            fonSize: responsive.anchoP(AppConfig.tamTextoTitulo),
            validar: validateDescripcion,
          ),
        ],
      ),
    );
  }

  Widget wgTxtApoyoUnidadesPoliciales(responsive) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ImputTextWidget(
            keyboardType: TextInputType.text,
            controller: controllerUnidad,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: sizeIcons,
            ),
            label: "Unidad",
            fonSize: responsive.anchoP(AppConfig.tamTextoTitulo),
            validar: validateUnidad,
          ),
        ],
      ),
    );
  }

  Widget wgTxtHora(ResponsiveUtil responsive) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: responsive.altoP(1),
          ),
          getComboHora(responsive),
          getComboMinuto(responsive)
        ],
      ),
    );
  }

  Widget wgTxtNumerico(responsive) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ImputTextWidget(
            keyboardType: TextInputType.number,
            controller: controllerNumerico,
            icono: Icon(
              Icons.assignment_sharp,
              color: Colors.black38,
              size: sizeIcons,
            ),
            label: "Numérico",
            fonSize: responsive.anchoP(AppConfig.tamTextoTitulo),
            validar: validateNumerico,
          ),
        ],
      ),
    );
  }

  getNovedad(int valueRadio) {
    if (valueRadio == 1) {
      existeNovedades = true;
    } else {
      existeNovedades = false;
    }

    setState(() {
      novedades = "";
      selectNovedad = valueRadio;
    });
  }

  String validateCedula(String value) {
    if (value.length < 10) {
      return VariablesUtil.ingreseCedula;
    }

    return null;
  }

  String validateTelefono(String value) {
    if (value.length < 8) {
      return "Ingrese el número de Teléfono";
    }

    return null;
  }

  String validateNumBoleta(String value) {
    if (value.length < 5) {
      return VariablesUtil.ingreseBoleta;
    }

    return null;
  }

  String validateNumPersonal(String value) {
    if (value.length == 0 || int.parse(value) < 1) {
      return "Ingrese el Númerico del Personal";
    }

    return null;
  }

  String validateNumCitacion(String value) {
    if (value.length < 3) {
      return VariablesUtil.ingreseCitacion;
    }

    return null;
  }

  String validateOrganizacion(String value) {
    if (value.length < 3) {
      return "Ingrese Organización";
    }

    return null;
  }

  String validateDirigente(String value) {
    if (value.length < 3) {
      return "Ingrese al Dirigente";
    }

    return null;
  }

  String validateCantidad(String value) {
    if (value.length == 0 || int.parse(value) == 0) {
      return "Ingrese una cantidad";
    }

    return null;
  }

  String validateNombre(String value) {
    if (value.length < 3) {
      return "Ingrese el Nombre";
    }

    return null;
  }

  String validateCargo(String value) {
    if (value.length < 3) {
      return "Ingrese el Cargo";
    }

    return null;
  }

  String validateMedioComunicacion(String value) {
    if (value.length < 3) {
      return "Ingrese el nombre del Medio de Comunicación";
    }

    return null;
  }

  String validateFuncion(String value) {
    if (value.length < 3) {
      return "Ingrese la función";
    }

    return null;
  }

  String validateDescripcion(String value) {
    if (value.length < 3) {
      return "Ingrese la Descripción";
    }

    return null;
  }

  String validateInstalacion(String value) {
    if (value.length < 3) {
      return "Ingrese la Instalación";
    }

    return null;
  }

  String validateDireccion(String value) {
    if (value.length < 3) {
      return "Ingrese la Dirección";
    }

    return null;
  }

  String validateUnidad(String value) {
    if (value.length < 3) {
      return "Ingrese la Unidad";
    }

    return null;
  }

  String validateNumerico(String value) {
    if (value.length == 0 || int.parse(value) == 0) {
      return "Ingrese el Numérico";
    }

    return null;
  }

  Widget btnGuardar(ResponsiveUtil responsive, BuildContext context) {
    return int.parse(idNovedades) > 0
        ? Container(
            width: responsive.anchoP(anchoContenedor),
            child: BotonesWidget(
              iconData: Icons.save,
              padding: EdgeInsets.symmetric(horizontal: 10),
              title: VariablesUtil.GUARDAR,
              onPressed: () {
                if (_listNovedadesNietos.length > 0) {
                  DialogosAwesome.getWarningSiNo(
                      title: 'Esta Seguro de Registrar esta Novedad',
                      context: context,
                      descripcion: 'Registro de Novedad ' +
                          novedadesHijas +
                          ' \n Tipo Delito - ' +
                          novedadesNietos +
                          '\n  Detenido - ' +
                          _datosPers.apenom,
                      btnOkOnPress: () {
                        _EventoRegistrarNovedadesElectorales(context);
                      });
                } else {
                  DialogosAwesome.getWarningSiNo(
                      title: 'Esta Seguro de Registrar esta Novedad',
                      context: context,
                      descripcion: 'Registro de Novedad ' + novedadesHijas,
                      btnOkOnPress: () {
                        _EventoRegistrarNovedadesElectorales(context);
                      });
                }
              },
            ),
          )
        : Container();
  }

  _EventoRegistrarNovedadesElectorales(BuildContext context) async {
    bool isValid = true;
    if (validarForm) {
      isValid = _formKey.currentState.validate();
    }
    if (registrarDatosPersona) {
      if (_datosPers.idGenPersona == "0") {
        DialogosAwesome.getInformation(
            context: context,
            descripcion:
                "No ha ingresado una cédula valida...Seleccione el icono buscar para continuar.",
            title: 'Persona');

        return;
      }
      nombreDetenido = _datosPers.apenom;
      idGenPersonaD = _datosPers.idGenPersona;
    }

    print("isValid");
    print(isValid);

    if (isValid) {
      if (mostrarFoto) {
        if (mGaleryCameraModel.image == null) {
          DialogosWidget.alert(context,
              title: "Imagen", message: "Selelcione una Imagen");
        } else {
          bool insertImg = await guardarImgRecElectNovedades(
              galeryCameraModel: mGaleryCameraModel);
          print('Ingreso con imagen');

          if (insertImg) {
            await _RegistrarNovedades(
                idGenPersonaD: idGenPersonaD,
                nombreDetenido: nombreDetenido,
                usuario: _UserProvider.getUser.idGenUsuario,
                observacion: getObservacion(),
                idDgoPerAsigOpe:
                    _RecintoProvider.getRecintoAbierto.idDgoPerAsigOpe,
                idDgoNovedadesElect: idNovedades,
                imagen: mGaleryCameraModel.nombreImg);
          }
        }
      } else {
        print('no foto');
        await _RegistrarNovedades(
            idGenPersonaD: idGenPersonaD,
            nombreDetenido: nombreDetenido,
            usuario: _UserProvider.getUser.idGenUsuario,
            observacion: getObservacion(),
            idDgoPerAsigOpe: _RecintoProvider.getRecintoAbierto.idDgoPerAsigOpe,
            idDgoNovedadesElect: idNovedades);
      }
    }
  }

  List<String> getDatos(List<NovedadesElectorale> _listNovedadesPadres) {
    List<String> datos = new List();
    for (int i = 0; i < _listNovedadesPadres.length; i++) {
      String descripcion = _listNovedadesPadres[i].descripcion;
      if (descripcion != null) {
        datos.add(descripcion);
      }
    }
    return datos;
  }

  //Sirve para padres,e hijas
  int getIdNovedades(String novedad, List<NovedadesElectorale> listNovedades) {
    int id = 0;
    for (int i = 0; i < listNovedades.length; i++) {
      if (listNovedades[i].descripcion == novedad) {
        id = int.parse(listNovedades[i].idDgoNovedadesElect);
        return id;
      }
    }
  }

  Widget wgCajasTexto(String novedadesPadres, ResponsiveUtil responsive) {
    Widget wg = Container();
    registrarDatosPersona = true;
    print("estamos ingresando");
    if (novedadesPadres != null) {
      tipoNovedadComboPadre = "";

      mostrarFoto = false;
      validarForm = false;
      switch (novedadesPadres.trim().toUpperCase()) {
        case "NOVEDADES":
          registrarDatosPersona = false;
          break;

        case "DELITOS":
          tipoNovedadComboPadre = novedadesPadres;
          validarForm = true;
          wg = wgTxtCedula(responsive: responsive);
          break;

        case "DETENIDOS":
          tipoNovedadComboPadre = novedadesPadres;
          validarForm = true;
          wg = wgTxtCedulaBoleta(responsive);
          break;

        case "CITACIONES":
          tipoNovedadComboPadre = novedadesPadres;
          validarForm = true;
          wg = wgTxtCedulaCitacion(responsive);
          break;

        case "VOTO EN CASA":
          registrarDatosPersona = false;
          tipoNovedadComboPadre = novedadesPadres;
          validarForm = true;
          wg = wgTxtObservacion(responsive: responsive);
          break;

        case "NOV PPL":
          registrarDatosPersona = false;
          tipoNovedadComboPadre = novedadesPadres;
          validarForm = true;
          wg = wgTxtObservacion(responsive: responsive);
          break;
        case "UMO":
          //mostrarFoto = true;

          //wg = wgTxtCedulaCitacion(responsive);
          break;

        default:
          wg = Container();
      }
      setState(() {});
    }
    return wg;
  }

  Widget wgCajasTextoNovedades(
      int idDgoNovedadesElect, ResponsiveUtil responsive) {
    Widget wg = Container();
    print("suiii");
    print(idDgoNovedadesElect);
    validarForm = false;
    mostrarFoto = false;
    registrarDatosPersona = false;
    switch (idDgoNovedadesElect) {
      case 17:
        //1. RECINTOS ELECTORALES INSTALADOS
        wg = Container();
        break;

      case 18:
        //2. RECINTOS ELECTORALES NO INSTALADOS
        wg = Container();
        break;

      case 19:
        //3. RECINTO ELECTORAL INSTALADO CON RETARDO POR DIFERENTES CAUSAS

        wg = wgTxtHora(responsive);
        validarForm = true;
        break;

      case 20:
        //4. RECINTOS ELECTORALES SUSPENDIDO POR DIFERENTES CAUSAS
        wg = wgTxtMotivo(responsive);
        validarForm = true;
        mostrarFoto = true;
        break;

      case 21:
        //5. AGRESIONES A SERVIDORES POLICIALES
        tipoNovedadComboPadre = "21";
        wg = wgTxtCedula(responsive: responsive, title: VariablesUtil.cedulaSP);
        validarForm = true;
        mostrarFoto = true;
        break;

      case 22:
        //6. PRESENCIA DE MANIFESTANTES / CONCENTRACIONES / MARCHAS
        wg = Column(
          children: [
            wgTxtNumeroManifestantes(responsive),
            SizedBox(
              height: responsive.altoP(1),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.green.withOpacity(0.8),
                      title: "1-50"),
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.yellow.withOpacity(0.8),
                      title: "51-200"),
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.orange.withOpacity(0.8),
                      title: "201-500"),
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.red.withOpacity(0.8),
                      title: "501-Más"),
                ],
              ),
            )
          ],
        );
        validarForm = true;
        mostrarFoto = true;
        break;

      case 23:
        //7. QUEMA DE URNAS / PAPELETAS
        validarForm = true;
        mostrarFoto = true;
        wg = Column(
          children: [
            wgTxtNumeroQuemaUrnas(responsive),
            SizedBox(
              height: responsive.altoP(1),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.green.withOpacity(0.8),
                      title: "1-50"),
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.yellow.withOpacity(0.8),
                      title: "51-200"),
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.orange.withOpacity(0.8),
                      title: "201-500"),
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.red.withOpacity(0.8),
                      title: "501-Más"),
                ],
              ),
            )
          ],
        );
        break;

      case 28:
        //8. TOMA DE RECINTOS / DELEGACIONES / BODEGAS / INSTALACIONES DEL CNE
        validarForm = true;
        mostrarFoto = true;
        wg = Column(
          children: [
            wgTxtNumeroTomaRecintos(responsive),
            SizedBox(
              height: responsive.altoP(1),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.green.withOpacity(0.8),
                      title: "1-50"),
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.yellow.withOpacity(0.8),
                      title: "51-200"),
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.orange.withOpacity(0.8),
                      title: "201-500"),
                  getBtnColores(
                      responsive: responsive,
                      color: Colors.red.withOpacity(0.8),
                      title: "501-Más"),
                ],
              ),
            )
          ],
        );
        break;

      case 29:
        //9. PRESENCIA DE VENTAS AMBULANTES
        wg = Container();
        mostrarFoto = true;
        break;

      case 30:
        //10. ATENCIÓN MÉDICA POR DIFERENTES CAUSAS
        validarForm = true;
        tipoNovedadComboPadre = "30";
        mostrarFoto = true;
        wg = wgTxtCedulaTelefono(responsive: responsive);
        break;

      case 31:
        //11. SERVIDORES POLICIALES INFECTADOS (SOSPECHA/POSITIVO)

        validarForm = true;
        wg = wgTxtCedulaTelefono(
            responsive: responsive, title: VariablesUtil.cedulaSP);
        break;

      case 32:
        //NUMÉRICO DE ACÉMILAS
        wg = wgTxtNumerico(responsive);
        validarForm = true;
        break;

      /*********************** UMO ***************************************/
      case 33:
        //1. NUMERICO DE PERSONAL
        wg = wgTxtNumericoPersonal(responsive);
        validarForm = true;
        validarForm = true;
        break;

      case 34:
        //2. PLANTONES
        wg = wgorganizacionDirigenteCantidad(responsive);
        validarForm = true;
        validarForm = true;
        break;

      case 35:
        //3. MARCHAS
        wg = wgorganizacionDirigenteCantidad(responsive);
        validarForm = true;
        validarForm = true;
        break;

      case 36:
        //4. CIERRE DE VIAS
        wg = wgorganizacionDirigenteCantidad(responsive);
        validarForm = true;
        validarForm = true;
        break;

      case 37:
        //5. TOMA DE ENTIDADES
        wg = wgorganizacionDirigenteCantidad(responsive);
        validarForm = true;
        validarForm = true;
        break;

      /************************AEREOPOLCIAL*************************************/
      case 45:
        //1. DESPLAZAMIENTO DE AUTORIDADES
        wg = wgTxtDesplazamientosAutoridades(responsive);
        validarForm = true;
        break;

      case 46:
        //2. DESPLAZAMIENTO DE SERVIDORES PÚBLICOS
        wg = wgTxtDesplazamientosAutoridades(responsive);
        validarForm = true;
        break;

      case 47:
        //3. APOYO AÉREO A MEDIOS DE COMUNICACIÓN
        wg = wgTxtApoyoMediosComunicacion(responsive);
        validarForm = true;
        break;
      /************************GOE - GIR*************************************/
      case 41:
        //1. SEGURIDAD DE PERSONAS IMPORTANTES
        wg = wgTxtSeguridadPersonasImportantes(responsive);
        validarForm = true;
        break;

      case 42:
        //2. SEGURIDAD DE INSTALACIONES
        wg = wgTxtSeguridadInstalaciones(responsive);
        validarForm = true;
        mostrarFoto = true;
        break;

      case 43:
        //3. REGISTRO DE EXPLOSIVOS
        wg = wgTxtExplosivos(responsive);
        validarForm = true;
        mostrarFoto = true;
        break;

      case 44:
        //4. APOYO A UNIDADES POLICIALES
        wg = wgTxtApoyoUnidadesPoliciales(responsive);
        validarForm = true;
        break;

      /************************CARCK - UMO - UER*************************************/
      case 49:
        //AGLOMERACIONES
        wg = wgTxtNumerico(responsive);
        validarForm = true;
        break;

      case 50:
        //NUMÉRICO DE ACÉMILAS
        wg = wgTxtNumerico(responsive);
        validarForm = true;
        break;

      case 51:
        //NUMÉRICO DE CANES
        wg = wgTxtNumerico(responsive);
        validarForm = true;
        break;

      case 52:
        //PERSONAL ESTÁTICO
        wg = wgTxtNumerico(responsive);
        validarForm = true;
        break;

      case 53:
        //PERSONAL MÓVIL
        wg = wgTxtNumerico(responsive);
        validarForm = true;
        break;

      case 54:
        //INICIA SERVICIO
        wg = wgTxtHora(responsive);
        validarForm = true;
        break;

      case 55:
        //FINALIZA SERVICIO
        wg = wgTxtHora(responsive);
        validarForm = true;
        break;

      default:
        print('idDgoNovedadesElect');
        validarForm = false;
        mostrarFoto = false;
        wg = Container();
    }

    return wg;
  }

  Widget wgorganizacionDirigenteCantidad(ResponsiveUtil responsive) {
    return Column(
      children: [
        wgTxtNumeroManifestantes(responsive),
        SizedBox(
          height: responsive.altoP(1),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getBtnColores(
                  responsive: responsive,
                  color: Colors.green.withOpacity(0.8),
                  title: "1-50"),
              getBtnColores(
                  responsive: responsive,
                  color: Colors.yellow.withOpacity(0.8),
                  title: "51-200"),
              getBtnColores(
                  responsive: responsive,
                  color: Colors.orange.withOpacity(0.8),
                  title: "201-500"),
              getBtnColores(
                  responsive: responsive,
                  color: Colors.red.withOpacity(0.8),
                  title: "501-Más"),
            ],
          ),
        )
      ],
    );
  }

  String getObservacion() {
    String observacion = "";
    mostrarGuardar = true;
    ObservacionModel observacionModel =
        ObservacionModel(idDgoNovedadesElect: idNovedades);
    cedula = 'null';
    if (novedadesPadres != null) {
      switch (novedadesPadres.trim().toUpperCase()) {
        case "NOVEDADES":
          // observacion = '{"cedula": "${controllerCedula.text}"}';
          cedula = 'null';
          observacionModel = getObservacionNovedades();
          break;

        case "DELITOS":
          cedula = controllerCedula.text;
          observacionModel = ObservacionModel(
              idDgoNovedadesElect: idNovedades, cedula: controllerCedula.text);
          break;

        case "DETENIDOS":
          cedula = controllerCedula.text;
          observacionModel = ObservacionModel(
              idDgoNovedadesElect: idNovedades,
              cedula: controllerCedula.text,
              numBoleta: controllerNumBoleta.text);
          break;

        case "CITACIONES":
          cedula = controllerCedula.text;
          observacionModel = ObservacionModel(
              idDgoNovedadesElect: idNovedades,
              cedula: controllerCedula.text,
              numCitacion: controllerNumCitacion.text);
          break;

        case "VOTO EN CASA":
          cedula = 'null';
          observacionModel = ObservacionModel(
              idDgoNovedadesElect: idNovedades,
              cedula: null,
              numCitacion: controllerObs.text);
          break;

        case "NOV PPL":
          cedula = 'null';
          observacionModel = ObservacionModel(
              idDgoNovedadesElect: idNovedades,
              cedula: null,
              numCitacion: controllerObs.text);
          break;

        default:
          observacion = "";
      }
    }
    return observacionModelToJson2(observacionModel);
  }

  ObservacionModel getObservacionNovedades() {
    ObservacionModel observacionModel =
        ObservacionModel(idDgoNovedadesElect: idNovedades);

    switch (int.parse(idNovedades)) {
      case 17:
        break;
      case 18:
        break;
      case 19:
        //3. RECINTO ELECTORAL INSTALADO CON RETARDO POR DIFERENTES CAUSAS
        observacionModel = ObservacionModel(
            idDgoNovedadesElect: idNovedades,
            hora: "${controllerHora.text}:${controllerMinuto.text}");

        break;
      case 20:
        //4. RECINTOS ELECTORALES SUSPENDIDO POR DIFERENTES CAUSAS

        observacionModel = ObservacionModel(
            idDgoNovedadesElect: idNovedades, motivo: controllerMotivo.text);

        break;
      case 21:
        //5. AGRESIONES A SERVIDORES POLICIALES

        observacionModel = ObservacionModel(
            idDgoNovedadesElect: idNovedades, cedula: controllerCedula.text);

        break;
      case 22:
        //6. PRESENCIA DE MANIFESTANTES / CONCENTRACIONES / MARCHAS

        observacionModel = ObservacionModel(
            idDgoNovedadesElect: idNovedades,
            organizacion: controllerOrganizacion.text,
            dirigente: controllerDirigente.text,
            cantidad: controllerCantidad.text);
        break;
      case 23:
        //7. QUEMA DE URNAS / PAPELETAS

        observacionModel = ObservacionModel(
            idDgoNovedadesElect: idNovedades,
            organizacion: controllerOrganizacion.text,
            dirigente: controllerDirigente.text,
            cantidad: controllerCantidad.text);

        break;
      case 28:
        //8. TOMA DE RECINTOS / DELEGACIONES / BODEGAS / INSTALACIONES DEL CNE

        observacionModel = ObservacionModel(
            idDgoNovedadesElect: idNovedades,
            organizacion: controllerOrganizacion.text,
            dirigente: controllerDirigente.text,
            cantidad: controllerCantidad.text);

        break;
      case 29:
        //9. PRESENCIA DE VENTAS AMBULANTES

        break;
      case 30:
        //10. ATENCIÓN MÉDICA POR DIFERENTES CAUSAS

        observacionModel = ObservacionModel(
          idDgoNovedadesElect: idNovedades,
          cedula: controllerCedula.text,
          telefono: controllerTelefono.text,
        );
        break;
      case 31:
        //11. SERVIDORES POLICIALES INFECTADOS (SOSPECHA/POSITIVO)

        observacionModel = ObservacionModel(
          idDgoNovedadesElect: idNovedades,
          cedula: controllerCedula.text,
        );

        break;

      case 32:
        observacionModel = ObservacionModel(
          idDgoNovedadesElect: idNovedades,
          numerico: controllerNumerico.text,
        );

        break;

      /******************************** UMO ******************************************/
      case 33:
        //1. NUMERICO DE PERSONAL

        observacionModel = ObservacionModel(
          idDgoNovedadesElect: idNovedades,
          cantidad: controllerNumericoPersonal.text,
        );

        break;
      case 34:
        //2. PLANTONES

        observacionModel = ObservacionModel(
            idDgoNovedadesElect: idNovedades,
            organizacion: controllerOrganizacion.text,
            dirigente: controllerDirigente.text,
            cantidad: controllerCantidad.text);

        break;
      case 35:
        //3. MARCHAS
        observacionModel = ObservacionModel(
            idDgoNovedadesElect: idNovedades,
            organizacion: controllerOrganizacion.text,
            dirigente: controllerDirigente.text,
            cantidad: controllerCantidad.text);

        break;

      case 36:
        //4. CIERRE DE VIAS
        observacionModel = ObservacionModel(
            idDgoNovedadesElect: idNovedades,
            organizacion: controllerOrganizacion.text,
            dirigente: controllerDirigente.text,
            cantidad: controllerCantidad.text);

        break;

      case 37:
        //5. TOMA DE ENTIDADES
        observacionModel = ObservacionModel(
            idDgoNovedadesElect: idNovedades,
            organizacion: controllerOrganizacion.text,
            dirigente: controllerDirigente.text,
            cantidad: controllerCantidad.text);

        break;

      /******************************** AEROPOLICIAL ******************************************/
      case 45:
        //1. DESPLAZAMIENTO DE AUTORIDADES

        observacionModel = ObservacionModel(
            idDgoNovedadesElect: idNovedades,
            nombre: controllerNombre.text,
            cargo: controllerCargo.text,
            grado: controllerGrado.text);

        break;
      case 46:
        //2. DESPLAZAMIENTO DE SERVIDORES PÚBLICOS

        observacionModel = ObservacionModel(
            idDgoNovedadesElect: idNovedades,
            nombre: controllerNombre.text,
            cargo: controllerCargo.text,
            grado: controllerGrado.text);

        break;
      case 47:
        //3. APOYO AÉREO A MEDIOS DE COMUNICACIÓN

        observacionModel = ObservacionModel(
          idDgoNovedadesElect: idNovedades,
          nombre: controllerNombre.text,
          medioComunicacion: controllerMedioComunicacion.text,
        );

        break;

      case 48:
        //4. TRASLADO DE RECURSOS LOGÍSTICOS

        break;

      /******************************** GOE - GIR ******************************************/

      case 41:
        //1. SEGURIDAD DE PERSONAS IMPORTANTES

        observacionModel = ObservacionModel(
          idDgoNovedadesElect: idNovedades,
          funcion: controllerFuncion.text,
          nombre: controllerNombre.text,
        );

        break;
      case 42:
        //2. SEGURIDAD DE INSTALACIONES

        observacionModel = ObservacionModel(
          idDgoNovedadesElect: idNovedades,
          instalacion: controllerInstalacion.text,
          descripcion: controllerDescripcion.text,
        );

        break;
      case 43:
        //3. REGISTRO DE EXPLOSIVOS

        observacionModel = ObservacionModel(
          idDgoNovedadesElect: idNovedades,
          direccion: controllerDireccion.text,
          descripcion: controllerDescripcion.text,
        );

        break;

      case 44:
        //4. APOYO A UNIDADES POLICIALES

        observacionModel = ObservacionModel(
          idDgoNovedadesElect: idNovedades,
          unidad: controllerUnidad.text,
        );
        break;

      /******************************** UMO - CRACK- UER ******************************************/

      case 49:
        observacionModel = ObservacionModel(
          idDgoNovedadesElect: idNovedades,
          numerico: controllerNumerico.text,
        );
        break;

      case 50:
        observacionModel = ObservacionModel(
          idDgoNovedadesElect: idNovedades,
          numerico: controllerNumerico.text,
        );
        break;
      case 51:
        observacionModel = ObservacionModel(
          idDgoNovedadesElect: idNovedades,
          numerico: controllerNumerico.text,
        );
        break;
      case 52:
        observacionModel = ObservacionModel(
          idDgoNovedadesElect: idNovedades,
          numerico: controllerNumerico.text,
        );
        break;
      case 54:
        observacionModel = ObservacionModel(
            idDgoNovedadesElect: idNovedades,
            hora: "${controllerHora.text}:${controllerMinuto.text}");

        break;

      case 55:
        observacionModel = ObservacionModel(
            idDgoNovedadesElect: idNovedades,
            hora: "${controllerHora.text}:${controllerMinuto.text}");

        break;

      default:
    }

    return observacionModel;
  }

  Widget getComboHora(ResponsiveUtil responsive) {
    List<String> datos = new List();

    for (int i = 0; i < 24; i++) {
      if (i < 10) {
        datos.add("0" + i.toString());
      } else {
        datos.add(i.toString());
      }
    }

    return Container(
        padding: EdgeInsets.symmetric(horizontal: paddingContenido),
        child: ComboConBusqueda(
          selectValue: controllerHora.text,
          title: "Hora",
          searchHint: 'Seleccione la Hora',
          datos: datos,
          complete: (dato) {
            setState(() {
              controllerHora.text = dato;
            });
          },
        ));
  }

  Widget getComboMinuto(ResponsiveUtil responsive) {
    List<String> datos = new List();

    for (int i = 0; i < 60; i++) {
      if (i < 10) {
        datos.add("0" + i.toString());
      } else {
        datos.add(i.toString());
      }
    }

    return Container(
        padding: EdgeInsets.symmetric(horizontal: paddingContenido),
        child: ComboConBusqueda(
          selectValue: controllerMinuto.text,
          title: "Minuto",
          searchHint: 'Minuto',
          datos: datos,
          complete: (dato) {
            setState(() {
              controllerMinuto.text = dato;
            });
          },
        ));
  }

  Widget getComboNovedadesPadres(ResponsiveUtil responsive) {
    List<String> datos = getDatos(_listNovedadesPadres);

    return _listNovedadesPadres.length > 0
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: paddingContenido),
            child: ComboConBusqueda(
              selectValue: novedadesPadres,
              title: VariablesUtil.tipoNovedad,
              searchHint: 'Seleccione el ' + VariablesUtil.tipoNovedad,
              datos: datos,
              complete: (dato) {
                selectPadre = true;
                setState(() {
                  wgCajaTextosHijas = Container();
                  novedadesPadres = dato;

                  novedadesHijas = null;
                  idNovedades = "0";
                  controllerCedula.text = "";
                  controllerNumCitacion.text = "";
                  controllerNumBoleta.text = "";
                  _datosPers.idGenPersona = "0";
                  _listNovedadesHijas = [];

                  if (novedadesPadres != null) {
                    wgCajaTextos = wgCajasTexto(novedadesPadres, responsive);
                    if (_listNovedadesHijas.length > 0) {
                      novedadesHijas = _listNovedadesHijas[0].descripcion;

                      idNovedades = "0";
                      idNovedades = _listNovedadesHijas[0].idDgoNovedadesElect;
                    }

                    int idNovedadPadre =
                        getIdNovedades(novedadesPadres, _listNovedadesPadres);
                    _getNovedadesHijas(idNovedadPadre);
                  }
                });
              },
            ))
        : Container(
            child: DetalleTextWidget(
              detalle: "No exiten tipos de Novedades",
            ),
          );
  }

  Widget getComboNovedadesHijos(ResponsiveUtil responsive) {
    if (_listNovedadesHijas.length == 0) {
      return Container();
    }

    List<String> datos = getDatos(_listNovedadesHijas);

    Widget wg = _listNovedadesHijas.length > 0
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: paddingContenido),
            child: ComboConBusqueda(
              selectValue: novedadesHijas,
              title: VariablesUtil.novedad,
              searchHint: 'Seleccione la ' + VariablesUtil.novedad,
              datos: datos,
              complete: (dato) {
                selectPadre = false;
                setState(() {
                  novedadesHijas = dato;
                  idNovedades = "0";
                  controllerCedula.text = "";
                  controllerNumCitacion.text = "";
                  controllerNumBoleta.text = "";
                  _datosPers.idGenPersona = "0";
                  if (novedadesHijas != null) {
                    idNovedades =
                        getIdNovedades(novedadesHijas, _listNovedadesHijas)
                            .toString();

                    if (novedadesPadres == "NOVEDADES") {
                      wgCajaTextosHijas = wgCajasTextoNovedades(
                          int.parse(idNovedades), responsive);
                    }

                    _getNovedadesNietos(int.parse(idNovedades));

                    print("cambia");
                  }
                });
              },
            ))
        : Container(
            child: DetalleTextWidget(
              detalle: "No exiten Novedades",
            ),
          );

    return wg;
  }

  Widget getComboNovedadesNietos(ResponsiveUtil responsive) {
    if (_listNovedadesNietos.length == 0) {
      return Container();
    }

    List<String> datos = getDatos(_listNovedadesNietos);

    Widget wg = _listNovedadesNietos.length > 0
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: paddingContenido),
            child: ComboConBusqueda(
              selectValue: novedadesNietos,
              title: "Delito",
              searchHint: 'Seleccione la ' + VariablesUtil.novedad,
              datos: datos,
              complete: (dato) {
                selectPadre = false;
                setState(() {
                  novedadesNietos = dato;
                  idNovedades = "0";
                  if (novedadesHijas != null) {
                    idNovedades =
                        getIdNovedades(novedadesNietos, _listNovedadesNietos)
                            .toString();

                    if (novedadesPadres == "NOVEDADES") {
                      wgCajaTextosHijas = wgCajasTextoNovedades(
                          int.parse(idNovedades), responsive);
                    }

                    print("cambia");
                  }
                });
              },
            ))
        : Container(
            child: DetalleTextWidget(
              detalle: "No exiten Novedades",
            ),
          );

    return wg;
  }

  _getNovedadesPadres() async {
    if (!cargaInicial) return;

    if (peticionServer) return;

    setState(() {
      peticionServer = true;
    });

    _listNovedadesPadres = await _novedadesElectoralesApi.getNovedadesPadres(
        context: context,
        idDgoTipoEje: _RecintoProvider.getRecintoAbierto.idDgoTipoEje);

    if (_listNovedadesHijas.length > 0) {
      novedadesHijas = _listNovedadesHijas[0].descripcion;
    }

    setState(() {
      peticionServer = false;
      cargaInicial = false;
    });
  }

  Widget wgFoto(ResponsiveUtil responsive) {
    Widget wgSolicitarFoto = Column(
      children: [
        mGaleryCameraModel.image == null
            ? TituloTextWidget(
                title: "Registre una Imagen",
              )
            : TituloTextWidget(
                title: "Cambiar la Imagen",
              ),
        SizedBox(
          height: responsive.altoP(1),
        ),
        Material(
            child: InkWell(
          onTap: () {
            //  getImageCamera();
            ////////api 30 error galeria
            DialogosAwesome.getCamaraGallery(
              title: "Registre Foto",
              context: context,
              descripcion: "Seleccione una Imagen o Tome una Fotografía",
              responsive: responsive,
              btnOkOnPress: () {
                getImageCamera();
                Navigator.of(context).pop();
              },
              btnCancelOnPress: () {
                getImageGallery();
                Navigator.of(context).pop();
              },
            );
            /*   DialogosWidget.selectPicture(context, onTapCamara: () {
              getImageCamera();
              Navigator.of(context).pop();
            }, onTapGalery: () {
              getImageGallery();
              Navigator.of(context).pop();
            });*/
          },
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(AppConfig.icon_camara,
                  width: responsive.altoP(6.0)),
            ),
          ),
        )),
        mGaleryCameraModel.image == null
            ? Container()
            : ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Image.file(
                  mGaleryCameraModel.image,
                  fit: BoxFit.fill,
                  height: responsive.altoP(30.0),
                  width: responsive.altoP(34.0),
                )),
        SizedBox(
          height: responsive.altoP(1),
        ),
      ],
    );

    Widget wg = wgSolicitarFoto;

    return ContenedorDesingWidget(
        margin: EdgeInsets.only(top: 10),
        anchoPorce: anchoContenedor,
        child: wg);
  }

  Future getImageGallery() async {
    try {
      setState(() {
        peticionServer = true;
      });

      GaleryCameraModel _mGaleryCameraModel =
          await UtilidadesUtil.getImageGallery(
              "ImgRecElectNovedades_id_" + idNovedades);

      if (_mGaleryCameraModel.image != null) {
        setState(() {
          this.mGaleryCameraModel = _mGaleryCameraModel;
        });
      }
      setState(() {
        peticionServer = false;
      });
    } catch (e) {
      setState(() {
        peticionServer = false;
      });
    }
  }

  Future getImageCamera() async {
    try {
      setState(() {
        peticionServer = true;
      });

      GaleryCameraModel _mGaleryCameraModel =
          await UtilidadesUtil.getImageCamera(
              "ImgRecElectNovedades_id_" + idNovedades);

      if (_mGaleryCameraModel.image != null) {
        setState(() {
          this.mGaleryCameraModel = _mGaleryCameraModel;
        });
      }

      setState(() {
        peticionServer = false;
      });
    } catch (e) {
      setState(() {
        peticionServer = false;
      });
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
              novedadesPadres != null
                  ? getComboNovedadesHijos(responsive)
                  : Container(),
              novedadesHijas != null
                  ? getComboNovedadesNietos(responsive)
                  : Container(),
            ],
          ),
        ));
  }

  _getNovedadesHijas(int idNovedadPadre) async {
    if (idNovedadPadre == 0) return;

    if (peticionServer) return;
    setState(() {
      peticionServer = true;
    });
    _listNovedadesHijas = await _novedadesElectoralesApi.getNovedadesHijas(
        context: context,
        idNovedadesPadre: idNovedadPadre.toString(),
        idDgoTipoEje: _RecintoProvider.getRecintoAbierto.idDgoTipoEje);

    setState(() {
      peticionServer = false;
    });
  }

  _consultarDatosPersonaPorDocumento(
      {@required String cedula, @required String usuario}) async {
    try {
      bool isValid = true;
      if (validarForm) {
        isValid = _formKey.currentState.validate();
      }
      print("unoooo");

      if (!isValid) {
        return;
      }
      print("dosososososos");

      if (peticionServer) return;
      print("treessssss");
      setState(() {
        peticionServer = true;
      });

      _datosPers = await _genPersonaApi.getDatosPersona(
          context: context, usuario: usuario, cedula: cedula);
      print("0===============0" + tipoNovedadComboPadre);
      //Con esto obligo a que se actualize el wg
      final responsive = ResponsiveUtil(context);
      if (tipoNovedadComboPadre == "21" || tipoNovedadComboPadre == "30") {
        wgCajaTextosHijas =
            wgCajasTextoNovedades(int.parse(tipoNovedadComboPadre), responsive);
      } else {
        //aqui voy a a redibujar el widget segun la oopcion de novedades
        wgCajaTextos = wgCajasTexto(tipoNovedadComboPadre, responsive);
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

  _getNovedadesNietos(int idNovedadPadre) async {
    if (idNovedadPadre == 0) return;

    if (peticionServer) return;
    setState(() {
      peticionServer = true;
    });
    _listNovedadesNietos = await _novedadesElectoralesApi.getNovedadesHijas(
        isNieto: true,
        context: context,
        idNovedadesPadre: idNovedadPadre.toString(),
        idDgoTipoEje: _RecintoProvider.getRecintoAbierto.idDgoTipoEje);
    if (_listNovedadesNietos.length > 0) {
      novedadesNietos = _listNovedadesNietos[0].descripcion;
      idNovedades = _listNovedadesNietos[0].idDgoNovedadesElect;
      mostrarGuardar = false;
    }

    setState(() {
      peticionServer = false;
    });
  }

  _RegistrarNovedades(
      {@required String idDgoNovedadesElect,
      @required String idDgoPerAsigOpe,
      @required String observacion,
      @required String usuario,
      @required String nombreDetenido = "null",
      @required String idGenPersonaD = "null",
      String imagen = "null"}) async {
    try {
      if (idDgoPerAsigOpe == 0) return;

      if (peticionServer) return;
      setState(() {
        peticionServer = true;
      });

      String latitud =
          _UserProvider.getUser.ubicacionSeleccionada.latitude.toString();
      String longitud =
          _UserProvider.getUser.ubicacionSeleccionada.longitude.toString();

      await _novedadesElectoralesApi.registrarNovedadesElectorales(
          context: context,
          idDgoPerAsigOpe: idDgoPerAsigOpe,
          usuario: usuario,
          idDgoNovedadesElect: idDgoNovedadesElect,
          observacion: observacion,
          idGenPersonaD: idGenPersonaD,
          nombreDetenido: nombreDetenido,
          imagen: imagen,
          latitud: latitud,
          longitud: longitud,
          cedula: cedula,
          idDgoProcElec: _RecintoProvider.getRecintoAbierto.idDgoProcElec);

      setState(() {
        peticionServer = false;
      });
    } catch (e) {
      setState(() {
        peticionServer = false;
      });
    }
  }

  Future<bool> guardarImgRecElectNovedades(
      {GaleryCameraModel galeryCameraModel}) async {
    try {
      setState(() {
        peticionServer = true;
      });
      bool resImg = await _novedadesElectoralesApi.guardarImgRecElectNovedades(
          context: context,
          image: galeryCameraModel.image,
          nameImg: galeryCameraModel.nombreImg);
      setState(() {
        peticionServer = false;
      });
      return resImg;
    } catch (e) {
      setState(() {
        peticionServer = false;
      });
    }
  }

  Widget getBtnColores({ResponsiveUtil responsive, String title, Color color}) {
    return Container(
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black),
      ),
      width: responsive.anchoP(20),
      height: responsive.altoP(2),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppConfig.radioBordecajas),
          boxShadow: [
            BoxShadow(
                color: AppConfig.colorBordecajas,
                blurRadius: AppConfig.sobraBordecajas)
          ]),
    );
  }
}

class WgCambiarFecha extends StatefulWidget {
  final String fecha;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onSelectedDate;

  const WgCambiarFecha(
      {Key key, this.fecha, this.selectedDate, this.onSelectedDate})
      : super(key: key);

  @override
  _WgCambiarFechaState createState() => _WgCambiarFechaState();
}

class _WgCambiarFechaState extends State<WgCambiarFecha> {
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          SizedBox(
            height: responsive.altoP(1),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TituloDetalleTextWidget(
                title: "Fecha y hora:",
                mostrarBorder: true,
                detalle: widget.fecha,
              ),
              BtnIconWidget(
                paddinHorizontal: 80.0,
                iconData: Icons.date_range,
                title: "Cambiar",
                colorTextoIcon: Colors.white,
                color: Colors.blue.withOpacity(0.70),
                onTap: () {
                  showDialogoFechaHoraWidget(context,
                      mostrarHora: true,
                      initialDate: widget.selectedDate,
                      onSelectedDate: widget.onSelectedDate);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
