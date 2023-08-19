part of 'miUpcPages.dart';

class MiUpcLoginPage extends StatefulWidget {
  static bool peticionServer;

  @override
  _MiUpcLoginPageState createState() => _MiUpcLoginPageState();
}

class _MiUpcLoginPageState extends State<MiUpcLoginPage> {
  final prefs = new MiUpcPreferenciasUsuario();
  bool cedulaLista = false;
  String _ip;
  String imeiCell = '';

  bool cargarDatos = true;
  final myControllerCedula = TextEditingController();
  final myControllerCedulaText = TextEditingController();
  final myControllerBoton = TextEditingController();
  bool segundoNombre = false;

  //variable para que solo carge una vez los datos
  bool peticionServer = false;
  TextEditingController _controller;
  bool chk = false;
  bool chk1 = false;

  TelephonyInfo _info;

  String nombresExt = '';
  bool visibilityTag = false;
  bool visibilityObs = false;
  String tConexion = 'MOVIL';
  String modeloCelular = '';
  String SSID = 'MOVIL';
  String tipoUsuario = 'NACIONAL';
  String latitud = '';
  String longitud = '';
  String estadoConex = 'N';
  int selectNacionalidad = 1;
  Geolocator geolocator = Geolocator();
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  final formKeyNacional = GlobalKey<FormState>();
  final formKeyExtra = GlobalKey<FormState>();

  var controllerPrimerNombre = new TextEditingController();
  var controllerPrimerNombre2 = new TextEditingController();
  var controllerApellido1 = new TextEditingController();
  var controllerApellido2 = new TextEditingController();
  var controllerCedula = new TextEditingController();
  var controllerContacto = new TextEditingController();
  var controllerCorreo = new TextEditingController();

  var controllerPrimerNombreExt = new TextEditingController();
  var controllerPrimerNombre2Ext = new TextEditingController();
  var controllerApellido1Ext = new TextEditingController();
  var controllerApellido2Ext = new TextEditingController();
  var controllerCedulaExt = new TextEditingController();
  var controllerContactoExt = new TextEditingController();
  var controllerCorreoExt = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
    //getTelephonyInfo();
    //getImei();
    //_getLocation();
    //initConnectivity();
    //verificaTConexion();
    //initPlatformDevice();
    getIp();

