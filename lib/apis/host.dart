part of 'apis.dart';

class Host {

  static const hostDesarrollo = "Desc"; //Produccion
  static const hostPruebas = "Test"; //Pruebas
  static const hostProduccion = "Prod"; //Desarrollo

  static gethost(String host) {
    String url = '';
    switch (host) {
      case hostDesarrollo:
        url = "siipne3wv2.policia.gob.ec"; //Desarrollo

        break;
      case hostPruebas:
        url = "test.policia.gob.ec"; //Pruebas

        break;
      case hostProduccion:
        url = "siipne.policia.gob.ec"; //Produccion
        break;
    }
    return url;
  }
}
