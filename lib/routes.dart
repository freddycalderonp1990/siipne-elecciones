import 'package:flutter/material.dart';
import 'package:siipnemovil2/config/appConfig.dart';

import 'miUpc/MiUpcAppConfig.dart';



class Routes {


  static Map<String, WidgetBuilder> getRoutes(BuildContext context) {
    Map<String, WidgetBuilder> routes=AppConfig.getRoutes(context) ;

    routes.addAll(MiUpcAppConfig.getRoutes(context));

    return routes;
  }
}