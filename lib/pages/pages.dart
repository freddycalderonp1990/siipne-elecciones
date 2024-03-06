
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong/latlong.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:siipnemovil2/apis/apis.dart';
import 'package:siipnemovil2/config/app_colors.dart';
import 'package:siipnemovil2/miUpc/models/modelsMiUpc.dart';
import 'package:siipnemovil2/miUpc/sharedPreferences/miUpcPreferenciasUsuario.dart';
import 'package:siipnemovil2/sharePreferences/preferenciasSelectApp.dart';
import 'package:siipnemovil2/sharePreferences/preferenciasUsuario.dart';
import 'package:siipnemovil2/sharePreferences/preferenciasSelectApp.dart';

import '../bloc/mapa/mapa_bloc.dart';
import '../bloc/mi_ubicacion/mi_ubicacion_bloc.dart';

import '../utils/myGps.dart';
import '../widgets/combos/combosWidget.dart';


import '../config/appConfig.dart';
import '../providers/providers.dart';
import '../utils/utils.dart';
import '../widgets/customWidgets.dart';
import '../models/models.dart';

//MI UPC
import 'package:siipnemovil2/miUpc/MiUpcAppConfig.dart';

part 'pruebas.dart';

part 'bienvenidaPage.dart';
part 'configAppPage.dart';
part 'login/inicioRapidoPage.dart';
part 'login/loginPage.dart';
part 'operativoProcesoElectoral/selectProcesosOperativosPage.dart';
part 'operativoProcesoElectoral/menuCrearCodigoAnexarsePage.dart';

part 'operativoProcesoElectoral/selectTipoServiciosEjesPage.dart';
part 'verificarGpsPage.dart';
part 'operativoProcesoElectoral/verificaOpertaivoRecintoAbiertoPage.dart';
part 'operativoProcesoElectoral/menuUnidadesPolicialesOtrosPage.dart';

//Sistema Recinto Electoral
part 'operativoProcesoElectoral/1_RecintoElectoral/menuRecintoElectoral.dart';
part 'operativoProcesoElectoral/1_RecintoElectoral/recElecAbrir.dart';
part 'operativoProcesoElectoral/anexarsePage.dart';
part 'operativoProcesoElectoral/registrarNovedadesPage.dart';
part 'operativoProcesoElectoral/addPersonalPage.dart';
part 'operativoProcesoElectoral/personalDetallePage.dart';
part 'novedadesDetallePage.dart';


//UNIDADES POLICIALES
part 'operativoProcesoElectoral/2_UnidadesPoliciales/tipoEjeUnidadesPolicialesPage.dart';
part 'operativoProcesoElectoral/2_UnidadesPoliciales/crearCodigoUnidadPolicialPage.dart';

//TIPO DE EJES OTROS
part 'operativoProcesoElectoral/3_EjeOtros/tipoEjeOtrosPage.dart';
part 'operativoProcesoElectoral/3_EjeOtros/crearCodigoOtrosPage.dart';



