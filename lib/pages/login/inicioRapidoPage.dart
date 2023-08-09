part of '../pages.dart';

class InicioRapidoPage extends StatefulWidget {
  @override
  _InicioRapidoPageState createState() => _InicioRapidoPageState();
}

class _InicioRapidoPageState extends State<InicioRapidoPage> {


  var peticionServer = false, validateFoto=true, tieneFoto=false;
  UserProvider _UserProvider;

  final prefs = new PreferenciasUsuario();
  final prefsSelectApp=new PreferenciasSelectApp();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    UtilidadesUtil.getTheme();
  }

  @override
  Widget build(BuildContext context) {

    final responsive = ResponsiveUtil(context);


    _UserProvider = UserProvider.of(context);


    WidgetsBinding.instance.addPostFrameCallback((_) {
      _validateTieneFoto(context);
    });
    Widget wg=WorkAreaPageWidget(


      mostrarVersion: true,

      imgFondo: AppConfig.imgFondoDefault,
      peticionServer: peticionServer,
      title: VariablesUtil.POLICIANACIONAL,
      sizeTittle: 7,
      contenido: <Widget>[
        tieneFoto? getContenido(responsive):Container()
      ],
    );

    return Stack(children: [
      wg,


    UtilidadesUtil.plataformaIsAndroid()?Container():   Container(

          child: Stack(children: [
            Positioned(
                left:responsive.isVertical()? responsive.altoP(1):responsive.anchoP(1),
                top: responsive.isVertical()? responsive.altoP(1):responsive.anchoP(2),
                child:  SafeArea(
                  child: CupertinoButton(
                    minSize: responsive.isVertical()?responsive.altoP(5):responsive.anchoP(5),
                    padding: EdgeInsets.all(3),
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.black26,
                    onPressed: (){
                      prefsSelectApp.setSelectSiipne(false);
                      prefsSelectApp.setSelecMiUpc(false);
                      UtilidadesUtil.pantallasAbrirNuevaCerrarTodas(
                          context: context, pantalla: AppConfig.pantallaBienvenida);
                    },//volver atras
                    child: Icon(Icons.arrow_back, color: Colors.white,size:responsive.isVertical()? responsive.altoP(3):responsive.anchoP(3),),
                  ),
                )
            )
          ],))
    ],);
  }
  Widget getContenido(ResponsiveUtil responsive ){
    return Column(children: [
      imgPerfilRedonda(size: 35,img: prefs.getFoto(),),
      SizedBox(height: responsive.altoP(2),),
      Container(
          decoration: BoxDecoration(
              borderRadius:
              BorderRadius.circular(AppConfig.radioBordecajas),
              boxShadow: [
                BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.9),
                    blurRadius: 10)
              ]),
          child:   Text(
            prefs.getNombre() ,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: responsive.anchoP(5)),
          ),),

      SizedBox(height: responsive.altoP(2),),
      wgHuella(responsive),
      SizedBox(height: responsive.altoP(1),),
      wgOtroUsuario(responsive)
    ],);
  }

  Widget wgHuella(ResponsiveUtil responsive) {
    bool verificaCredecniales = false;
    if (prefs.getUser().length > 0 && prefs.getPass().length > 0) {
      verificaCredecniales = true;
    }

    Widget wg =
         desingBtn(responsive,
        title: "INGRESO CON HUELLA",
        img: AppConfig.icon_huella, onTap: () async {

          bool result = await BiometricUtil.biometrico();
          if (result) {
            _EventoLogin(
                user: prefs.getUser(),
                pass: prefs.getPass(),
                );
          }
        })
        ;

    return wg;
  }

  Widget wgOtroUsuario(ResponsiveUtil responsive) {
    bool verificaCredecniales = false;
    if (prefs.getUser().length > 0 && prefs.getPass().length > 0) {
      verificaCredecniales = true;
    }

    Widget wg =
    desingBtn(responsive,
        title: "¿NO ERES TÚ?",
        img: AppConfig.icon_usuario, onTap: () async {
            DialogosWidget.alertSiNo(context,
                title: "Huella",
                message:
                "Por su seguridad el acceso por huella sera desactivado."
                    "\n\n¿Desea Continuar?",
                onTap: (){
                  prefs.setContadorFallido(0);
                  prefs.setConfigHuella(false);
                  prefs.setAppInicial(false);
                  prefs.clearDatosUser();
                  UtilidadesUtil.pantallasAbrirNuevaCerrarTodas(
                      context: context, pantalla: AppConfig.pantallaLogin);
                });

        })
    ;

    return wg;
  }

  Widget desingBtn(ResponsiveUtil responsive,
      {String title, String img, double ancho = 60, GestureTapCallback onTap}) {
    return BtnMenuWidget(
      img: img,
      titlte: title,
      horizontal: false,

      onTap: onTap,
      colorFondo: Colors.black26,
      colorTexto: Colors.white,
    );
  }

  _EventoLogin({String user, String pass}) async {
    // _UserProvider.setUser=new Usuario(apenom: 'Freddy Calderon Pazmiño',documento: '1206762401',nombreUsuario: 'nameUser',sexo: 'Masculino');

    try {
      var isValid = true;


      final _LoginApi = LoginApi();

      if (isValid) {

        if (peticionServer) return;
        setState(() {
          peticionServer = true;
        });

        final Usuario datosUser = await _LoginApi.getLogin(user, pass, context);

        setState(() {
          peticionServer = false;
        });

        if (int.parse(datosUser.idGenUsuario) > 0) {


          _UserProvider.setUser = datosUser;

          bool checkAccesoBiometrico =
          await BiometricUtil.checkAccesoBiometrico();
          bool verificaCredecniales = false;
          if (prefs.getUser().length > 0 && prefs.getPass().length > 0) {
            verificaCredecniales = true;
          }

          if (checkAccesoBiometrico) {
            InciarPantalla(datosUser.actualizarApp);
          }
        }
      }
    } catch (e) {
      setState(() {
        peticionServer = false;
      });
    }
  }


  void InciarPantalla(bool actualizarApp) {
    if (actualizarApp) {
      DialogosWidget.alert(context, title: "Actualizar App", onTap: () {
        Navigator.of(context).pop();

        if (UtilidadesUtil.plataformaIsAndroid()) {
          UtilidadesUtil.abrirUrl(AppConfig.linkAppAndroid);
        }
        else{
          UtilidadesUtil.abrirUrl(AppConfig.linkAppIos);
        }
      },
          message: "Nueva Versión Disponible"
              "\n\nPara continuar utilizando la aplicación es necesario que descargue la última versión."
              "\n\nSi tiene Problemas intente desinstalar y volver a instalarla.");
    } else {
      //No necesita comprobacion de gps
      /* UtilidadesUtil.pantallasAbrirNuevaCerrarTodas(
          context: context, pantalla: AppConfig.pantallaProcesosOperativos);*/
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  VerificarGpsPage(pantalla: VerificaOpertaivoRecintoAbiertoPage())));
      /*Navigator.pushReplacementNamed(
              context, AppConfig.pantallaMenuRecintoElectoral);*/
    }
  }

  _validateTieneFoto(BuildContext context){
   if(validateFoto) {
     if (!prefs.getImgValida()) {
       UtilidadesUtil.pantallasAbrirNuevaCerrarTodas(
           context: context, pantalla: AppConfig.pantallaLogin);
     }
     else{
       validateFoto=false;
       setState(() {
         tieneFoto=true;
       });
     }
   }
  }
}
