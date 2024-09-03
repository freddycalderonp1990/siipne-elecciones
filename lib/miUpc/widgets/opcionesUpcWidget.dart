
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:siipnemovil2/miUpc/MiUpcAppConfig.dart';
import 'package:siipnemovil2/miUpc/apis/apisMiUpc.dart';
import 'package:siipnemovil2/miUpc/apis/miUpcConstApi.dart';
import 'package:siipnemovil2/miUpc/sharedPreferences/miUpcPreferenciasUsuario.dart';
import 'package:siipnemovil2/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class OpcionesUpcWidget {
  static Future opcionUpc({
    @required BuildContext ctxt,
    @required String nombreUpc,
    @required String direccion,
    @required String mail,
    @required String telefono,
    @required String distancia,
    @required String latitudIni,
    @required String longitudIni,
    @required String latitudUpc,
    @required String longitudUpc,
  }) {
    final responsive = ResponsiveUtil(ctxt);
    return showDialog(
        context: ctxt,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)),
            backgroundColor: Colors.white,
            title: Stack(
              children: <Widget>[
                Center(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 1.0, horizontal: 2.0),
                    child: Image.asset(MiUpcAppConfig.imgCabecera2),
                    width: responsive.altoP(15),
                  ),
                ),
                InkWell(
                  onTap: () {
                    atras(context);
                  },
                  child: Image.asset(
                    MiUpcAppConfig.imgAtras,
                    width: responsive.altoP(4),
                  ),
                ),
              ],
            ),
            content: Container(
              height: responsive.altoP(40),
              width: responsive.ancho,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Divider(
                      color: Colors.blue,
                      height: 5.0,
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'UPC - ' + nombreUpc.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.blue[900]),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.blue,
                            height: 5.0,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'Dirección:  ',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              Flexible(
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        direccion.toString(),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'Teléfono:  ',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              Flexible(
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        telefono.toString(),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            textDirection: TextDirection.ltr,
                            children: <Widget>[
                              Text(
                                'Mail:  ',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              Flexible(
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        mail.toString(),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.blue,
                            height: 3.0,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'Distancia a la UPC:  ',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              Flexible(
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        distancia.toString() + '  mtrs.',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Material(
                          // needed
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => rutaGoogleMaps(
                                latitudIni,
                                longitudIni,
                                latitudUpc,
                                longitudUpc,
                                nombreUpc.toString(),
                                context),
                            // needed
                            child: Image.asset(
                              MiUpcAppConfig.imgRuta,
                              width: responsive.altoP(10),
                              //   fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 35.0,
                        ),
                        Material(
                          // needed
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              if (telefono.trim() != MiUpcAppConfig.num911) {
                                llamarTelefonoUpc(
                                    telefono, nombreUpc.toString(), context);
                              } else {
                                getMsj2(
                                    ctxt: ctxt,
                                    distancia: distancia,
                                    nombreUpc: nombreUpc,
                                    latitudIni: latitudIni,
                                    latitudUpc: latitudUpc,
                                    longitudIni: longitudIni,
                                    longitudUpc: longitudUpc);
                              }
                            },
                            // needed
                            child: Image.asset(
                              MiUpcAppConfig.imgTelefono,
                              width: responsive.altoP(10),
                              // fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Ruta al UPC',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.blue[900]),
                        ),
                        SizedBox(
                          width: 60.0,
                        ),
                        Text(
                          'Llamar al UPC',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.blue[900]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  static getMsj2({
    @required BuildContext ctxt,
    @required String nombreUpc,
    @required String distancia,
    @required String latitudIni,
    @required String longitudIni,
    @required String latitudUpc,
    @required String longitudUpc,
  }) {
    final responsive = ResponsiveUtil(ctxt);
    return showDialog(
        context: ctxt,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)),
            backgroundColor: Colors.white,
            title: Stack(
              children: <Widget>[
                Center(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 1.0, horizontal: 2.0),
                    child: Image.asset(MiUpcAppConfig.imgCabecera),
                    width: responsive.altoP(15),
                  ),
                ),
                InkWell(
                  onTap: () {
                    atras(context);
                  },
                  child: Image.asset(
                    MiUpcAppConfig.imgAtras,
                    width: responsive.altoP(4),
                  ),
                ),
              ],
            ),
            content: Container(
              height: responsive.altoP(40),
              width: responsive.ancho,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Divider(
                      color: Colors.blue,
                      height: 5.0,
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'UPC - ' + nombreUpc.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.blue[900]),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.blue,
                            height: 5.0,
                          ),
                          Text(
                            "No cuenta con número convencional por favor, acércate de manera presencial, si es una emergencia llama al 911",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14),
                          ),
                          Divider(
                            color: Colors.blue,
                            height: 3.0,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'Distancia a la UPC:  ',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              Flexible(
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        distancia.toString() + '  mtrs.',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Material(
                          // needed
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => rutaGoogleMaps(
                                latitudIni,
                                longitudIni,
                                latitudUpc,
                                longitudUpc,
                                nombreUpc.toString(),
                                context),
                            // needed
                            child: Image.asset(
                              MiUpcAppConfig.imgRuta,
                              width: responsive.altoP(10),
                              //   fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 35.0,
                        ),
                        Material(
                          // needed
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              UtilidadesUtil.lanzarLlamada(MiUpcAppConfig.num911);

                            },
                            // needed
                            child: Image.asset(
                              MiUpcAppConfig.imgTelefono,
                              width: responsive.altoP(10),
                              // fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Ruta al UPC',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.blue[900]),
                        ),
                        SizedBox(
                          width: 60.0,
                        ),
                        Text(
                          'Llamar al '+MiUpcAppConfig.num911,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.blue[900]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  static void atras(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  static void llamarTelefonoUpc(
      String telf, String nom, BuildContext ctx) async {
    String url = 'tel:' + telf;
    final prefs = new MiUpcPreferenciasUsuario();
    if (await canLaunch(url)) {
      await launch(url);

      String _ip = await  UtilidadesUtil.getIp();
      MiUpcAuditoriaApi auditoria = new MiUpcAuditoriaApi();
      auditoria.grabaAccion(MiUpcConstApi.latitud, MiUpcConstApi.longitud, 'LLAMADA',
          'UPC-' + nom + "TELEFONO:" + telf, prefs.getidUsuarioMiUpc(), _ip, ctx);
    } else {
      throw 'Could not launch $url';
    }
  }

  static void rutaGoogleMaps(
      String latitudIni,
      String longitudIni,
      String latitudUpc,
      String longitudUpc,
      String nom,
      BuildContext ctx) async {
    final prefs = new MiUpcPreferenciasUsuario();
    // String url ="https://maps.google.com/maps/search/?api=xfSpD_S_ZVzf0fv1p6JfVcMxjaB8&query="+latitud+","+longitud;
    String url = 'https://www.google.com/maps/dir/?api=1&origin=' +
        latitudIni +
        ',' +
        longitudIni +
        '&destination=' +
        latitudUpc +
        ',' +
        longitudUpc +
        '&travelmode=driving&dir_action=navigate';
    //  _launchURL(url);
    if (await canLaunch(url)) {
      print("Can launch");
      await launch(url);

      String _ip = await  UtilidadesUtil.getIp();
      MiUpcAuditoriaApi auditoria = new MiUpcAuditoriaApi();
      auditoria.grabaAccion(MiUpcConstApi.latitud, MiUpcConstApi.longitud, 'CONSULTA',
          'UBICACION UPC-' + nom, prefs.getidUsuarioMiUpc(), _ip, ctx);
    } else {
      print("Could not launch");
      throw 'Could not launch Maps';
    }
  }
}
