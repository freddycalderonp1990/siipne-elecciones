import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as Geolocator;
import 'package:latlong/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:siipnemovil2/helpers/helpers.dart';
import 'package:siipnemovil2/utils/utils.dart';
import 'package:siipnemovil2/widgets/customWidgets.dart';

import '../appConfig.dart';

class myGps extends StatefulWidget {
  final Widget pantalla;
  final bool cerrarTodasPantallas;
  final String msj;
  final bool isElecciones;

  const myGps(
      {Key key,
      this.msj = '',
      this.isElecciones,
      this.pantalla,
      this.cerrarTodasPantallas = false})
      : super(key: key);

  @override
  _myGpsState createState() => _myGpsState();

  //distancia en metros
  static Future<double> getDistancia(LatLng punto1, LatLng punto2) async {
    //se procede a calcular la distancia de las coordenadas
    double distanceInMeters = await Geolocator.distanceBetween(
        punto1.latitude, punto1.longitude, punto2.latitude, punto2.longitude);
    return distanceInMeters;
  }
}

class _myGpsState extends State<myGps> {
  @override
  Widget build(BuildContext context) {
    return LoadingPage(
      isElecciones: widget.isElecciones,
      msj: widget.msj,
      pantalla: widget.pantalla,
      cerrarTodasPantallas: widget.cerrarTodasPantallas,
    );
  }
}

//en esta pantalla se encarga de escuchar cualdo el usaurio activa el gps y
//redireccionarlo a al pantalla que necesite usar gps

// se encarga de verificar y redireccionar segun los permisos a la pantalla que le corresponde
class LoadingPage extends StatefulWidget {
  final Widget pantalla;

  final bool cerrarTodasPantallas;
  final String msj;
  final bool isElecciones;

  const LoadingPage(
      {Key key,
      this.msj = "",
      this.isElecciones = true,
      this.pantalla,
      this.cerrarTodasPantallas = false})
      : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

// WidgetsBindingObserver para saber el estado de la aplicacion
// AppLifecycleState.inactive  = inactiva,
// AppLifecycleState.paused = pausa, (cuando se meustra un dialogo o se minimiza la app)
// AppLifecycleState.resumed = activa

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {
  //CONFIGURACIONES
  final anchoContenedor = AppConfig.anchoContenedor;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (await Geolocator.isLocationServiceEnabled()) {
        if (widget.cerrarTodasPantallas) {
          UtilidadesUtil.pantallasAbrirNuevaCerrarTodasWidget(
              context: context,
              pantalla: navegarMapaFadeIn(context, widget.pantalla));
        } else {
          Navigator.pushReplacement(
              context, navegarMapaFadeIn(context, widget.pantalla));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil(context);

    return WorkAreaPageWidget(

      btnAtras: false,
      title: "GPS",
      contenido: [
        FutureBuilder(
          future: this.checkGpsYLocation(context),
          //al cargar la pantalla se procede a verificar el acceso al gps
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //captura la data que retorna el metodo checkGpsYLocation

            if (snapshot.hasData) {
              if (snapshot.data == '0') {
                String msj = "";

                if (widget.msj.length > 0) {
                  msj = widget.msj;
                }

                msj = msj +
                    'La aplicación necesita acceder a tu ubicación para:\n\n'
                        'Verificar los operativos abiertos cercanos a tu ubicación.\n'
                        'Mostrarte los Recintos Electorales o Unidades Policiales según la ubicación donde te encuentres.\n'
                        'Visualizar las UPC que se encuentren próximas a tu ubicación.\n\n'
                        'Por favor active el GPS para continuar.';

                return ContenedorDesingWidget(
                    margin: EdgeInsets.all(10),
                    anchoPorce: anchoContenedor,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            msj,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: responsive.anchoP(5)),
                          ),
                          Image.asset(
                            AppConfig.imgLocationAccess,
                            height: responsive.altoP(40),
                          ),
                          SizedBox(
                            height: responsive.altoP(4),
                          ),
                          BotonesWidget(
                            iconData: Icons.check,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            title: "CONTINUAR...",
                            onPressed: () async {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      ),
                    ));
              } else {
                return ContenedorDesingWidget(
                    margin: EdgeInsets.all(10),
                    anchoPorce: anchoContenedor,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        snapshot.data,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: responsive.anchoP(5)),
                      ),
                    ));
              }
            } else {
              return Center(child: CircularProgressIndicator(strokeWidth: 2));
            }
          },
        )
      ],
    );
  }

  Future checkGpsYLocation(BuildContext context) async {
    // PermisoGPS verifica si el usuario ya dio permisos
    final permisoGPS = await Permission.location.isGranted;
    // GPS está activo verifica si el gps del dispositivo se encuentra activo
    final gpsActivo = await Geolocator.isLocationServiceEnabled();

    if (permisoGPS && gpsActivo) {
      //se reemplaza la pantalla con una nueva
      //se carga la pantalla de mapas

      if (widget.cerrarTodasPantallas) {
        UtilidadesUtil.pantallasAbrirNuevaCerrarTodasWidget(
            context: context,
            pantalla: navegarMapaFadeIn(context, widget.pantalla));
      } else {
        Navigator.pushReplacement(
            context, navegarMapaFadeIn(context, widget.pantalla));
      }
      return '';
    } else if (!permisoGPS) {
      //se reemplaza la pantalla con una nueva
      //se carga para los permisos

      if (widget.cerrarTodasPantallas) {
        UtilidadesUtil.pantallasAbrirNuevaCerrarTodasWidget(
            context: context,
            pantalla: navegarMapaFadeIn(context, widget.pantalla));
      } else {
        Navigator.pushReplacement(
            context,
            navegarMapaFadeIn(
                context,
                AccesoGpsPage(
                  isElecciones: widget.isElecciones,
                  msj: widget.msj,
                  pantalla: widget.pantalla,
                  cerrarTodasPantallas: widget.cerrarTodasPantallas,
                )));
      }
      String msj = "";

      if (widget.msj.length > 0) {
        msj = widget.msj;
      }

      msj = msj +
          'La aplicación necesita acceder a tu ubicación para:\n\n'
              'Verificar los operativos abiertos cercanos a tu ubicación.\n'
              'Mostrarte los Recintos Electorales o Unidades Policiales según la ubicación donde te encuentres.\n'
              'Visualizar las UPC que se encuentren próximas a tu ubicación.\n';

      return msj;
    } else {
      //0 = Necesitamos acceder a su ubicación por favor active el GPS para continuar.
      return '0';
    }
  }
}