    /*_connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);*/
  }

  Future<void> getImei() async {
    String platformImei;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformImei = await UtilidadesUtil.getMac();
    } on Exception catch (_) {
      platformImei = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      imeiCell = platformImei;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _connectivitySubscription.cancel();
    _controller.dispose();
    myControllerCedula.dispose();
    myControllerCedulaText.dispose();
    myControllerBoton.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Container(
                    child: Image.asset(MiUpcAppConfig.imgCabecera),
                    width: responsive.altoP(45),
                    color: Colors.transparent,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
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
                              //getCombo(),
                              selectNacionalidad == 1
                                  ? getContenidonacional(responsive)
                                  : Text('Mantenimiento'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
      ),
    );
  }

  void ingresar(String nom, String ced, String cel) async {
    //Navigator.of(context).pop();
    MiUpcDialogosWidget.alertaRegistro(
        context: context,
        nombre: nom,
        cedula: ced,
        celular: cel,
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.pushReplacementNamed(
              context, MiUpcAppConfig.menuPrincipalPage);
        });
  }

  Widget getContenidonacional(ResponsiveUtil responsive) {
    return Form(
        key: formKeyNacional,
        child: Column(
          children: [
            Divider(
              height: 20.0,
              color: Colors.transparent,
            ),
            _TxtCedula(responsive),
            cedulaLista ? getCampos(responsive) : Container()
          ],
        ));
  }

  Widget getCombo() {
    return Row(
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
    );
  }

  Widget getCampos(ResponsiveUtil responsive) {
    return Column(
      children: [
        Divider(
          height: 20.0,
          color: Colors.transparent,
        ),
        _TxtPrimerNombre(responsive),
        Divider(
          height: 5.0,
          color: Colors.transparent,
        ),
        segundoNombre ? _TxtPrimerNombre2(responsive) : Container(),
        Divider(
          height: 5.0,
          color: Colors.transparent,
        ),
        Text(
          'Ingrese sus Apellidos',
          style: kLabelStyle,
        ),
        Divider(
          height: 15.0,
          color: Colors.transparent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _TxtPrimerApellido1(responsive),
            _TxtPrimerApellido2(responsive)
          ],
        ),
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

  vizualizar(int valueRadio) {
    print(valueRadio);
    if (valueRadio == 1) {
      tipoUsuario = 'NACIONAL';
      _changed(false, "tag");
    } else {
      _changed(true, "tag");
      tipoUsuario = 'EXTRANJERO';
    }
    print(tipoUsuario);
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
        child: visibilityTag
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
                'REGISTRARSE',
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

  Widget myTextFormField(
      {ValueChanged<String> onChanged,
      int maxLength = 0,
      TextEditingController controller,
      FormFieldValidator<String> validator,
      TextInputType keyboardType,
      String labelText,
      String hintText,
      IconData iconData}) {
    Widget wg = Container(
      height: 68.0,
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            icon: Icon(iconData, color: Colors.blue),
            border: OutlineInputBorder(),
            labelText: labelText,
            hintText: hintText,
            suffixStyle: TextStyle(color: Colors.green)),
        maxLines: 1,
      ),
    );

    if (maxLength > 0) {
      wg = Container(
        height: 68.0,
        child: TextFormField(
          onChanged: onChanged,
          maxLength: maxLength,
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          decoration: InputDecoration(
              icon: Icon(iconData, color: Colors.blue),
              border: OutlineInputBorder(),
              labelText: labelText,
              hintText: hintText,
              suffixStyle: TextStyle(color: Colors.green)),
          maxLines: 1,
        ),
      );
    }

    return widget;
  }

  Widget _TxtCedula(ResponsiveUtil res) {
    return Container(
      height: 68.0,
      child: TextFormField(
        onChanged: (String text) {
          if (text.length >= 1 && text.length == 10) {
            controllerCedula.text = text;
            setState(() {
              cedulaLista = true;
            });
          } else {
            setState(() {
              cedulaLista = false;
            });
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

  Widget _TxtPrimerNombre(ResponsiveUtil res) {
    return Container(
      height: 65.0,
      child: TextFormField(
        controller: controllerPrimerNombre,
        validator: (String text) {
          if (text.length >= 3) {
            controllerPrimerNombre.text = text;
            return null;
          }
          return 'Ingrese su Nombre';
        },
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Primer Nombre',
            hintText: 'Ingrese su primer nombre',
            suffixStyle: TextStyle(color: Colors.green)),
        maxLines: 1,
      ),
    );
  }

  Widget _TxtPrimerNombre2(ResponsiveUtil res) {
    return Container(
      height: 65.0,
      child: TextFormField(
        controller: controllerPrimerNombre2,
        validator: (String text) {
          if (!segundoNombre) {
            return null;
          } else {
            if (text.length >= 3) {
              controllerPrimerNombre2.text = text;
              return null;
            }
            return 'Ingrese su Segundo Nombre';
          }
        },
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Segundo Nombre',
            hintText: 'Ingrese su segundo nombre',
            suffixStyle: TextStyle(color: Colors.green)),
        maxLines: 1,
      ),
    );
  }

  Widget _TxtPrimerApellido1(ResponsiveUtil res) {
    return Container(
      width: res.anchoP(42),
      height: 65.0,
      child: TextFormField(
        controller: controllerApellido1,
        validator: (String text) {
          if (text.length >= 3) {
            controllerApellido1.text = text;
            return null;
          }
          return 'Apellido 1 no valido';
        },
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Apellido 1',
            hintText: 'Apellido 1',
            suffixStyle: TextStyle(color: Colors.green)),
        maxLines: 1,
      ),
    );
  }

  Widget _TxtPrimerApellido2(ResponsiveUtil res) {
    return Container(
      width: res.anchoP(42),
      height: 65.0,
      child: TextFormField(
        controller: controllerApellido2,
        validator: (String text) {
          if (text.length >= 3) {
            controllerApellido2.text = text;
            return null;
          }
          return 'Apellido 2 no valido';
        },
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Apellido 2',
            hintText: 'Apellido 2',
            suffixStyle: TextStyle(color: Colors.green)),
        maxLines: 1,
      ),
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

  Map<String, String> setDatos() => {
        MiUpcConstApi.varOpn: MiUpcConstApi.REGISTRARUSERMIUPC,
        MiUpcConstApi.varOpcion: "detalle",
        "tipoUser": tipoUsuario,
        "nombreUser": nombresExt,
        "correo": controllerCorreo.text,
        MiUpcConstApi.varLatitud: latitud,
        MiUpcConstApi.varLongitud: longitud,
        "tipoConexion": tConexion,
        "ssIDConexion": SSID,
        "contacto": controllerContacto.text,
        "imei": imeiCell,
        "modeloCelular": modeloCelular,
        "ip": _ip,
        "filtro": MiUpcConstApi.filtroMiUPC,
        "cedula": controllerCedula.text,
        "primerNombre": controllerPrimerNombre.text,
        "segundoNombre": controllerPrimerNombre2.text,
        "validarSegundoNombre": segundoNombre.toString(),
        "primerApellido": controllerApellido1.text,
        "segundoApellido": controllerApellido2.text,
      };

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

      if (position == null) {
      } else {
        setState(() {
          latitud = position.latitude.toString();
          longitud = position.longitude.toString();
        });
      }
    } catch (e) {}
  }

  //

  registroUsu(BuildContext ctx) async {
    final isValid = formKeyNacional.currentState.validate();

    if (isValid) {
      verificaTConexion();
      if (estadoConex == 'S') {
        peticionServer = false;
        if (peticionServer) {
          return;
        }
        setState(() {
          peticionServer = true;
        });
        MiUpcRegistroUsuarioApi registroUsuarioApi =
            new MiUpcRegistroUsuarioApi();
        RegistroUsuarioModel registroUsuarioModel;

        Map<String, String> datosJson = setDatos();

        registroUsuarioModel =
            await registroUsuarioApi.registrarUsuarioMiUpc(ctx, datosJson);
        setState(() {
          peticionServer = false;
        });

        if (registroUsuarioModel.datoPer != null) {
          List<String> datosRegistro = registroUsuarioModel.datoPer;
          if (datosRegistro[0].toString() == 'Correcto') {
            setState(() {
              print(datosRegistro);

              String nombres = datosRegistro[1].toString();
              String id = datosRegistro[2].toString();
              String idGenPersona = datosRegistro[3].toString();

              if (nombres == null) nombres = nombresExt;
              print("aaaaaaa");

              print(nombres);

              // se prosede a guardar los datos del usuario en las preferencias
              prefs.setDatosUser(
                  idGenPersonaMiUpc: idGenPersona,
                  nombreUser: nombres,
                  cedulaMiUpcV: controllerCedula.text,
                  emailMiUpcV: controllerCorreo.text,
                  nombresMiUpcV: nombres,
                  celularMiUpc: controllerContacto.text,
                  idUsuarioMiUpc: id,
                  imeiMiUpc: imeiCell,
                  isnacionalMiUpc: selectNacionalidad == 1 ? true : false);

              if (prefs.getnombreUsuarioMiUpc().length > 4) {
                print("ssisisisisisi");
              }

              ingresar(nombres, controllerCedula.text, controllerContacto.text);
            });
          } else {
            print('dao');
            print(registroUsuarioModel.code);
            if (registroUsuarioModel.code == '1') {
              setState(() {
                segundoNombre = true;
              });
            }

            MiUpcDialogosWidget.alertasV(
                txt: datosRegistro[1].toString(), context: ctx);
            final prefs = new MiUpcPreferenciasUsuario();

            MiUpcAuditoriaApi auditoria = new MiUpcAuditoriaApi();
            auditoria.grabaAccion(
                MiUpcConstApi.latitud,
                MiUpcConstApi.longitud,
                'REGISTRO',
                'USUARIO-' +
                    MiUpcConstApi.nombre +
                    'CEDULA-' +
                    controllerCedula.text +
                    'CELULAR-' +
                    controllerContacto.text,
                prefs.getidUsuarioMiUpc(),
                _ip,
                context);
            peticionServer = false;
          }
        } else {
          MiUpcDialogosWidget.alertasV(
              context: ctx,
              txt:
                  "Verifique que los Campos Cédula, Celular y Mail se encuentren con datos");
          peticionServer = false;
        }
      } else {
        MiUpcDialogosWidget.alertasV(
            context: context, txt: "No Existe Conexión con el Server");
        peticionServer = false;
      }
    }
  }

  verificaTConexion() async {
    estadoConex = 'S';
  }

  Future<void> getTelephonyInfo() async {
    TelephonyInfo info;
    try {
      //info = await FltTelephonyInfo.info;
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

  Future<void> getIp() async {
    _ip = await UtilidadesUtil.getIp();
  }

  void _changed(bool visibility, String field) {
    setState(() {
      if (field == "tag") {
        visibilityTag = visibility;
      }
      if (field == "obs") {
        visibilityObs = visibility;
      }
    });
  }
}
