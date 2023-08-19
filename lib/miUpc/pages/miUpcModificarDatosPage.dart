part of 'miUpcPages.dart';

class MiUpcModificarDatosPage extends StatefulWidget {
  @override
  _MiUpcModificarDatosPageState createState() => _MiUpcModificarDatosPageState();
}

class _MiUpcModificarDatosPageState extends State<MiUpcModificarDatosPage> {

  final prefs = new MiUpcPreferenciasUsuario();



  bool cargarDatos = true;

  //variable para que solo carge una vez los datos
  bool peticionServer = false;
  TextEditingController _controller;
  bool chk = false;
  bool chk1 = false;
  
  String contactoOld='';
  String correoOld='';

  TelephonyInfo _info;

  String nombresExt = '';
  bool isExtranjero = false;
  bool visibilityObs = false;
  String tConexion = 'MOVIL';
  String modeloCelular = '';
  String SSID = 'MOVIL';
  String tUsu = 'NACIONAL';
  String latitud = '';
  String longitud = '';
  String estadoConex = 'N';
  int selectNacionalidad = 1;
  Geolocator geolocator = Geolocator();
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();


  final _formKey = GlobalKey<FormState>();
  var controllerCedula = new TextEditingController();
  var controllerContacto = new TextEditingController();
  var controllerCorreo = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
    getTelephonyInfo();

