import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:provider/provider.dart';
import 'package:siipnemovil2/config/app_colors.dart';
import 'package:siipnemovil2/routes.dart';
import 'package:siipnemovil2/sharePreferences/preferenciasSelectApp.dart';

import 'config/appConfig.dart';
import 'config/appConfig.dart';
import 'bloc/mapa/mapa_bloc.dart';
import 'bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'miUpc/sharedPreferences/miUpcPreferenciasUsuario.dart';
import 'pages/pages.dart';
import 'providers/providers.dart';
import 'sharePreferences/preferenciasUsuario.dart';
import 'utils/utils.dart';



void main() async {
// add this, and it should be the first line in main method
  WidgetsFlutterBinding.ensureInitialized();




  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  final prefsMiUpc = new MiUpcPreferenciasUsuario();
  await prefsMiUpc.initPrefs();

  final prefsSelectApp = new PreferenciasSelectApp();
  await prefsSelectApp.initPrefs();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  final prefsSelectApp = new PreferenciasSelectApp();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ImgProcesoProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => UserProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => RecintoAbiertoProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ProcesoOperativoProvider(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => MiUbicacionBloc()),
            BlocProvider(create: (_) => MapaBloc()),
          ],
          child: MaterialApp(

              title: AppConfig.nameApp,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch:UtilidadesUtil.convertirAColorMaterial(AppColors.colorAzul_1),
              ),
              initialRoute: getInitialRoute(),
              //cambia el idoama a español
              localizationsDelegates: [
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
              ],
              supportedLocales: [
                const Locale("es"),
                const Locale('en'),
              ],
              routes: Routes.getRoutes(context)),
        ));
  }

  String getInitialRoute() {
    String page;
    if (UtilidadesUtil.plataformaIsAndroid()) {
      page = AppConfig.pantallaInicioRapido;
    } else {
      page = prefsSelectApp.selecSiipne()
          ? AppConfig.pantallaInicioRapido
          : AppConfig.pantallaBienvenida;
    }

    return page;
  }
}
