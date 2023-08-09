part of 'apis.dart';

class ConstApi {


  static const String msjError="No es posible conectar con el servidor. Contacte con el administrador ";
  //HOST DEL SERVIDOR
  //DESARROLLO
  //static const String hostDesarrollo = "192.168.80.71";
  static const String hostDesarrollo = "des.policia.gob.ec";

  //static const String hostDesarrollo = "des.policia.gob.ec";

  //PRUEBAS
  //static const String hostPruebas = "192.168.80.75";
  static const String hostPruebas = "test.policia.gob.ec";

  //PRODUCION
  static const String hostProduccion = "siipne.policia.gob.ec";

  //MODULO PARA INGRESAR
  static const String moduloSiipneMovil = "95fb5a8df008091b1bbc2656d72af496";
  static const String moduloRecintoElectoral =
      "776a98cd4f168530a2de45ec6bde9b8f";

  //VariablesUtil
  static const String varMsj = "msj";
  static const String varDatos = "datos";

  static const String varTrue = "true";
  static const String varFalse = "false";
  static const String varExiste = "existe";
  static const String varNoExiste = "noExiste";
  static const String varDuplicado = "Duplicado";

  //VariablesUtil de los titulo de parametros
  static const String varModulo = "modulo";
  static const String varOpc = "opc";

  static const String varUser = "user";
  static const String varPass = "pass";

  //******************************** CONSTANTES ***********************************************
  //-----------USUARIOS ---------------------

  static const String loginApp = "60ecac4f53994009a38c5ffea069ae8d";
  static const String setConfigApp                = "7e3bfb2860fbfd4fa69b0cf90b0bfe36";


  static const String ConsultarProcesosOperativos = "689a384a92f51e89f6916f146c3cbb25";
  static const String ConsultarUnidadesPoliciales = "bbc1a27d5d33236b1ae4100a33b5f2e9";
  static const String ConsultarAllUnidadesPoliciales              = "47c685145e473f183cfcb4cf342b1773";
  static const String ConsultarTiposEjesPorIdPadre = "0934eca05bce3f4f96999f3fa15ec6aa";
  static const String ConsultarTipoEjeOtros        = "b2745abdf4ec9cae769d9730a4e9db6f";
  static const String ConsultarTipoEjesActivosEnProcesoOperativos = "1e5ce7ad42482403d3dc5b3eba80e97b";

  static const String ConsultarProvincias = "baf8c1a573dc0b9ffa480dcff1f79f2a";
  static const String ConsultarCantones = "571e8e344ed1494a6ef27e9e12a7f610";

  //SISTEMA RECINTOS ELECTORALES
  static const String ConsultarRecintosElectorales =
      "54a659659dff3975495d80543ea33c71";
  static const String AbrirRecintoElectoral =
      "a85db6756be28494370fbb860621ef8b";

  static const String ConsultarDatosEncargadoRecintoPoridCreaRecinto =
      "d4cf4bc777d01be23f8172a4e036b34a";

  static const String AsignarPersonalEnRecintoElectoral =
      "7fd3b86402efccdf476a77bf120ec3cc";
  static const String ConsultarDatosPersPorCedula =
      "93be099533e8ab7dfdecc25ea5722a57";

  static const String ConsultarDatosPersonaPorCedula = "c996291faac0d749d702ba290948dcd8";

  static const String
      VerificarPersonalEncargadoAsignadoRecElectPorIdGenPersona =
      "b94f6729816b7ad846348ce7dcad8f3c";

  static const String EliminarRecintoElectoralAbierto =
      "6231af906d203808e063e9f9bc676c03";
  static const String AbandonarRecintoElectoral =
      "8003332d8a39a88789b39e39d15a4293";
  static const String FinalizarRecintoElectoral =
      "a3a6f42d152098e487e00f831a2b4772";
  static const String ListaNovedadesElectoralesElectorales =
      "e5555afb24a6ebc9b52e146ccad21fe1";
  static const String ListaNovedadesElectoralesElectoralesHijas =
      "3bc152ac532ebfd45f4b31c88c0a7eed";
  static const String InsertarNovedadesElectorales =
      "6a20441cc1f1a104871525b055e04dc8";
  static const String ConsultarPersonalAsignadoRecintoElectoral =
      "b3c995b78182ffb79e73789755776355";
  static const String ConsultarNovedadesRecintoElectoralReporte =
      "2a6a53008561fb9e9e428c7802628aa3";
  static const String GuardarImgRecElectNovedades                               = "768adfdf6e0475bce7663a3c29e5f090";

//FIN CONSTANTES - SISTEMA RECINTOS ELECTORALES
}
