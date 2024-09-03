import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:async/async.dart';
import 'package:siipnemovil2/miUpc/widgets/miUpcCustomWidgets.dart';
import 'package:siipnemovil2/sharePreferences/preferenciasUsuario.dart';
import 'package:siipnemovil2/utils/utils.dart';

import '../models/models.dart';
import '../widgets/customWidgets.dart';
import '../config/appConfig.dart';

part 'constApi.dart';
part 'loginApi.dart';
part 'procesosOperativosApi.dart';
part 'tiposEjesApi.dart';
part 'urlApi.dart';
part 'responseApi.dart';
part 'genDivPolitica.dart';
part 'genPersonaApi.dart';
part 'host.dart';
part 'configAppApi.dart';

//SISTEMA RECINTO ELECTORAL
part 'recintoElectoral/recintosElectoralesApi.dart';
part 'recintoElectoral/novedadesElectoralesApi.dart';
