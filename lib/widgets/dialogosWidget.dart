part of 'customWidgets.dart';

class DialogosWidget {
  static getDialogoBotton({BuildContext context, String msj}) {
    final snackBar = SnackBar(
      content: Text(msj),
      elevation: 10,
    );

// Encuentra el Scaffold en el árbol de widgets y ¡úsalo para mostrar un SnackBar!
    //Scaffold.of(context).showSnackBar(snackBar);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Dialog dialogo(BuildContext context,
      {String title = '',
      List<Widget> botonesWidget,
      @required Widget widget}) {
    double radioBorder = 30.0;

    widget = WillPopScope(onWillPop: () async => false, child: widget);
    final dialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radioBorder))),
      child: DesingDialogo(
        title: title,
        botonesWidget: botonesWidget,
        widget: widget,
        radioBorder: radioBorder,
      ),
    );

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => dialog);
  }

  static Dialog selectPicture(BuildContext context,
      {GestureTapCallback onTapGalery, GestureTapCallback onTapCamara}) {
    final responsive = ResponsiveUtil(context);
    double radioBorder = 40.0;
    final dialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radioBorder))),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radioBorder),
              boxShadow: [
                BoxShadow(color: AppConfig.colorBordecajas, blurRadius: 10)
              ]),
          child: Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: responsive.anchoP(100),
                  decoration: BoxDecoration(
                      color: AppConfig.colorBordecajas,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radioBorder),
                          topRight: Radius.circular(radioBorder))),
                  child: Center(
                    child: Text(
                      "Registrar  foto ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: responsive.anchoP(6),
                          color: Colors.white),
                    ),
                  ),
                ),
                //  SizedBox(height: responsive.altoP(3)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  margin: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                       GestureDetector(
                          child: Container(
                            height: responsive.altoP(5),
                            width: responsive.ancho,
                            child: Row(
                              children: [
                                Icon(Icons.picture_in_picture_alt_rounded),
                                SizedBox(
                                  width: responsive.anchoP(1),
                                ),
                                Text(
                                  "Galería",
                                  style: TextStyle(
                                      fontSize: responsive.altoP(2.5)),
                                ),
                              ],
                            ),
                          ),
                          onTap: onTapGalery,
                        ),
                        Padding(padding: EdgeInsets.all(6.0)),
                        Container(
                            height: responsive.altoP(5),
                            child: GestureDetector(
                              child: Row(
                                children: [
                                  Icon(Icons.camera_alt),
                                  SizedBox(
                                    width: responsive.anchoP(1),
                                  ),
                                  Text(
                                    "Cámara",
                                    style: TextStyle(
                                        fontSize: responsive.altoP(2.5)),
                                  ),
                                ],
                              ),
                              onTap: onTapCamara,
                            )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );

    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) => dialog);
  }

  static Widget getDialogoMsjLlamada(String message) {
    message = message.replaceAll(
        UrlApi.getHost(), "HOST SECRET"); //evito mostra el host al usuario
    return ContenedorDesingWidget(
      anchoPorce: 66,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.insert_comment,
              color: Colors.black,
            ),
            SizedBox(
              width: 5,
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Container(
                child: Text(
                  message,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget getDialogoMsj(String message) {
    message = message.replaceAll(
        UrlApi.getHost(), "HOST SECRET"); //evito mostra el host al usuario
    return ContenedorDesingWidget(
      anchoPorce: 65,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.insert_comment,
              color: Colors.black,
            ),
            Flexible(
              child: Container(
                child: Text(
                  message,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Dialog alertllamada(BuildContext context,
      {String msjBtn = "OK",
      String title = '',
      String message = '',
      GestureTapCallback onTap}) {
    List<Widget> botonesWidget = <Widget>[
      BtnIconWidget(
        color: Colors.green,
        title: "Llamar",
        colorTextoIcon: Colors.white,
        iconData: Icons.phone,
        onTap: onTap == null
            ? () {
                Navigator.of(context).pop();
              }
            : onTap,
      ),
      SizedBox(
        width: 10,
      ),
      BtnIconWidget(
          color: Colors.redAccent,
          title: "    NO      ",
          colorTextoIcon: Colors.white,
          iconData: Icons.no_cell,
          onTap: () {
            Navigator.of(context).pop();
          }),
    ];

    dialogo(context,
        title: title,
        botonesWidget: botonesWidget,
        widget: getDialogoMsjLlamada(message));
  }

  static Dialog alert(BuildContext context,
      {String msjBtn = "OK",
      String title = '',
      String message = '',
      GestureTapCallback onTap}) {
    if(message=="noExiste"){
      message="No existen Datos";
    }
    List<Widget> botonesWidget = <Widget>[



      BotonesWidget(
        title: msjBtn,
        iconData: Icons.check,
        onPressed: onTap == null
            ? () {
                Navigator.of(context).pop();
              }
            : onTap,
      ),
    ];

    dialogo(context,
        title: title,
        botonesWidget: botonesWidget,
        widget: getDialogoMsj(message));
  }

  static void error(BuildContext context, {String message = ''}) {
    DialogosWidget.alert(context, title: "Información", message: message);
  }

  static Dialog alertPersonalizableGuardar(BuildContext context,
      {String title = '',
      String message = '',
      VoidCallback onPress,
      @required Widget widget}) {
    final responsive = ResponsiveUtil(context);

    List<Widget> botonesWidget = <Widget>[
      BtnIconWidget(
          color: AppConfig.colorBotonesWidget,
          title: "Guardar",
          colorTextoIcon: Colors.white,
          iconData: Icons.check,
          onTap: onPress),
      SizedBox(
        width: responsive.anchoP(4),
      ),
      BtnIconWidget(
          color: Colors.redAccent,
          title: "Cancelar",
          colorTextoIcon: Colors.white,
          iconData: Icons.check,
          onTap: () {
            Navigator.of(context).pop();
          }),
    ];
    dialogo(context,
        title: title, botonesWidget: botonesWidget, widget: widget);
  }

  static Dialog alertPersonalizableSiNo(BuildContext context,
      {String title = '',
      String message = '',
      VoidCallback onPress,
      @required Widget widget}) {
    final responsive = ResponsiveUtil(context);

    List<Widget> botonesWidget = <Widget>[
      BtnIconWidget(
          color: AppConfig.colorBotonesWidget,
          title: "SI",
          colorTextoIcon: Colors.white,
          iconData: Icons.check,
          onTap: onPress),
      SizedBox(
        width: responsive.anchoP(4),
      ),
      BtnIconWidget(
          color: Colors.redAccent,
          title: "NO",
          colorTextoIcon: Colors.white,
          iconData: Icons.check,
          onTap: () {
            Navigator.of(context).pop();
          }),
    ];
    dialogo(context,
        title: title, botonesWidget: botonesWidget, widget: widget);
  }

  static Dialog alertSiNo(BuildContext context,
      {String title = '', String message = '', VoidCallback onTap}) {
    final responsive = ResponsiveUtil(context);

    List<Widget> botonesWidget = <Widget>[
      BtnIconWidget(
          color: AppConfig.colorBotonesWidget,
          title: "SI",
          colorTextoIcon: Colors.white,
          iconData: Icons.check,
          onTap: onTap),
      SizedBox(
        width: responsive.anchoP(4),
      ),
      BtnIconWidget(
          color: Colors.redAccent,
          title: "NO",
          colorTextoIcon: Colors.white,
          iconData: Icons.check,
          onTap: () {
            Navigator.of(context).pop();
          }),
    ];
    dialogo(context,
        title: title,
        botonesWidget: botonesWidget,
        widget: getDialogoMsj(message));
  }

  static Dialog alertSiNo2(BuildContext context,
      {String title = '',
      String message = '',
      VoidCallback onTapSi,
      VoidCallback onTapNo}) {
    final responsive = ResponsiveUtil(context);

    List<Widget> botonesWidget = <Widget>[
      BtnIconWidget(
          color: AppConfig.colorBotonesWidget,
          title: "SI",
          colorTextoIcon: Colors.white,
          iconData: Icons.check,
          onTap: onTapSi),
      SizedBox(
        width: responsive.anchoP(4),
      ),
      BtnIconWidget(
          color: Colors.redAccent,
          title: "NO",
          colorTextoIcon: Colors.white,
          iconData: Icons.check,
          onTap: onTapNo),
    ];
    dialogo(context,
        title: title,
        botonesWidget: botonesWidget,
        widget: getDialogoMsj(message));
  }

  static Dialog dialogoGuardar(BuildContext context, {VoidCallback onTap}) {
    final responsive = ResponsiveUtil(context);

    List<Widget> botonesWidget = <Widget>[
      BtnIconWidget(
          color: AppConfig.colorBotonesWidget,
          title: "SI",
          colorTextoIcon: Colors.white,
          iconData: Icons.check,
          onTap: onTap),
      SizedBox(
        width: responsive.anchoP(4),
      ),
      BtnIconWidget(
          color: Colors.redAccent,
          title: "NO",
          colorTextoIcon: Colors.white,
          iconData: Icons.check,
          onTap: () {
            Navigator.of(context).pop();
          }),
    ];
    dialogo(context,
        title: VariablesUtil.GUARDAR,
        botonesWidget: botonesWidget,
        widget: getDialogoMsj(VariablesUtil.deseaContinuar));
  }

  static Dialog dialogoDatosVictimaVisitar(BuildContext context,
      {VoidCallback onTap,
      String nombres,
      String apellidos,
      String direccion,
      List<String> medidasProteccion}) {
    final responsive = ResponsiveUtil(context);

    List<Widget> botonesWidget = <Widget>[
      BtnIconWidget(
          color: AppConfig.colorBotonesWidget,
          title: "Visitar",
          colorTextoIcon: Colors.white,
          iconData: Icons.directions_run,
          onTap: onTap),
      SizedBox(
        width: responsive.anchoP(4),
      ),
      BtnIconWidget(
          color: Colors.redAccent,
          title: "Cancelar",
          colorTextoIcon: Colors.white,
          iconData: Icons.cancel,
          onTap: () {
            Navigator.of(context).pop();
          }),
    ];

    //Dibujamos las medidas de proteccion
    List<Widget> medidas = new List();
    for (int i = 0; i < medidasProteccion.length; i++) {
      medidas.add(DetalleTextWidget(
        detalle: medidasProteccion[i],
      ));
    }

    Widget wg = Column(
      children: [
        TituloDetalleTextWidget(
          context: context,
          title: "Nombres:",
          detalle: nombres,
        ),
        TituloDetalleTextWidget(
          context: context,
          title: "Apellidos:",
          detalle: apellidos,
        ),
        TituloDetalleTextWidget(
          context: context,
          title: "Dirección:",
          detalle: direccion,
        ),
        Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(color: AppConfig.colorBordecajas, blurRadius: 1)
                ]),
            child: Column(
              children: [
                TituloTextWidget(title: "Medidas de Protección"),
                Column(
                  children: medidas,
                )
              ],
            ))
      ],
    );
    dialogo(context,
        title: "Datos de la Víctima", botonesWidget: botonesWidget, widget: wg);
  }
}

class DesingDialogo extends StatelessWidget {
  final String title;
  final Widget widget;
  final List<Widget> botonesWidget;
  final double radioBorder;

  const DesingDialogo(
      {Key key,
      this.title = '',
      this.widget,
      this.botonesWidget,
      this.radioBorder = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil(context);

    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radioBorder),
            boxShadow: [
              BoxShadow(color: AppConfig.colorBordecajas, blurRadius: 10)
            ]),
        child: Padding(
          padding: const EdgeInsets.only(top: 0, bottom: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: responsive.anchoP(100),
                  decoration: BoxDecoration(
                      color: AppConfig.colorBotonesWidget,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radioBorder),
                          topRight: Radius.circular(radioBorder))),
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: responsive.anchoP(6), color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: responsive.altoP(3)),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[widget],
                  ),
                ),
                SizedBox(height: responsive.anchoP(3)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: botonesWidget,
                )
              ],
            ),
          ),
        ));
  }
}
