import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:shared_preferences/shared_preferences.dart';

// se inicializan nuestras preferencias en el main
class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET
  String getUser() {
    return _prefs.getString('user') ?? '';
  }

  setUser(String value) {
    _prefs.setString('user', value);
  }

  // GET y SET de la Celular
  String getPass() {
    return _prefs.getString('pass') ?? '';
  }

  setPass(String value) {
    _prefs.setString('pass', value);
  }

//Cuando el usuario a cambiado la clave y al precionar la huella por segunda  vez y no ingresa tiene que reiniciarse
  //para que se loguee con su nueva cuenta
  int getContadorFallido() {
    return _prefs.getInt('contadorFallido') ?? 0;
  }

  setContadorFallido(int value) {

    _prefs.setInt('contadorFallido', value);
  }

  // sirve para controlar si el usuario recien instalo la aplicacion y mostrarle directamente el login
  bool getAppInicial() {
    return _prefs.getBool('appInicial') ?? false;
  }

  setAppInicial(bool value) {
    _prefs.setBool('appInicial', value);
  }

  bool getConfigHuella() {
    return _prefs.getBool('tieneHuella') ?? false;
  }

  setConfigHuella(bool value) {
    _prefs.setBool('tieneHuella', value);
  }


  //Guardamos la foto del Usuario
  // GET y SET
  Uint8List getFoto() {

    String img = _prefs.getString('foto') ?? '';
    print('fotofoto');
    print(img);
    Uint8List imgDecode = null;


    if (img != null ) {
      final decodedBytes = base64Decode(img);
      print(decodedBytes);
      imgDecode = decodedBytes;
    }

     return imgDecode;
  }

  bool getImgValida() {

    String img = _prefs.getString('foto') ?? '';
  if(img.length>50){
    return true;
  }
  else{
    return false;
  }


  }

  setFoto(String value) {
    print('fotofoto');
    log(value);
    _prefs.setString('foto', value);
  }

  //Guardamos los Nombres del Usuario
  // GET y SET
  String getNombre() {


    return _prefs.getString('nombres') ?? '';
  }

  setNombre(String value) {

    _prefs.setString('nombres', value);
  }

  setDatosUser({
    String user,
    String pass,
  }) {
    setUser(user);
    setPass(pass);
  }

  clearDatosUser() {
    setUser('');
    setPass('');
    setFoto('');
    setContadorFallido(0);
  }
}