    _getLocation();
    initConnectivity();
    verificaTConexion();
    initPlatformDevice();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    setDatos();
  }



  @override
  void dispose() {
    // TODO: implement dispose
    _connectivitySubscription.cancel();
    _controller.dispose();
    controllerCedula.dispose();
    controllerContacto.dispose();
    controllerCorreo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil(context);
    return Scaffold(
      body: SafeArea(child: Stack(
        children: <Widget>[
          Container(
            width: responsive.anchoP(100),
            height: responsive.altoP(100),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(MiUpcAppConfig.imgFondo),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child:Form(
              key: _formKey,
              child:  Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      child: Image.asset(MiUpcAppConfig.imgCabecera),
                      width: responsive.isVertical()
                          ? responsive.altoP(45)
                          : responsive.anchoP(50),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: <Widget>[
                        Divider(
                          color: MiUpcAppConfig.colorBarras,
                        ),
                        Divider(
                          height: 5.0,
                          color: Colors.transparent,
                        ),
                        Text(
                          'LA POLICÍA NACIONAL DEL ECUADOR',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                              color: MiUpcAppConfig.colorBarras),
                        ),
                        Divider(
                          height: 5.0,
                          color: Colors.transparent,
                        ),
                        Text(
                          'Le da la más Cordial Bienvenida a su aplicativo\n' +
                              MiUpcAppConfig.appName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 17,
                              color: Colors.black),
                        ),
                        Divider(
                          height: 5.0,
                          color: Colors.transparent,
                        ),
                        Text(
                          'INSTRUCCIONES',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 21,
                              color: Colors.black),
                        ),
                        Divider(
                          height: 5.0,
                          color: Colors.transparent,
                        ),
                        Text(
                          'Favor registre los siguientes datos para continuar.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        Divider(
                          height: 10.0,
                          color: Colors.transparent,
                        ),
                        /* Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Radio(
                            focusColor: Colors.black,
                            value: 1,
                            groupValue: selectNacionalidad,
                            onChanged: vizualizar,
                          ),
                          new Text(
                            'Nacional',
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          new Radio(
                            focusColor: Colors.black,
                            value: 2,
                            groupValue: selectNacionalidad,
                            onChanged: vizualizar,
                          ),
                          new Text(
                            'Extranjero',
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),*/
                        Divider(
                          height: 20.0,
                          color: Colors.transparent,
                        ),
                        _TxtCedula(responsive),
                        getCampos(responsive)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          CargandoWidget(mostrar: peticionServer),

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

                    UtilidadesUtil.pantallasAbrirNuevaCerrarTodas(
                        context: context,
                        pantalla: MiUpcAppConfig.menuPrincipalPage);






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
      ),),
    );
  }

  void ingresar(String nom, String ced, String cel) async {

    String _ip = await  UtilidadesUtil.getIp();
    MiUpcAuditoriaApi auditoria = new MiUpcAuditoriaApi();
    auditoria.grabaAccion(MiUpcConstApi.latitud, MiUpcConstApi.longitud, 'CAMBIO DE USUARIO',
        'NOMBRES:'+nom+'|DOCUEMNTO:'+ced+'|CELULAR:'+cel+'|MAIL:'+controllerCorreo.text, prefs.getidUsuarioMiUpc(), _ip, context);

    MiUpcDialogosWidget.alertaRegistro(
        context: context, nombre: nom, cedula: ced, celular: cel,onPressed:() {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.pushReplacementNamed(context, MiUpcAppConfig.menuPrincipalPage);

    });
  }

  Widget getCampos(ResponsiveUtil responsive) {
    return Column(
      children: [
        Divider(
          height: 20.0,
          color: Colors.transparent,
        ),


        _TxtCelular(responsive),
        Divider(
          height: 20.0,
          color: Colors.transparent,
        ),
        _TxtMail(responsive),
        Divider(
          height: 20.0,
          color: Colors.transparent,
        ),
        Column(
          children: <Widget>[
            _btnRegistrar(),
          ],
        ),
      ],
    );
  }


  Widget _TxtCelular(ResponsiveUtil res) {
    return Container(
      height: 68.0,
      child: TextFormField(
        controller: controllerContacto,
        validator: (String text) {
          if (text.length >= 5) {
            controllerContacto.text = text;
            return null;
          }
          return 'Contacto no valido';
        },
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            icon: Icon(
              Icons.contact_phone,
              color: Colors.blue,
            ),
            border: OutlineInputBorder(),
            labelText: 'Número de Contacto',
            hintText: 'Número de Contacto',
            suffixStyle: TextStyle(color: Colors.green)),
        maxLines: 1,
      ),
    );
  }

  Widget _TxtMail(ResponsiveUtil res) {
    return Container(
      height: 68.0,
      child: TextFormField(
        controller: controllerCorreo,
        validator: (String text) {
          if (text.length >= 5) {
            controllerCorreo.text = text;

            bool emailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(controllerCorreo.text);
            if (emailValid) {
              return null;
            } else {
              return 'Email no valido';
            }
          }
          return 'Email no valido';
        },
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
            icon: Icon(
              Icons.email,
              color: Colors.blue,
            ),
            border: OutlineInputBorder(),
            labelText: 'Email de Contacto',
            hintText: 'Email de Contacto',
            suffixStyle: TextStyle(color: Colors.green)),
        maxLines: 1,
      ),
    );
  }

  vizualizar(int valueRadio) {
    print(valueRadio);
    if (valueRadio == 1) {
      tUsu = 'NACIONAL';
      _changed(false, "tag");
    } else {
      _changed(true, "tag");
      tUsu = 'EXTRANJERO';
    }
    print(tUsu);
    setState(() {
      selectNacionalidad = valueRadio;
    });
  }

  Widget _btnRegistrar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: TextButton(

        onPressed: () => registroUsu(context),

        child: isExtranjero
            ? Text(
          'DONE',
          style: TextStyle(
            color: MiUpcAppConfig.colorBarras,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        )
            : Text(
          'MODIFICAR DATOS',
          style: TextStyle(
            color: MiUpcAppConfig.colorBarras,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }



  Widget _TxtCedula(ResponsiveUtil res) {


    return Container(
      height: 68.0,
      child: TextFormField(
        enabled: false,
        onChanged: (String text) {
          if (text.length >= 1 && text.length == 10) {
            controllerCedula.text = text;

          }
        },
        maxLength: 10,
        controller: controllerCedula,
        validator: (String text) {
          if (text.length >= 1 && text.length == 10) {
            controllerCedula.text = text;
            return null;
          }
          return 'Número de cédula no valido';
        },
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            icon: Icon(Icons.payment, color: Colors.blue),
            border: OutlineInputBorder(),
            labelText: 'Cédula',
            hintText: 'Ingrese su número de cédula',
            suffixStyle: TextStyle(color: Colors.green)),
        maxLines: 1,
      ),
    );
  }







  _getLocation() async {
    setState(() {
      peticionServer = true;
    });

    Position position;
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      setState(() {
        peticionServer = false;
      });

      if (position == null) {} else {
        setState(() {
          latitud = position.latitude.toString();
          longitud = position.longitude.toString();
        });
      }
    } catch (e) {}
  }

  registroUsu(BuildContext ctx) async {

    final isValid = _formKey.currentState.validate();
    if(isValid) {
      verificaTConexion();

      if(contactoOld!=controllerContacto.text || correoOld!=controllerCorreo.text) {
        if (estadoConex == 'S') {
          peticionServer = false;
          if (peticionServer) {
            return;
          }
          setState(() {
            peticionServer = true;
          });
          MiUpcActualizaUsuarioApi actualizaUsuarioApi = new MiUpcActualizaUsuarioApi();
          ActualizaUsuarioModel actualizaUsuarioModel;
          String datos;

          datos = tUsu +
              "|" +
              controllerCedula.text +
              "|" +
              controllerCorreo.text +
              "|" +
              controllerContacto.text +
              "|" +
              prefs.getidUsuarioMiUpc().toString() +
              "|" + nombresExt;


          print('datossssssssssssss');
          print(datos);
          actualizaUsuarioModel =
          await actualizaUsuarioApi.realizaActualizaUsuario(
              ctx, datos);
          setState(() {
            peticionServer = false;
          });

          if (actualizaUsuarioModel.code) {
            String datosRegistro = actualizaUsuarioModel.msj;
            if (datosRegistro.toString() == 'ACTUALIZADO') {
              setState(() {
                print(datosRegistro);
                String nombres = actualizaUsuarioModel.nombre;
                String id = actualizaUsuarioModel.id;

                print("nombres------------" + nombres);
                print("iddddd------------" + id);
                // se prosede a guardar los datos del usuario en las preferencia
                prefs.setDatosUser(
                    idGenPersonaMiUpc: actualizaUsuarioModel.idGenPersona,
                    nombreUser: nombresExt,
                    cedulaMiUpcV: controllerCedula.text,
                    emailMiUpcV: controllerCorreo.text,
                    nombresMiUpcV: nombres,
                    celularMiUpc: controllerContacto.text,
                    idUsuarioMiUpc: id,
                     imeiMiUpc: prefs.getimeiMiUpc(),
                    isnacionalMiUpc: selectNacionalidad == 1 ? true : false);

                //   DialogosWidget.alertasModificar(
                //     txt: actualizaUsuarioModel.msj.toString(), context: ctx);
                ingresar(
                    nombres, controllerCedula.text, controllerContacto.text);
              });
            } else {
              MiUpcDialogosWidget.alertasV(
                  txt: actualizaUsuarioModel.msj.toString(), context: ctx);
              peticionServer = false;
            }
          } else {
            MiUpcDialogosWidget.alertasV(
                txt: actualizaUsuarioModel.msj.toString(), context: ctx);
            peticionServer = false;
          }
        } else {
          MiUpcDialogosWidget.alertasV(
              context: context, txt: "No Existe Conexión con el Server");

        }
      }
      else{
        MiUpcDialogosWidget.alertasV(
            context: context, txt: "No ha modificado ningun dato.");


      }
    }
  }

  verificaTConexion() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        estadoConex = 'S';
        print('------------------------connected');
      }
    }  catch (e) {
      MiUpcDialogosWidget.alertasV(
          context: context,
          txt:
          "No Existe Conexión a Internet, asegurese de estar conectado a una red wifi o plan de datos");
      estadoConex = 'N';
      // Navigator.of(context).pop();
    }
  }

  Future<void> getTelephonyInfo() async {
    TelephonyInfo info;
    try {
      info = await FltTelephonyInfo.info;
    } catch (e) {}

    if (!mounted) return;

    setState(() {
      _info = info;
      print('Phone 1: ${_info?.simCarrierIdName}\n');
    });
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        String wifiName, wifiBSSID, wifiIP;

        try {
          if (Platform.isIOS) {
            LocationAuthorizationStatus status =
            await _connectivity.getLocationServiceAuthorization();
            if (status == LocationAuthorizationStatus.notDetermined) {
              status =
              await _connectivity.requestLocationServiceAuthorization();
            }
            if (status == LocationAuthorizationStatus.authorizedAlways ||
                status == LocationAuthorizationStatus.authorizedWhenInUse) {
              wifiName = await _connectivity.getWifiName();
            } else {
              wifiName = await _connectivity.getWifiName();
            }
          } else {
            wifiName = await _connectivity.getWifiName();
          }
        } catch (e) {
          print(e.toString());
          wifiName = "Failed to get Wifi Name";
        }

        try {
          if (Platform.isIOS) {
            LocationAuthorizationStatus status =
            await _connectivity.getLocationServiceAuthorization();
            if (status == LocationAuthorizationStatus.notDetermined) {
              status =
              await _connectivity.requestLocationServiceAuthorization();
            }
            if (status == LocationAuthorizationStatus.authorizedAlways ||
                status == LocationAuthorizationStatus.authorizedWhenInUse) {
              wifiBSSID = await _connectivity.getWifiBSSID();
            } else {
              wifiBSSID = await _connectivity.getWifiBSSID();
            }
          } else {
            wifiBSSID = await _connectivity.getWifiBSSID();
          }
        } catch (e) {
          print(e.toString());
          wifiBSSID = "Failed to get Wifi BSSID";
        }

        try {
          wifiIP = await _connectivity.getWifiIP();
        } catch (e) {
          print(e.toString());
          wifiIP = "Failed to get Wifi IP";
        }

        setState(() {
          _connectionStatus = '$result\n'
              'Wifi Name: $wifiName\n'
              'Wifi BSSID: $wifiBSSID\n'
              'Wifi IP: $wifiIP\n';
          print(_connectionStatus);
          tConexion = "WIFI";
          SSID = '$wifiName';
        });
        break;
      case ConnectivityResult.mobile:
        tConexion = "MOVIL";
        SSID = 'INTERNET-${_info?.simCarrierIdName}';
        break;
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } catch (e) {
      print(e.toString());
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> initPlatformDevice() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        print('Running on ${androidInfo.model}');
        print('Running on ${androidInfo.manufacturer}');
        modeloCelular = '${androidInfo.manufacturer}-${androidInfo.model}';
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        print('Running on ${iosInfo.utsname.machine}');
        modeloCelular =
        '${iosInfo.utsname.machine}-${iosInfo.utsname.version}}';
      }
    } catch (e) {
      print('Error: Failed to get platform version.');
    }
  }



  void _changed(bool visibility, String field) {
    setState(() {
      if (field == "tag") {
        isExtranjero = visibility;
      }
      if (field == "obs") {
        visibilityObs = visibility;
      }
    });
  }
  setDatos() {
    setState(() {
      
      
      
      controllerCedula.text = prefs.getcedulaMiUpc();
      controllerContacto.text = prefs.getcelularMiUpc();
      controllerCorreo.text = prefs.getemailMiUpc();
      
      contactoOld=controllerContacto.text;
      correoOld=controllerCorreo.text;

      prefs.getIsnacionalMiUpc() ? selectNacionalidad = 1 : selectNacionalidad = 2;

      nombresExt=prefs.getnombresMiUpc();
      isExtranjero=!prefs.getIsnacionalMiUpc();

    }
    );  }
}


