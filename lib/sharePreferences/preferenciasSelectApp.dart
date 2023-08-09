

import 'package:shared_preferences/shared_preferences.dart';

// se inicializan nuestras preferencias en el main
class PreferenciasSelectApp {
  static final PreferenciasSelectApp _instancia =
  new PreferenciasSelectApp._internal();

  factory PreferenciasSelectApp() {
    return _instancia;
  }

  PreferenciasSelectApp._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET
  bool selecSiipne() {
    return _prefs.getBool('appSiipne') ?? false;
  }

  setSelectSiipne(bool value) {
    _prefs.setBool('appSiipne', value);
  }

  bool selecMiUpc() {
    return _prefs.getBool('appMiUpc') ?? false;
  }

  setSelecMiUpc(bool value) {
    _prefs.setBool('appMiUpc', value);
  }
}
