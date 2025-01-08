part of  'apisMiUpc.dart';

class MiUpcUrlApi {

 // static String ambiente=UrlApi.ambiente;

  static String ambiente=Host.hostPruebas;
  static String host = Host.gethost(ambiente); //Pruebas

  static const _pathUrl = "movil/miupc/index.php"; //ruta del arhivo index
  static const String tag = "UrlApi";
  static const int timeEspera = 8;

  static  String pathImagen ="https://"+host+"/descargas/polco/upc/";
  //static const String manualUsuario ="https://"+host+"/appmovil/manualUsuario/Mi_UPC_Manual.pdf";
   static const String manualUsuario ="https://test.policia.gob.ec/appmovil/manualUsuario/Mi_UPC_Manual.pdf";

  static  String UrlServer="https://"+host+"/movil/miupc/index.php";

  static Future getUrl({BuildContext context=null, Map<String, String> parametros,
      File file = null}) async {
    try {

      Uri url = Uri.https(host, _pathUrl, parametros);
      var data = null;
      if (file != null) {
        //var host1="des.policia.gob.ec";
        url = Uri.https(host, _pathUrl, parametros);
        data = await getUrlUploadFile(url:url, context:context, file: file);
      } else {
        data = await getUrlCertificate(url:url, context:context);
      }

      log("urlLista= " + url.toString());
      log(data);
      //Arregla el punto del inicio del DOM
      return data.toString().trim();
    } catch (e) {
      //String msj = tag + " error en getUrl= ${e.message}";
      String msj = "Sin conexión con el servidor";
      print(msj);
      MiUpcAlertasWidget.alerta(ctxt: context, title: 'Error', msj: msj);
      return null;
    }
  }

  static Future getUrlUploadFile({Uri url, BuildContext context=null,
      File file}) async {
    try {
      String parsed = null;

      var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
      var length = await file.length();

      var request = new http.MultipartRequest("POST", url);

      var multipartFile = new http.MultipartFile("file", stream, length,
          filename: basename(file.path));

      request.files.add(multipartFile);

      http.StreamedResponse response = await request.send();

      parsed = await response.stream.transform(utf8.decoder).first;

      return parsed;
    } catch (e) {
      String msj = "Sin conexión con el servidor";
     // String msj = tag + " error en getUrlUploadFile= ${e.message}";
      MiUpcAlertasWidget.alerta(ctxt: context, title: 'Error', msj: msj);
      return null;
    }
  }



  static Future getUrlNoCertificate({Uri url, BuildContext context}) async {
    try {
      HttpClient client = new HttpClient();
      client.connectionTimeout = const Duration(seconds: timeEspera);
      HttpClientRequest request = await client.postUrl(url);

      request.headers.set('content-type', 'application/json');
      HttpClientResponse response = await request.close();

      String reply = await response.transform(utf8.decoder).join();

      return reply;
    } catch (e) {
      String msj = tag + " error en getUrlNoCertificate= ${e.message}";
      print(msj);

      MiUpcAlertasWidget.alerta(ctxt: context, title: 'Error', msj: msj);
      return null;
    }
  }

  static Future getUrlCertificate({Uri url, BuildContext context}) async {
    try {
      HttpClient client = new HttpClient();
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);

      client.connectionTimeout = const Duration(seconds: timeEspera);

      HttpClientRequest request = await client.postUrl(url);

      request.headers.set('content-type', 'application/json');
      HttpClientResponse response = await request.close();

      String reply = await response.transform(utf8.decoder).join();

      return reply;
    } catch (e) {
      //String msj = tag + " error en getUrlCertificate= ${e.message}";
      String msj = "Sin conexión con el servidor";


      return null;
    }
  }


}