class AccesoGpsPage extends StatefulWidget {
  final Widget pantalla;

  final bool cerrarTodasPantallas;
  final String msj;
  final bool isElecciones;

  const AccesoGpsPage({
    Key key,
    this.msj = "",
    this.isElecciones = true,
    this.pantalla,
    this.cerrarTodasPantallas = false,
  }) : super(key: key);

  @override
  _AccesoGpsPageState createState() => _AccesoGpsPageState();
}

// WidgetsBindingObserver para saber el estado de la aplicacion
// AppLifecycleState.inactive  = inactiva,
// AppLifecycleState.paused = pausa, (cuando se meustra un dialogo o se minimiza la app)
// AppLifecycleState.resumed = activa

class _AccesoGpsPageState extends State<AccesoGpsPage>
    with WidgetsBindingObserver {
  //CONFIGURACIONES
  final anchoContenedor = AppConfig.anchoContenedor;

  //cuando se muestra por el boton el popup de los permisos
  bool popup = false;

  @override
  void initState() {
    //esta pendiente del estado del gps
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    //remueve pendiente del estado del gps
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    //AppLifecycleState.resumed la aplicacion esta activa
    if (state == AppLifecycleState.resumed && !popup) {
      //si tenemos acceso vamos al login
      if (await Permission.location.isGranted) {
        //Navigator.pushReplacementNamed(context, 'loading');
        //como el usuario ya le dio permisos de manera manual se redirige al loading

        if (widget.cerrarTodasPantallas) {
          UtilidadesUtil.pantallasAbrirNuevaCerrarTodasWidget(
              context: context,
              pantalla: navegarMapaFadeIn(context, widget.pantalla));
        } else {
          Navigator.pushReplacement(
              context,
              navegarMapaFadeIn(
                  context,
                  LoadingPage(
                    pantalla: widget.pantalla,
                  )));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil(context);

    String msj = "";

    if (widget.msj.length > 0) {
      msj = widget.msj;
      print("siiiiii");
    }

    return WorkAreaPageWidget(
      btnAtras: false,
      title: "GPS",
      contenido: [
        ContenedorDesingWidget(
            margin: EdgeInsets.all(5),
            anchoPorce: anchoContenedor,
            child: Container(
              margin: EdgeInsets.all(5),
              child: Column(
                children: [
                  DetalleTextWidget(
                    todoElAncho: true,
                    detalle: msj,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TituloTextWidget(
                    textAlign: TextAlign.center,
                    title:
                        "La aplicación necesita acceder a tu ubicación para:",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  widget.isElecciones ? getWdMsjElecciones() : getWdMsjMiUpc(),
                  Image.asset(
                    AppConfig.imgLocationAccess,
                    height: responsive.diagonalP(15),
                  ),
                  SizedBox(
                    height: responsive.altoP(4),
                  ),
                  BotonesWidget(
                    iconData: Icons.navigate_next,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    title: "Continuar",
                    onPressed: () async {
                      popup = true;
                      //Muestra al usuario la pantalla de los permisos
                      // regresa un status
                      final status = await Permission.location.request();

                      await this.accesoGPS(status);
                      popup = false;
                    },
                  )
                ],
              ),
            ))
      ],
    );
  }

  Widget getWdMsjElecciones() {
    return Column(
      children: [
        TituloDetalleTextWidget(
          title: "1)",
          detalle: "Verificar los operativos abiertos cercanos a tu ubicación.",
        ),
        TituloDetalleTextWidget(
          title: "2)",
          detalle:
              "Mostrar los Recintos Electorales o Unidades Policiales según la ubicación donde te encuentres.",
        ),
        TituloDetalleTextWidget(
          title: "3)",
          detalle:
              "Registrar Novedades y Eventos en el lugar donde ocurrieron..",
        ),
      ],
    );
  }

  Widget getWdMsjMiUpc() {
    return Column(
      children: [
        TituloDetalleTextWidget(
          title: "1)",
          detalle:
              "Visualizar las UPC que se encuentren próximas a tu ubicación.",
        ),
      ],
    );
  }

  Future accesoGPS(PermissionStatus status) async {
    print(status);

    switch (status) {
      case PermissionStatus.granted:
        //aceptado
        if (widget.cerrarTodasPantallas) {
          UtilidadesUtil.pantallasAbrirNuevaCerrarTodasWidget(
              context: context,
              pantalla: navegarMapaFadeIn(context, widget.pantalla));
        } else {
          await Navigator.pushReplacement(
              context, navegarMapaFadeIn(context, widget.pantalla));
        }
        break;

      case PermissionStatus.undetermined:
      //indeterminado

      case PermissionStatus.denied:
      //denegado

      case PermissionStatus.restricted:
      //restringida

      case PermissionStatus.permanentlyDenied:
        //permisos denegas por completo
        //Redirecciona al usuario para que de manuera manual asigne los permisos
        openAppSettings();
    }
  }
}
