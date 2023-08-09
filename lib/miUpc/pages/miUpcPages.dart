import 'dart:async';
import 'dart:io';


import 'package:android_intent/android_intent.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flt_telephony_info/flt_telephony_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:siipnemovil2/helpers/helpers.dart';



import 'package:siipnemovil2/miUpc/MiUpcAppConfig.dart';
import 'package:siipnemovil2/miUpc/apis/apisMiUpc.dart';
import 'package:siipnemovil2/miUpc/models/getNotificacionesModel.dart';
import 'package:siipnemovil2/miUpc/models/modelsMiUpc.dart';
import 'package:siipnemovil2/miUpc/models/serviciosPolcoModel.dart';
import 'package:siipnemovil2/miUpc/sharedPreferences/miUpcPreferenciasUsuario.dart';
import 'package:siipnemovil2/miUpc/widgets/miUpcCustomWidgets.dart';
import 'package:siipnemovil2/miUpc/widgets/opcionesUpcWidget.dart';
import 'package:siipnemovil2/pages/pages.dart';

import 'package:siipnemovil2/utils/utils.dart';
import 'package:siipnemovil2/widgets/customWidgets.dart';
import 'package:siipnemovil2/widgets/miUpcWidgets.dart';
import 'package:device_info/device_info.dart';
import 'package:siipnemovil2/miUpc/widgets/estilosBotonesWidget.dart';
import 'package:siipnemovil2/miUpc/apis/miUpcConstApi.dart';
import 'package:siipnemovil2/miUpc/widgets/miUpcMyDrawerWidget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong/latlong.dart';
import 'package:share/share.dart';



part 'miUpcSplashPage.dart';
part 'miUpcAcuerdoConfiPage.dart';
part 'miUpcLoginPage.dart';
part 'miUpcMenuPrincipalPage.dart';
part 'miUpcMapaUpcPage.dart';
part 'miUpcListaViolenciaPage.dart';
part 'miUpcListaTipsCovidPage.dart';
part 'miUpcListaServiciosPolcoPage.dart';
part 'miUpcListaMedidasAutoproteccionPage.dart';
part 'miUpcListaNoticiasPage.dart';
part 'miUpcModificarDatosPage.dart';
