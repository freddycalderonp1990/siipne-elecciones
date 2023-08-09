import 'package:flutter/material.dart';
import 'package:siipnemovil2/miUpc/pages/miUpcPages.dart';

class MiUpcAppConfig {

  static Map<String, WidgetBuilder> getRoutes(BuildContext context) {
    Map<String, WidgetBuilder> routes = {
      splashPage: (context) => MiUpcSplashPage(),
      acuerdoConfiPage: (context) => MiUpcAcuerdoConfiPage(),
      LoginPage: (context) => MiUpcLoginPage(),
      menuPrincipalPage: (context) => MiUpcMenuPrincipalPage(),
      mapaUpcPage: (context) => MiUpcMapaUpcPage(),
      listaViolenciaPage: (context) => MiUpcListaViolenciaPage(),
      listaTipsCovidPage: (context) => MiUpcListaTipsCovidPage(),
      listaServiciosPolcoPage: (context) => MiUpcListaServiciosPolcoPage(),
      listaMedidasAutoproteccionPage: (context) =>MiUpcListaMedidasAutoproteccionPage(),
      ListaNoticiasPage: (context) => MiUpcListaNoticiasPage(),
      ModificarDatosPage: (context) => MiUpcModificarDatosPage(),





    };

    return routes;
  }

  static const String appName = 'MI UPC';

  //++++++++++++++++++ IMAGENES +++++++++++++++++++++
  static const rutaImg = "assets/miUpc/img/";

  static const imgInicial = MiUpcAppConfig.rutaImg + "inicial.jpg";

  static const imgTelefono = MiUpcAppConfig.rutaImg + "telefono.png";

  static const imgLinea = MiUpcAppConfig.rutaImg + "linea.png";

  static const img1800 = MiUpcAppConfig.rutaImg + "1800.png";
  static const imgCabecera = MiUpcAppConfig.rutaImg + "cabecera.png";
  static const imgCabecera2 = MiUpcAppConfig.rutaImg + "cabecera2.png";
  static const imgTitulo = MiUpcAppConfig.rutaImg + "cabecera2.png";
  static const imgSirena = MiUpcAppConfig.rutaImg + "sirena.gif";
  static const imgFondo = MiUpcAppConfig.rutaImg + "fondo.png";
  static const imgSplash = MiUpcAppConfig.rutaImg + "splash.png";
  static const imgCamara = MiUpcAppConfig.rutaImg + "camara.png";
  static const imgGuardar = MiUpcAppConfig.rutaImg + "guardar.png";
  static const imgVisto = MiUpcAppConfig.rutaImg + "visto.png";
  static const imgPaquitoCovid = MiUpcAppConfig.rutaImg + "paquitocovid.png";
  static const imgEscpolicia = MiUpcAppConfig.rutaImg + "escpolicia.png";
  static const imgMarker_upc = MiUpcAppConfig.rutaImg + "marker_upc.png";
  static const imgMarker_persona = MiUpcAppConfig.rutaImg + "marker_persona.png";
  static const imgCabecera_menu_principal = MiUpcAppConfig.rutaImg + "cabecera_menu_principal.png";
  static const imgUpc_edificio = MiUpcAppConfig.rutaImg + "upc_edificio.png";
  static const imgFacebook = MiUpcAppConfig.rutaImg + "facebook.png";
  static const imgYoutube = MiUpcAppConfig.rutaImg + "youtube.png";
  static const imgTwitter = MiUpcAppConfig.rutaImg + "twitter.png";
  static const imgInstagran = MiUpcAppConfig.rutaImg + "instagran.png";

  static const imgFlechaDerecha = MiUpcAppConfig.rutaImg + "flecha_derecha.png";
  static const imgEcu911 = MiUpcAppConfig.rutaImg + "ecu911.png";
  static const imgCovid = MiUpcAppConfig.rutaImg + "covid.jpg";
  static const imgVineta = MiUpcAppConfig.rutaImg + "vineta.png";
  static const imgPaquito = MiUpcAppConfig.rutaImg + "paquito.png";
  static const imgInformate = MiUpcAppConfig.rutaImg + "informate.png";
  static const imgMis_notificaciones = MiUpcAppConfig.rutaImg + "mis_notificaciones.png";
  static const imgIcon_app = MiUpcAppConfig.rutaImg + "icon_app.png";
  static const imgAtras = MiUpcAppConfig.rutaImg + "ic_atras.png";
  static const imgRuta = MiUpcAppConfig.rutaImg + "ruta.png";
  static const imgRegistrardesaparecido = MiUpcAppConfig.rutaImg + "registrardesaparecido.png";
  static const imgShared = MiUpcAppConfig.rutaImg + "shared.png";


