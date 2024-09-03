part of 'miUpcPages.dart';

class MiUpcAcuerdoConfiPage extends StatefulWidget {
  @override
  _MiUpcAcuerdoConfiPageState createState() => _MiUpcAcuerdoConfiPageState();
}

class _MiUpcAcuerdoConfiPageState extends State<MiUpcAcuerdoConfiPage> {
  bool chk = false;
  final prefsSelectApp = new PreferenciasSelectApp();
  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    final responsive = ResponsiveUtil(context);
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(MiUpcAppConfig.imgFondo),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Container(
                    child: Image.asset(MiUpcAppConfig.imgCabecera),
                    width: responsive.altoP(45),
                    color: Colors.transparent,
                  ),
                ),
                Container(
                  width: responsive.ancho,
                  height: responsive.altoP(85),
                  child: SingleChildScrollView(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
                      child: (Column(
                        children: <Widget>[
                          Text(
                            'ACUERDO DE CONFIDENCIALIDAD DE LA INFORMACIÓN \n',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                              'Está aplicación ha sido desarrollada para brindar información relacionada con la localización de UPC, generar Alertas y otros servicios importantes para seguridad ciudadana, con la finalidad de mejorar el servicio a la ciudadanía, en tal virtud para su uso el usuario debe de aceptar los siguientes términos y condiciones: \n',
                              textAlign: TextAlign.justify),
                          Text(
                              'La Información solicitada e ingresada en la aplicación es de carácter confidencial, reservada, y será utilizada con el propósito de mejorar el servicio a la ciudadanía a través de una herramienta con información real y segura.\n',
                              textAlign: TextAlign.justify),
                          Text(
                              'La Policía Nacional del Ecuador no se responsabiliza de los costos relacionados con la conectividad de datos de acceso a internet utilizados por la aplicación para su funcionalidad.\n',
                              textAlign: TextAlign.justify),
                          Text(
                              'La funcionalidad óptima de la aplicación dependerá de las características técnicas mínimas que debe cumplir el teléfono celular para su funcionamiento, señal de internet, empresa proveedora y ancho de banda al momento de la utilización de la aplicación.\n\nEsta aplicación ha sido desarrollada por la Policía Nacional del Ecuador, queda prohibida su reproducción y modificación parcial o total.\n',
                              textAlign: TextAlign.justify),
                          Text(
                              'Las ALERTAS GENERADAS en el Aplicativo son únicamente INFORMÁTIVAS, no son DENUNCIAS.\n',
                              textAlign: TextAlign.justify),
                          Text(
                            'Las Alertas Generadas en el Aplicativo se desactivarán luego de 24 horas de su publicación.\n',
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                              'La violación de cualquiera de estos términos y condiciones, así como el mal uso del aplicativo tendrá como resultado el bloqueo de la aplicación y la sanción respectiva de acuerdo con la Normativa Legal vigente. Siendo el único responsable el USUARIO REGISTRADO en la aplicación.\n\n',
                              textAlign: TextAlign.justify),
                          Text(
                              'En el artículo 396, numeral 3 del COIP dispone la sanción a la persona que de manera indebida realice uso del número único de atención de emergencias para dar un aviso falso de emergencia y que implique desplazamiento, movilización o activación innecesaria de recursos de las instituciones de emergencia.\n',
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Divider(
                            color: MiUpcAppConfig.colorBarras,
                          ),
                          Row(
                            children: <Widget>[
                              Checkbox(
                                value: chk,
                                onChanged: (check) {
                                  setState(() {
                                    chk = !chk;
                                  });
                                },
                              ),
                              Container(
                                //width: responsive.anchoP(80),
                                child: Text(
                                  'Aceptar Términos y Condiciones',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: _btnRegistrar(chk),
                          ),
                          Divider(
                            color: MiUpcAppConfig.colorBarras,
                          ),
                        ],
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              left: responsive.isVertical()
                  ? responsive.altoP(1)
                  : responsive.anchoP(1),
              top: responsive.isVertical()
                  ? responsive.altoP(1)
                  : responsive.anchoP(2),
              child: SafeArea(
                child: CupertinoButton(
                  minSize: responsive.isVertical()
                      ? responsive.altoP(5)
                      : responsive.anchoP(5),
                  padding: EdgeInsets.all(3),
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blue,
                  onPressed: () {
                    prefsSelectApp.setSelectSiipne(false);
                    prefsSelectApp.setSelecMiUpc(false);
                    UtilidadesUtil.pantallasAbrirNuevaCerrarTodas(
                        context: context,
                        pantalla: AppConfig.pantallaBienvenida);
                  },
                  //volver atras
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: responsive.isVertical()
                        ? responsive.altoP(3)
                        : responsive.anchoP(3),
                  ),
                ),
              )),
        ],
      ),
    ));
  }

  void ingresar(bool c) async {
    if (c == true) {
      // Navigator.of(context).pop();
      /*Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));*/

      Navigator.pushReplacementNamed(context, MiUpcAppConfig.LoginPage);
    } else {
      alertas(context);
    }
  }

  Widget alertas(BuildContext context) {
    MiUpcDialogosWidget.alertasV(
        txt:
            'PARA CONTINUAR DEBE ACEPTAR LOS TÉRMINOS Y CONDICIONES DE USO DEL APLICATIVO.',
        context: context);
  }

  Widget _btnRegistrar(chk) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: Column(
        children: [
          TextButton(
            onPressed: () => _checkGps(chk),
            child: Text(
              'Siguiente',
              style: TextStyle(
                color: MiUpcAppConfig.colorBarras,
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
          TextButton(
            onPressed: () => registroUsuModFalse(),
            child: Text(
              'No Registrarme',
              style: TextStyle(
                color: MiUpcAppConfig.colorBarras,
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
          )
        ],
      ),
    );
  }

  registroUsuModFalse() async {
    final prefs = new MiUpcPreferenciasUsuario();

    if (prefs.getnombreUsuarioMiUpc().length > 4) {
      print("ssisisisisisi");
      Navigator.pushReplacementNamed(context, MiUpcAppConfig.menuPrincipalPage);
      return;
    }

    String json =
        '{"datoPer":["Correcto","JAIRO POZO CANACUAN","10000","146270"],"code":"0"}';

    RegistroUsuarioModel registroUsuarioModel =
        registroUsuarioModelFromJson(json);

    List<String> datosRegistro = registroUsuarioModel.datoPer;

    String nombres = datosRegistro[1].toString();

    String id = datosRegistro[2].toString();
    String idGenPersona = datosRegistro[3].toString();

    prefs.setDatosUser(
        idGenPersonaMiUpc: idGenPersona,
        nombreUser: "",
        cedulaMiUpcV: "",
        emailMiUpcV: "",
        nombresMiUpcV: "",
        celularMiUpc: "",
        idUsuarioMiUpc: id,
        imeiMiUpc: "",
        isnacionalMiUpc: true);

    Navigator.pushReplacementNamed(context, MiUpcAppConfig.menuPrincipalPage);
  }

  Future _checkGps(bool c) async {
    Navigator.pushReplacementNamed(context, MiUpcAppConfig.LoginPage);

    /*Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                VerificarGpsPage(pantalla: MiUpcLoginPage())));*/
  }
}
