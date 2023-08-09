part of  'miUpcCustomWidgets.dart';

class MiUpcDialogosWidget {

  static Dialog alertaBtnAceptar(
      {BuildContext context, @required VoidCallback onPressed, String texto=''}) {
    final responsive = ResponsiveUtil(context);
    List<Widget> botonesWidget = <Widget>[
      TextButton(
        child: Text(
          'Aceptar',
          style: TextStyle(
            fontSize: 14,
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: onPressed,
      ),

    ];

    Widget contenido = Container(
      width: responsive.anchoP(70),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(MiUpcAppConfig.imgFondo),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(

            child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'INFORMACIÓN',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.transparent,
                            height: 15.0,
                          ),
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      texto,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                          color: MiUpcAppConfig.colorBarras),
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.transparent,
                            height: 15.0,
                          ),



                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );

    dialogoOp(context, botonesWidget: botonesWidget, widget: contenido);
  }

  static Dialog dialogoDinamico(BuildContext context,
      {String title = '',
        bool llamar911 = false,
        List<Widget> botonesWidget,
        bool exitApp = false,
        @required Widget widget}) {
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
                BoxShadow(color: MiUpcAppConfig.colorBarras, blurRadius: 10)
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
                      color: MiUpcAppConfig.colorBarras,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radioBorder),
                          topRight: Radius.circular(radioBorder))),
                  child: Center(
                    child: Text(
                      "INFORMACIÓN",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: responsive.anchoP(6),
                          color: Colors.white),
                    ),
                  ),
                ),
                //  SizedBox(height: responsive.altoP(3)),
                Container(
                  height: responsive.altoP(6.0),
                  child: Image(
                    image: AssetImage(MiUpcAppConfig.imgPaquitoCovid),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[widget],
                ),
                TextButton(

                  onPressed: () {
                    if (llamar911) {
                      UtilidadesUtil.lanzarLlamada('911');
                    }
                    if (exitApp) {
                      exit(0);
                    } else {
                      Navigator.of(context).pop();
                    }
                  },

                  child: Text(
                    'ACEPTAR',
                    style: TextStyle(
                      color: MiUpcAppConfig.colorBarras,
                      // letterSpacing: 1,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ),
                /*
                // SizedBox(height: responsive.anchoP(3)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: botonesWidget,
                )*/
              ],
            ),
          )),
    );

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => dialog);
  }


  static Dialog alertasV(
      {BuildContext context,
        String txt,
        bool exitApp = false,
        bool llamar911 = false}) {
    final responsive = ResponsiveUtil(context);

    List<Widget> botonesWidget = <Widget>[];
    dialogoDinamico(context,
        llamar911: llamar911,
        botonesWidget: botonesWidget,
        exitApp: exitApp,
        widget: _getDialogoMsj1(context, txt));
  }

  static Widget _getDialogoMsj1(BuildContext context, String texto) {
    final responsive =
    ResponsiveUtil(context); //evito mostra el host al usuario
    return Container(
      width: responsive.anchoP(75),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Card(
              child: Column(
                children: <Widget>[
                  Text(
                    texto,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  static Dialog alertaRegistro({
    @required BuildContext context,
    @required String nombre,
    @required String cedula,
    @required String celular,
    VoidCallback onPressed
  }) {
    String valorVacio = 'Null';
    final responsive = ResponsiveUtil(context);
    double radioBorder = 30.0;
    double separacion = 1.0;

    double sizeDetalle = responsive.altoP(2);
    double sizeDatos = responsive.anchoP(40);

    final dialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radioBorder))),
      child: Container(
          height: responsive.altoP(70),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radioBorder),
              boxShadow: [
                BoxShadow(color: MiUpcAppConfig.colorBarras, blurRadius: 20)
              ]),
          child: Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 5),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: responsive.anchoP(100),
                    decoration: BoxDecoration(
                        color: MiUpcAppConfig.colorBarras,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radioBorder),
                            topRight: Radius.circular(radioBorder))),
                    child: Center(
                      child: Text(
                        "",
                        style: TextStyle(
                            fontSize: responsive.anchoP(6),
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(MiUpcAppConfig.imgFondo),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Image.asset(MiUpcAppConfig.imgCabecera),
                              width: responsive.ancho,
                              height: responsive.altoP(4),
                            ),
                            //  SizedBox(height: responsive.altoP(3)),
                            Container(
                              child: Image.asset(MiUpcAppConfig.imgLinea),
                            ),
                            Container(
                              height: responsive.altoP(53),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '¡REGISTRO EXITOSO!',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: responsive.isVertical()
                                              ? responsive.anchoP(6)
                                              : responsive.altoP(8)),
                                    ),
                                    Divider(
                                      color: Colors.transparent,
                                      height: responsive.altoP(separacion),
                                    ),
                                    Text(
                                      'Ya puede utilizar esta aplicación',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: sizeDetalle),
                                    ),
                                    Divider(
                                      color: Colors.transparent,
                                      height: 15.0,
                                    ),
                                    Text(
                                      'Su registro ha sido realizado con los siguientes datos',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: sizeDetalle),
                                    ),
                                    Divider(
                                      color: Colors.transparent,
                                      height: 8.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.center,
                                          width: sizeDatos,
                                          child: Text(
                                            'NOMBRES DE USUARIO:   ',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: sizeDetalle),
                                          ),
                                        ),
                                        SizedBox(
                                          width: responsive.anchoP(2),
                                        ),
                                        Expanded(
                                          child: Text(
                                            nombre,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: sizeDetalle),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.transparent,
                                      height: 8.0,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                            width: sizeDatos,
                                            child: Text(
                                              'DOCUMENTO DE IDENTIDAD:   ',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: sizeDetalle),
                                            )),
                                        SizedBox(
                                          width: responsive.anchoP(2),
                                        ),
                                        Expanded(
                                          child: Text(
                                            cedula,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: sizeDetalle),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.transparent,
                                      height: 8.0,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                            width: sizeDatos,
                                            child: Text(
                                              'CELULAR:   ',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: sizeDetalle),
                                            )),
                                        SizedBox(
                                          width: responsive.anchoP(2),
                                        ),
                                        Text(
                                          celular,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: sizeDetalle),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Center(
                                          child: Container(
                                            child: Image.asset(
                                                MiUpcAppConfig.imgPaquito),
                                            width: responsive.altoP(20),
                                            height: responsive.altoP(22),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              height: 15,
                            ),
                            TextButton(

                              onPressed: onPressed,

                              child: Text(
                                'ACEPTAR',
                                style: TextStyle(
                                  color: MiUpcAppConfig.colorBarras,
                                  // letterSpacing: 1,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => dialog);
  }

  static Dialog alertaComunitaria(
      {BuildContext context, @required VoidCallback onPressed}) {
    final responsive = ResponsiveUtil(context);
    List<Widget> botonesWidget = <Widget>[
      TextButton(
        child: Text(
          'Aceptar',
          style: TextStyle(
            fontSize: 14,
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: onPressed,
      ),
      SizedBox(
        width: responsive.anchoP(4),
      ),
      TextButton(
        child: Text(
          'Cancelar',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ];

    Widget contenido = Container(
      width: responsive.anchoP(70),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(MiUpcAppConfig.imgFondo),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: responsive.altoP(30),
            child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'INFORMACIÓN',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.transparent,
                            height: 15.0,
                          ),
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "Recuerda que este espacio está destinado para reportar tus alertas del barrio como: \n"
                                          "\n - Falta de iluminación."
                                          "\n - Parques abandonados. "
                                          "\n - Presencia de indigentes."
                                          "\n - Centros de diversión clandestinos."
                                          "\n - Lugar de expendio y consumo de droga.",
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                          color: MiUpcAppConfig.colorBarras),
                                    ),
                                    Text(
                                      "\n¿Desea Continuar?",
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                          color: MiUpcAppConfig.colorBarras),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.transparent,
                            height: 15.0,
                          ),



                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );

    dialogoOp(context, botonesWidget: botonesWidget, widget: contenido);
  }
  static Dialog dialogoOp(BuildContext context,
      {String title = '',
        List<Widget> botonesWidget,
        @required Widget widget}) {
    final responsive = ResponsiveUtil(context);
    double radioBorder = 30.0;
    final dialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radioBorder))),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radioBorder),
              boxShadow: [
                BoxShadow(color: MiUpcAppConfig.colorBarras, blurRadius: 20)
              ]),
          child: Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 5),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: responsive.anchoP(100),
                    decoration: BoxDecoration(
                        color: MiUpcAppConfig.colorBarras,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radioBorder),
                            topRight: Radius.circular(radioBorder))),
                    child: Center(
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: responsive.anchoP(6),
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    child: Image.asset(MiUpcAppConfig.imgCabecera),
                    width: responsive.ancho,
                    height: responsive.altoP(6),
                  ),
                  //  SizedBox(height: responsive.altoP(3)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[widget],
                  ),
                  // SizedBox(height: responsive.anchoP(3)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: botonesWidget,
                  )
                ],
              ),
            ),
          )),
    );

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => dialog);
  }


  static Dialog alertItems(
      {@required BuildContext context,
        @required  imagen,
        @required String title,
        @required List listaIt}) {
    var imgMemory=null;
    imgMemory =  PhotoHelper.convertStringToUint8List( imagen);

    final responsive = ResponsiveUtil(context);
    List<Widget> botonesWidget = <Widget>[
      TextButton(
        child: Text(
          'Aceptar',
          style: TextStyle(
            fontSize: 14,
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ];
    dialogoItems(context,
        botonesWidget: botonesWidget,
        widget: dialogoMsjItemsWidget(
            imagen: imagen, title: title, listaIt: listaIt));
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////DIALOGO DE ITEMS DE SERVICIOS///////////////////////////////////////

  static Dialog dialogoItems(BuildContext context,
      {String title = '',
        List<Widget> botonesWidget,
        @required Widget widget}) {
    final responsive = ResponsiveUtil(context);
    double radioBorder = 30.0;
    final dialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radioBorder))),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radioBorder),
              boxShadow: [
                BoxShadow(color: MiUpcAppConfig.colorBarras, blurRadius: 20)
              ]),
          child: Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: responsive.anchoP(100),
                  decoration: BoxDecoration(
                      color: MiUpcAppConfig.colorBarras,
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
                Container(
                  child: Image.asset(MiUpcAppConfig.imgCabecera),
                  width: responsive.ancho,
                  height: responsive.altoP(6),
                ),
                //  SizedBox(height: responsive.altoP(3)),
                Container(
                  child: Image.asset(MiUpcAppConfig.imgLinea),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[widget],
                ),
                // SizedBox(height: responsive.anchoP(3)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: botonesWidget,
                ),
              ],
            ),
          )),
    );

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => dialog);
  }


  static Widget _getDialogoMsjItems(
      {@required BuildContext ctxt,
        @required  imagen,
        @required String title,
        @required List listaIt}) {
    var imgMemory=null;
    imgMemory =  PhotoHelper.convertStringToUint8List( imagen);
    final responsive = ResponsiveUtil(ctxt);
    //evito mostra el host al usuario
    return Container(
      width: responsive.anchoP(70),
      height: responsive.isVertical() ? responsive.altoP(49) : responsive.altoP(40),
      child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(MiUpcAppConfig.imgFondo),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    imgMemory!=null?Container(
                                      height: responsive.altoP(8),
                                      width: responsive.altoP(8),
                                      child: Image.memory(imgMemory) ,):Container(
                                        height: responsive.altoP(8),
                                        width: responsive.altoP(8),
                                        child:Image.asset(MiUpcAppConfig.imgEscpolicia)
                                    ),
                                    Flexible(
                                      child: Card(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "     " + title,
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  height: 5.0,
                                  color: Colors.blueAccent,
                                ),
                                Container(
                                  height: responsive.altoP(30),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: getItems(listaIt, responsive, ctxt),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  static List<Widget> getItems(
      List<String> lista, ResponsiveUtil responsive, BuildContext ctx) {
    List<Widget> wi = List();
    for (int i = 0; i < lista.length; i++) {
      wi.add(Container(
        child: Row(
          children: <Widget>[
            Container(
              child: Image.asset(MiUpcAppConfig.imgVineta),
              width: responsive.altoP(2.0),
              height: responsive.altoP(2.0),
            ),
            Container(
              width: responsive.anchoP(65),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      lista[i],
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ));
    }
    return wi;
  }

  static Dialog alertOpciones(
      {BuildContext context,
        @required String t,
        @required String i,
        @required String i1,
        @required String i2,
        @required String i3,
        @required String op}) {
    final responsive = ResponsiveUtil(context);
    List<Widget> botonesWidget = <Widget>[
      TextButton(
        child: Text(
          'Aceptar',
          style: TextStyle(
            fontSize: 14,
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          if (op == "1") {
            Navigator.pop(context);
            Navigator.pushNamed(context, MiUpcAppConfig.FormularioAlertaVehiculos,
                arguments: '8888888888888888888881');
          }
          if (op == "2") {
            Navigator.pop(context);
            Navigator.pushNamed(
                context, MiUpcAppConfig.FormularioAlertaDesaparecidos);
          }
          if (op == "3") {
            Navigator.pop(context);
            Navigator.pushNamed(context, MiUpcAppConfig.FormularioAlertaMascotas);
          }
          if (op == "4") {
            Navigator.pop(context);
            Navigator.pushNamed(context, MiUpcAppConfig.FormularioAlertaViolencia);
          }
        },
      ),
      SizedBox(
        width: responsive.anchoP(4),
      ),
      TextButton(
        child: Text(
          'Cancelar',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ];
    dialogoOp(context,
        botonesWidget: botonesWidget,
        widget: _getDialogoMsjO(
            ctxt: context, title: t, item: i, item1: i1, item2: i2, item3: i3));
  }

  static Widget _getDialogoMsjO({
    @required BuildContext ctxt,
    @required String title,
    @required String item,
    @required String item1,
    @required String item2,
    @required String item3,
  }) {
    final responsive = ResponsiveUtil(ctxt); //evito mostra el host al usuario
    return Container(
      width: responsive.anchoP(70),

      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(MiUpcAppConfig.imgFondo),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: responsive.altoP(30),
            child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: Column(
                                  crossAxisAlignment:CrossAxisAlignment.center,
                                  mainAxisAlignment : MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      title,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.transparent,
                            height: 15.0,
                          ),
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      item,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                          color: MiUpcAppConfig.colorBarras),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.transparent,
                            height: 15.0,
                          ),
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      item1,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                          color: MiUpcAppConfig.colorBarras),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.transparent,
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      item2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.transparent,
                            height: 15.0,
                          ),
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      item3,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: MiUpcAppConfig.colorBarras),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  static Dialog alertOpcionesCovid({
    BuildContext context,
  }) {
    final responsive = ResponsiveUtil(context);
    List<Widget> botonesWidget = <Widget>[];
    dialogoOpCovid(context,
        botonesWidget: botonesWidget,
        widget: _getDialogoMsjCovid(ctxt: context));
  }
  static Widget _getDialogoMsjCovid({
    @required BuildContext ctxt,
  }) {
    final responsive = ResponsiveUtil(ctxt); //evito mostra el host al usuario
    return Container(
      width: responsive.anchoP(72),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(MiUpcAppConfig.imgFondo),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        child: Material(
                            child: InkWell(
                              onTap: () {
                                pantallaCovid(ctxt);
                              },
                              child: Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image.asset('assets/miUpc/img/informate.png',
                                      width: responsive.altoP(12.0)),
                                ),
                              ),
                            ))),

                  ],
                ),
                Divider(
                  color: Colors.transparent,
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "INFORMATE",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: MiUpcAppConfig.colorBarras),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static void pantallaCovid(BuildContext ctx) {
    Navigator.of(ctx).pop();
    Navigator.pushNamed(ctx, MiUpcAppConfig.listaTipsCovidPage);
  }

  static void pantallaCovidMenu(BuildContext ctx) {
    Navigator.of(ctx).pop();
    Navigator.pushNamed(ctx, MiUpcAppConfig.CovidMenuPage);
  }

  static Dialog dialogoOpCovid(BuildContext context,
      {String title = '',
        List<Widget> botonesWidget,
        @required Widget widget}) {
    final responsive = ResponsiveUtil(context);
    double radioBorder = 30.0;
    final dialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radioBorder))),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radioBorder),
              boxShadow: [
                BoxShadow(color: MiUpcAppConfig.colorBarras, blurRadius: 20)
              ]),
          child: Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 5),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: responsive.anchoP(100),
                    decoration: BoxDecoration(
                        color: MiUpcAppConfig.colorBarras,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radioBorder),
                            topRight: Radius.circular(radioBorder))),
                    child: Center(
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: responsive.anchoP(6),
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    child: Image.asset(MiUpcAppConfig.imgCabecera),
                    width: responsive.ancho,
                    height: responsive.altoP(6),
                  ),
                  //  SizedBox(height: responsive.altoP(3)),
                  Container(
                    child: Image.asset(MiUpcAppConfig.imgLinea),
                  ),
                  Container(
                    child: Image.asset(MiUpcAppConfig.imgCovid),
                  ),
                  Container(
                    child: Image.asset(MiUpcAppConfig.imgLinea),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[widget],
                  ),
                  // SizedBox(height: responsive.anchoP(3)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: botonesWidget,
                  )
                ],
              ),
            ),
          )),
    );

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => dialog);
  }

  static Dialog alertServicioItems(
      {@required BuildContext context,
        @required String imagen,
        @required String title,
        @required String descripcion,
        @required List listaIt}) {
    final responsive = ResponsiveUtil(context);
    List<Widget> botonesWidget = <Widget>[
      TextButton(
        child: Text(
          'Aceptar',
          style: TextStyle(
            fontSize: 14,
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ];
    dialogoServicioItems(context,
        botonesWidget: botonesWidget,
        widget: alertServicioItemsWidget(
            imagen: imagen,
            title: title,
            descripcion: descripcion,
            listaIt: listaIt));
  }

  static Dialog dialogoServicioItems(BuildContext context,
      {String title = '',
        List<Widget> botonesWidget,
        @required Widget widget}) {
    final responsive = ResponsiveUtil(context);
    double radioBorder = 30.0;
    final dialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radioBorder))),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radioBorder),
              boxShadow: [
                BoxShadow(color: MiUpcAppConfig.colorBarras, blurRadius: 20)
              ]),
          child: Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: responsive.anchoP(100),
                  decoration: BoxDecoration(
                      color: MiUpcAppConfig.colorBarras,
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
                Container(
                  child: Image.asset(MiUpcAppConfig.imgCabecera),
                  width: responsive.ancho,
                  height: responsive.altoP(6),
                ),
                //  SizedBox(height: responsive.altoP(3)),
                Container(
                  child: Image.asset(MiUpcAppConfig.imgLinea),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[widget],
                ),
                // SizedBox(height: responsive.anchoP(3)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: botonesWidget,
                ),
              ],
            ),
          )),
    );

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => dialog);
  }


  static Widget _getDialogoMsjServicioItems(
      {@required BuildContext ctxt,
        @required   imagen,
        @required String title,
        @required String descripcion,
        @required List listaIt}) {
    final responsive = ResponsiveUtil(ctxt);
    //evito mostra el host al usuario
    var imgMemory=null;
    imgMemory =  PhotoHelper.convertStringToUint8List( imagen);
    double anchoTexto = 70;
    return Container(
      height:
      responsive.isVertical() ? responsive.altoP(50) : responsive.altoP(40),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: responsive.altoP(8),
                  height: responsive.altoP(8),
                  child:  imgMemory!=null?Container(
                    height: responsive.altoP(8),
                    width: responsive.altoP(8),
                    child: Image.memory(imgMemory) ,):Container(
                      height: responsive.altoP(8),
                      width: responsive.altoP(8),
                      child:Image.asset(MiUpcAppConfig.imgEscpolicia)
                  ),
                ),
                Container(
                  width: responsive.anchoP(40),
                  child: Text(
                    "  " + title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                )
              ],
            ),
            Divider(
              height: 10.0,
              color: Colors.blueAccent,
            ),
            Text(
              'DESCRIPCIÓN',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Divider(
              height: 10.0,
              color: Colors.transparent,
            ),
            Container(
              width: responsive.anchoP(anchoTexto),
              child: Text(
                descripcion,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
              ),
            ),
            Divider(
              height: 10.0,
              color: Colors.transparent,
            ),
            Text(
              'COMO ACCEDER \n',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Container(
              height: responsive.altoP(20),
              child: SingleChildScrollView(
                child: Column(
                  children: getItems(listaIt, responsive, ctxt),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}


class dialogoMsjItemsWidget extends StatelessWidget {
  final  imagen;
  final String title;
  final List listaIt;

  const dialogoMsjItemsWidget({Key key, this.imagen, this.title, this.listaIt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MiUpcDialogosWidget._getDialogoMsjItems(
        ctxt: context, imagen: imagen, title: title, listaIt: listaIt);
  }
}


class alertServicioItemsWidget extends StatelessWidget {
  final  imagen;
  final String title;
  final String descripcion;
  final List listaIt;

  const alertServicioItemsWidget(
      {Key key, this.imagen, this.title, this.descripcion, this.listaIt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MiUpcDialogosWidget._getDialogoMsjServicioItems(
        ctxt: context,
        imagen: imagen,
        title: title,
        descripcion: descripcion,
        listaIt: listaIt);
  }
}