  static const String num911 ='911';




  static const String splashPage = 'splashPage';
  static const String acuerdoConfiPage = 'AcuerdoConfiPage';
  static const String LoginPage = 'LoginPage';
  static const String ModificarDatosPage = 'ModificarDatosPage';
  static const String menuPrincipalPage = 'menuPrincipalPage';
  static const String encuentraUpcPage = 'encuentraUpcPage';
  static const String opcionesUpcPage = 'opcionesUpcPage';
  static const String CovidMenuPage = 'CovidMenuPage';
  static const String listaTipsCovidPage = 'ListaTipsCovidPage';
  static const String FormularioAlertaMascotas ='FormularioAlertaMascotas';
  static const String FormularioAlertaVehiculos ='FormularioAlertaVehiculos';
  static const String FormularioAlertaDesaparecidos='FormularioAlertaDesaparecidos';
  static const String FormularioAlertaViolencia='FormularioAlertaViolencia';
  static const String NotificacionVehiculoPage = 'NotificacionVehiculoPage';
  static const String ListaNoticiasPage = 'ListaNoticiasPage';
  static const String PantallaPruebas = 'Pruebas';
  static const String PantallaPruebasInicio = 'PruebasInicio';
  static const String PantallaManualUsuario = 'ManualUsuarioMiUpc';
  static const String pruebas = 'pruebas';


  static const String ListaNotificacionesMascotasPage = 'ListaNotificacionesMascotasPage';
  static const String ListaNotificacionesVehiculosPage = 'ListaNotificacionesVehiculosPage';
  static const String ListaNotificacionesDesaparecidosPage = 'ListaNotificacionesDesaparecidosPage';


  static const String encuestaCovidPage = 'encuestaCovidPage';
  static const String resultadoCovidPage = 'resultadoCovidPage';
  static const String listaServiciosPolcoPage = 'ListaServiciosPolcoPage';
  static const String listaMedidasAutoproteccionPage = 'listaMedidasAutoproteccionPage';
  static const String listaViolenciaPage = 'listaViolenciaPage';
  static const String mapaUpcPage = 'MapaUpcPage';

  static const Color colorMarcadorMiUbicacion= Colors.red;
  static const double sizeMarcadorMiUbicacion= 38.0;
  static const IconData iconMarcadorMiUbicacion=Icons.person_pin_circle;



  static const String PhotoPreviewScreen ='PhotoPreviewScreen';

//tipos de notificaciones
  static const String notificacionDesaparecidos ='Desaparecidos';
  static const String notificacionMascaotas ='Mascotas';
  static const String notificacionVehiculo ='Vehiculo';


  static const String notificacionOnMessage ='onMessage';
  static const String notificacionOnLaunch ='onLaunch';
  static const String notificacionOnResume ='onResume';



  static const String insertaAlertaMascotas = 'insertaAlertaMascotas';
  static const String OpcionesAlertaDesaparecidos ='OpcionesAlertaDesaparecidos';
  static const String insertaAlertaPersonaExtraviadaPage ='insertaAlertaPersonaExtraviadaPage';
  static const String webPersonaExtraviadaPage = 'webPersonaExtraviadaPage';
  static const String OpcionesAlertaVehiculosPage ='OpcionesAlertaVehiculosPage';
  static const String insertaAlertaVehiculosPage = 'insertaAlertaVehiculosPage';
  static const String webVehiculosPage = 'webVehiculosPage';
  static const String mantenteInformadoPage = 'mantenteInformadoPage';
  static const String botonSeguridadPage = 'botonSeguridadPage';
//  static const String alertaCovidNegativoWidget='AlertaCovidNegativoWidget';
  //static const String alertaCovidPositivoWidget='AlertaCovidPositivoWidget';
  static Color colorBarras = Colors.blue[900];


}
