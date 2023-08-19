part of 'miUpcPages.dart';

class MiUpcSplashPage extends StatefulWidget {
  @override
  _MiUpcSplashPageState createState() => _MiUpcSplashPageState();
}

class _MiUpcSplashPageState extends State<MiUpcSplashPage> {
  bool existeDatos = false;
  String estadoConex = "";
  Geolocator geolocator = Geolocator();
  final prefs = new MiUpcPreferenciasUsuario();
  int timeSplas = 4;
  bool dibujar = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vericaServicio();
    //_getLocation();

    verificaTConexion();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil(context);
    return Stack(
      children: <Widget>[
        Container(
          height: responsive.altoP(100),
          width: responsive.anchoP(100),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(MiUpcAppConfig.imgInicial),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
            child: Loading(
          radius: 15.0,
          dotRadius: 6.0,
        )),
      ],
    );
  }

  _getLocation() async {
    Position position;
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      if (position == null) {
      } else {
        setState(() {
          MiUpcConstApi.latitud = position.latitude.toString();
          MiUpcConstApi.longitud = position.longitude.toString();
        });
      }
    } catch (e) {}
  }

  verificaTConexion() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        estadoConex = 'S';
        print('connected');
        print(result[0].rawAddress);

        if (prefs.getidGenPersonaMiUpc() != '0' && prefs.getimeiMiUpc() != '') {
          existeDatos = true;
        }

        if (!existeDatos) {
          //SystemChrome.setEnabledSystemUIOverlays([]);
          print("acuerdo");
          Future.delayed(Duration(seconds: 1)).then((_) {
            Navigator.pushReplacementNamed(
                context, MiUpcAppConfig.acuerdoConfiPage);
          });
        } else {
          //SystemChrome.setEnabledSystemUIOverlays([]);
          print("menumiupc");
          Future.delayed(Duration(seconds: 1)).then((_) {
            Navigator.pushReplacementNamed(
                context, MiUpcAppConfig.menuPrincipalPage);
          });
        }
      }
    } on SocketException catch (_) {
      estadoConex = 'N';
      print('NOOOO connected');
      DialogosWidget.alert(context,
          onTap: () {},
          message:
              "No Existe Conexión a Internet, asegurese de estar conectado a una red wifi o plan de datos");
    }
  }

  vericaServicio() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      print("Connected to Mobile Network");
      estadoConex = 'S';
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print("Connected to WiFi");
      estadoConex = 'S';
    } else {
      estadoConex = 'N';
      print("Unable to connect. Please Check Internet Connection");
    }
  }
}
