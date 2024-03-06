import 'package:shared_preferences/shared_preferences.dart';

// se inicializan nuestras preferencias en el main
class MiUpcPreferenciasUsuario {
  static final MiUpcPreferenciasUsuario _instancia =
      new MiUpcPreferenciasUsuario._internal();

  factory MiUpcPreferenciasUsuario() {
    return _instancia;
  }

  MiUpcPreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    print("instanciando prefe");
    this._prefs = await SharedPreferences.getInstance();

  }



  // GET y SET del idUser
  getidUsuarioMiUpc() {
    print('retronadno id');
    return _prefs.getString('idUsuarioMiUpc') ?? "0";
  }

  setidUsuarioMiUpc(String value) {
    print('insertando id');
    _prefs.setString('idUsuarioMiUpc', value);
  }


  // GET y SET del idUser
  getidGenPersonaMiUpc() {
    print('retronadno idGenPersonaMiUpc');

  return _prefs.getString('idGenPersonaMiUpc')??"0";



  }

  setidGenPersonaMiUpc(String value) {
    print('idGenPersonaMiUpc id {$value}');


      _prefs.setString('idGenPersonaMiUpc', value);


  }


  // GET y SET del nombreUsuarioMiUpc
  String getnombreUsuarioMiUpc() {



      return _prefs.getString('miupcusername')??"";



  }

  setnombreUsuarioMiUpc(String value) {
    _prefs.setString('miupcusername', value);
  }

  // GET y SET de la cedulaMiUpc
  getcedulaMiUpc() {


      return _prefs.getString('cedulaMiUpc')??"";


  }

  setcedulaMiUpc(String value) {
    _prefs.setString('cedulaMiUpc', value);
  }

  // GET y SET de la celularMiUpc
  getcelularMiUpc() {


      return _prefs.getString('celularMiUpc')??"";



  }

  setcelularMiUpc(String value) {
    _prefs.setString('celularMiUpc', value);
  }

  // GET y SET de la nombresMiUpc
  getnombresMiUpc() {

      return _prefs.getString('nombresMiUpc')??"";




  }

  setnombresMiUpc(String value) {
    print('set nombresMiUpc' + value);

    _prefs.setString('nombresMiUpc', value);
  }

  // GET y SET de la emailMiUpc
  getemailMiUpc() {

      return _prefs.getString('emailMiUpc')??"";


  }

  setemailMiUpc(String value) {
    _prefs.setString('emailMiUpc', value);
  }

  // GET y SET de la emailMiUpc
  bool getIsnacionalMiUpc() {
    bool result = false;
    String valor = _prefs.getString('nacionalMiUpc') ?? '';
    valor == 'SI' ? result = true : result = false;
    return result;
  }

  setIsnacionalMiUpc(bool valor) {
    String value = 'NO';
    valor ? value = 'SI' : value = 'NO';
    _prefs.setString('nacionalMiUpc', value);
  }

  // GET y SET de la token
  //se definen dos token para almacenar el nuevo y antiguo token
  gettoken1MiUpc() {
    return _prefs.getString('token1MiUpc') ?? '';
  }

  settoken1MiUpc(String value) {

    _prefs.setString('token1MiUpc', value);
  }

  gettoken2MiUpc() {
    return _prefs.getString('token2MiUpc') ?? '';
  }

  settoken2MiUpc(String value) {
    _prefs.setString('token2MiUpc', value);
  }


  getimeiMiUpc() {
    return _prefs.getString('imeiMiUpc') ?? '';
  }

  setimeiMiUpc(String value) {
    _prefs.setString('imeiMiUpc', value);
  }
  setDatosUser(
      {
        String idGenPersonaMiUpc,
        String nombreUser,
        String cedulaMiUpcV,
        String emailMiUpcV,
        String nombresMiUpcV,
        String celularMiUpc,
        String idUsuarioMiUpc,
        bool isnacionalMiUpc,
        String imeiMiUpc}) {

    setidGenPersonaMiUpc(idGenPersonaMiUpc);
    setnombreUsuarioMiUpc(nombreUser);
    setcedulaMiUpc(cedulaMiUpcV);
    setemailMiUpc(emailMiUpcV);
    setnombresMiUpc(nombresMiUpcV);
    setcelularMiUpc(celularMiUpc);
    setidUsuarioMiUpc(idUsuarioMiUpc);
    setIsnacionalMiUpc(isnacionalMiUpc);
    setimeiMiUpc(imeiMiUpc);
  }

  clearDatosUser() {
    setidGenPersonaMiUpc('0');
    setnombreUsuarioMiUpc('');
    setcedulaMiUpc('');
    setemailMiUpc('');
    setnombresMiUpc('');
    setcelularMiUpc('');
    setidUsuarioMiUpc('');
    setIsnacionalMiUpc(true);
    settoken1MiUpc('');
    settoken2MiUpc('');
    setimeiMiUpc('');

    print(clearDatosUser);
  }
}
