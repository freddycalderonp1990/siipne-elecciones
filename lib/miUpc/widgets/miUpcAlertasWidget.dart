part of  'miUpcCustomWidgets.dart';



class MiUpcAlertasWidget {
  static Future alerta(
      {@required BuildContext ctxt,
      @required String title,
      @required String msj,
      VoidCallback funcion}) {
    return showDialog(
        context: ctxt,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(msj),
            actions: <Widget>[
              TextButton(
                child: Text('ACEPTAR'),
                onPressed: () => Navigator.of(context).pop(),
              ),

            ],
          );
        });
  }

 //////////////////////////////////////////////////////////////////////////////


  static Future alertaC(
      {@required BuildContext ctxt,
        @required String title,
        @required String msj,
        @required  VoidCallback funcion}) {
    return showDialog(
        context: ctxt,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(msj),
            actions: <Widget>[
              TextButton(
                child: Text('ACEPTAR'),
                onPressed: () {
                 funcion;
                 Navigator.of(context).pop();
                },
              ),

            ],
          );
        });
  }

  //////////////////////////////////////////////////////////////////////////////////
  static Future alertaCovid(
      {@required BuildContext ctxt,
      @required String title,
      @required String msj,
      VoidCallback funcion}) {
    return showDialog(
        context: ctxt,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(msj),
            actions: <Widget>[
              TextButton(
                child: Text('Aceptar'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        });
  }

  static Future alertaBotones(
      {@required BuildContext ctxt,
      @required String title,
      @required String msj,
      VoidCallback funcion}) {
    return showDialog(
        context: ctxt,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            content: Text(
              msj,
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
            ),
            actions: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    TextButton(
                      child: Text('Aceptar'),
                      onPressed: () => Navigator.of(context).pop(),

                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  /*ALERTAS PARA DETALLE DE SERVICIOS POLCO
  * */
  static Future alertaDetalleServicos({
    @required BuildContext ctxt,
    @required String imagen,
    @required String title,
    @required String descripcion,
    @required List listaIt,
  }) {
    final responsive = ResponsiveUtil(ctxt);
    return showDialog(
        context: ctxt,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Container(
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Image.asset(MiUpcAppConfig.imgCabecera),
                      width: responsive.altoP(45),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: responsive.altoP(8),
                        height: responsive.altoP(8),
                        child: Image.network(MiUpcUrlApi.pathImagen + imagen),
                      ),
                      Flexible(
                        child: Card(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "  " + title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 10.0,
                    color: Colors.blueAccent,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        'DESCRIPCIÓN',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Divider(
                        height: 10.0,
                        color: Colors.transparent,
                      ),
                      Text(
                        descripcion,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 15),
                      ),
                      Divider(
                        height: 10.0,
                        color: Colors.transparent,
                      ),
                      Text(
                        'COMO ACCEDER \n',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Container(
                        child: SingleChildScrollView(
                          child: Container(
                            child: Column(
                              children: getItems(listaIt, responsive, ctxt),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Aceptar'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        });
  }

  static Future alertaDetalleItems({
    @required BuildContext ctxt,
    @required String imagen,
    @required String title,
    @required List listaIt,
  }) {
    final responsive = ResponsiveUtil(ctxt);
    return showDialog(
        context: ctxt,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Container(
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      child: Image.asset(MiUpcAppConfig.imgCabecera),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: responsive.altoP(7),
                        height: responsive.altoP(7),
                        child: Image.network(MiUpcUrlApi.pathImagen + imagen),
                      ),
                      Flexible(
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "     " + title,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
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
                    child: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          children: getItems(listaIt, responsive, ctxt),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Aceptar'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        });
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
            Flexible(
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

///////////////////////////////////////////////////////////////////ALERTA REGISTRO

///////////////////////////////////////////////////////////////////////
  static Future alertaModifica({
    @required BuildContext ctxt,
    @required String nombre,
    @required String cedula,
    @required String celular,
  }) {
    final responsive = ResponsiveUtil(ctxt);
    return showDialog(
        context: ctxt,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)),
            backgroundColor: Colors.transparent,
            content: Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    height: responsive.altoP(65.0),
                    color: Colors.white,
                    child: Image.asset(MiUpcAppConfig.imgFondo),
                  ),
                  SingleChildScrollView(child: Column(
                    children: <Widget>[
                      Center(
                        child: Container(
                          child: Image.asset(MiUpcAppConfig.imgCabecera),
                          width: responsive.altoP(45),
                        ),
                      ),
                      Divider(
                        color: Colors.blueAccent,
                        height: 5.0,
                      ),
                      Text(
                        'REGISTRO ACTULIZADO CORRECTAMENTE......!!!!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Divider(
                        color: Colors.transparent,
                        height: 15.0,
                      ),
                      Text(
                        'Ya Puedes Utilizar el Aplicativo Mi Upc',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Divider(
                        color: Colors.transparent,
                        height: 15.0,
                      ),
                      Text(
                        'Tú Registro ha Sido Realizado con los Siguientes datos',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Divider(
                        color: Colors.transparent,
                        height: 8.0,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'NOMBRES USUARIO: ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          Expanded(child: Text(
                            nombre,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 12),
                          ),),
                        ],
                      ),
                      Divider(
                        color: Colors.transparent,
                        height: 8.0,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'DOCUEMNTO DE IDENTIDAD: ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          Expanded(child: Text(
                            cedula,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 12),
                          ),),
                        ],
                      ),
                      Divider(
                        color: Colors.transparent,
                        height: 8.0,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'CELULAR:',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          Text(
                            celular,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 12),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Center(
                            child: Container(
                              child: Image.asset('assets/img/paquito.png'),
                              width: responsive.altoP(15),
                            ),
                          ),
                          Divider(
                            color: Colors.transparent,
                            height: 8.0,
                          ),
                          Text(
                            'INFORMATE, LOCALIZA Y REGISTRA',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          TextButton(
                            child: Text(
                              'Aceptar',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: Colors.blueAccent),
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    ],
                  ),),
                ],
              ),
            ),
          );
        });
  }



}
