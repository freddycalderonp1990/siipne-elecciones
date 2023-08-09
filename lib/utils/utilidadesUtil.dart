part of 'utils.dart';


class UtilidadesUtil {
  static double redondearDecimales(double valor) {
    return redondearDecimalesN(valor, 2);
  }
  static Future<String> getMac() async{
    String mac='Unknown',imei='Unknown';
    try{
      mac=await GetMac.macAddress;
      // imei= await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);


    }
    on PlatformException{
      mac='Faild to get Mac';
    }

    return mac;
  }

  static trasnformarFecha(String s) {
    String dato = s.substring(0, 10);
    String hora = s.substring(11, s.length);
    // print(dato);
    var arr = dato.split('-');
    final String a = arr[0];
    final String m = arr[1];
    final String d = arr[2];
    DateTime now = new DateTime(int.parse(a), int.parse(m), int.parse(d));
    String fecha = _date(now);
    print(fecha + "  " + hora);
    return fecha + "\n" + hora;
  }

  static  String _date(DateTime tm) {

    String month;

    switch (tm.month) {
      case 1:
        month = "Enero";
        break;
      case 2:
        month = "Febrero";
        break;
      case 3:
        month = "Marzo";
        break;
      case 4:
        month = "Abril";
        break;
      case 5:
        month = "Mayo";
        break;
      case 6:
        month = "Junio";
        break;
      case 7:
        month = "Julio";
        break;
      case 8:
        month = "Agosto";
        break;
      case 9:
        month = "Septiembre";
        break;
      case 10:
        month = "Octubre";
        break;
      case 11:
        month = "Noviembre";
        break;
      case 12:
        month = "Diciembre";
        break;
    }


    String dia;
    switch (tm.weekday) {
      case 1:
        dia = "Lunes";
        break;
      case 2:
        dia = "Martes";
        break;
      case 3:
        dia = "Miércoles";
        break;
      case 4:
        dia = "Jueves";
        break;
      case 5:
        dia = "Viernes";
        break;
      case 6:
        dia = "Sábado";
        break;
      case 7:
        dia = "Domingo";
        break;
    }
    return '$dia ${tm.day} de $month del ${tm.year}';
  }

  static String getFechaActual(){
    DateTime today = new DateTime.now();
    String dateSlug =
        "${today.year.toString()}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
    var arr = dateSlug.split('-');
    final String a = arr[0];
    final String m = arr[1];
    final String d = arr[2];
    DateTime tm = new DateTime(int.parse(a), int.parse(m), int.parse(d));

    return _date(tm);
  }
  static double redondearDecimalesN(double valor, int numDecimales) {
    return double.parse((valor).toStringAsFixed(numDecimales));
  }

  static Future<GaleryCameraModel> getImageGallery(String title) async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    return getImagenResourse(title:title,imageFile:imageFile);

  }

  static Future<void> lanzarLlamada(String num) async {
    String platformImei;
    String idunique;
    // Platform messages may fail, so we use a try/catch PlatformException.

    launch('tel://$num'); //donde $phoneNumber es el numero de teléfono que queremos marcar

  }

  static void ocultarStatusBar()  {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  }
  static void ocultarStatusBarAll()  {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }
  static void mostrarStatusBar()  {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  static Future<GaleryCameraModel> getImageCamera(String title) async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);

    return getImagenResourse(title:title,imageFile:imageFile);

  }

  static Future<String> getVersionName() async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String versionName = packageInfo.version;


    String result= versionName;

    return result;
  }

  static Future<String> getVersionCode() async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String versionCode = packageInfo.buildNumber;

    String result= versionCode;

    return result;
  }

  static abrirUrl(String url) async {

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<String> getVersionCodeNameApp() async{

    String versionName = await getVersionName();
    String versionCode =await getVersionCode();

    String result= versionName+' - '+versionCode;

    return result;
  }



  static pantallasAbrirNuevaCerrarTodas({BuildContext context, String pantalla}){
    Navigator.of(context).pushNamedAndRemoveUntil(pantalla, (Route<dynamic> route) => false);
  }

  static pantallasAbrirNuevaCerrarTodasWidget({BuildContext context, Route pantalla}){
    Navigator.of(context).pushAndRemoveUntil(pantalla, (Route<dynamic> route) => false);
  }


  static Future<GaleryCameraModel> getImagenResourse ({String title,imageFile}) async{
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    int tamImg=900;


    if(imageFile!=null) {
      int rand = new math.Random().nextInt(100000);

      Img.Image image = Img.decodeImage(imageFile.readAsBytesSync());

      // Resize the image to a 120x? thumbnail (maintaining the aspect ratio).
      //Img Image thumbnail = copyResize(image, 120);

      print('Alto: ${image.height}, Ancho ${image.width}');

      int altoImg=image.height;
      int anchoImg=image.width;

      if(altoImg>anchoImg){
        //Img Vertical
        altoImg=tamImg;
        print('En columna IMG alto ${altoImg}, ancho ${anchoImg}');
      }
      else{
        //Img Horizontal
        anchoImg=tamImg;
        print('En row IMG alto ${anchoImg}, ancho ${anchoImg}');
      }

      Img.Image smallerImg = Img.copyResize(image, height: altoImg,width: anchoImg);


      String nameImg = "image_" + title + "_" + rand.toString() + ".jpg";
      var compressImg = new File("$path/$nameImg")
        ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 100));
      return GaleryCameraModel(nombreImg:nameImg,image: compressImg);
    }


  }


  static Future<String> getIp() async {
    String ipAddress = "0";
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      ipAddress = await GetIp.ipAddress;
    } on PlatformException {
      ipAddress = '0';
    }
    String plataforma = getPlataforma();

    if(ipAddress==null){
      ipAddress="0";
    }

    return plataforma + " IP: " + ipAddress;
  }

  static getTheme() {
    return SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }
  static bool plataformaIsAndroid() {
    return  Platform.isAndroid;
  }
  static String getPlataforma() {
    bool isAndroid = Platform.isAndroid;
    bool isOs = Platform.isIOS;
  String result="";
    if (isAndroid) {
      result = "ANDROID";
    } else if (isOs) {
      result = "IOS";
    }

    return "PLATAFORMA " + result;
  }

  static Future<String> get getLocalPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static   setStringBool (bool valor) {

    return valor?'S':'N';
  }




}
