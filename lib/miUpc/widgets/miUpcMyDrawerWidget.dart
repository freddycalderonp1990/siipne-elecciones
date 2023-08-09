import 'dart:io';

import 'package:flutter/material.dart';

import 'package:share/share.dart';
import 'package:siipnemovil2/appConfig.dart';
import 'package:siipnemovil2/miUpc/apis/apisMiUpc.dart';
import 'package:siipnemovil2/miUpc/sharedPreferences/miUpcPreferenciasUsuario.dart';
import 'package:siipnemovil2/sharePreferences/preferenciasSelectApp.dart';
import 'package:siipnemovil2/utils/utils.dart';

import '../MiUpcAppConfig.dart';

class MiUpcMyDrawerWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> myKey;

  const MiUpcMyDrawerWidget({Key key, this.myKey}) : super(key: key);

  @override
  _MiUpcMyDrawerWidgetState createState() => _MiUpcMyDrawerWidgetState();
}

class _MiUpcMyDrawerWidgetState extends State<MiUpcMyDrawerWidget> {
  final Color primary = Colors.white;

  final Color active = Colors.grey.shade800;

  final Color divider = Colors.grey.shade600;

  final prefs = new MiUpcPreferenciasUsuario();

  String version='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadVersion();
  }

  _loadVersion() async{
    String _version=await UtilidadesUtil.getVersionCodeNameApp();
    setState(() {
      version=_version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildDrawer(context);
  }



  _buildDrawer(BuildContext context) {
    final String image = 'assets/miUpc/img/escpolicia.png';
    final responsive = ResponsiveUtil(context);
    return ClipPath(
      /// ---------------------------
      /// Building Shape for drawer .
      /// ---------------------------
      clipper: OvalRightBorderClipper(),

      /// ---------------------------
      /// Building drawer widget .
      /// ---------------------------
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 50),
          decoration: BoxDecoration(
              color: primary, boxShadow: [BoxShadow(color: Colors.black45)]),
          width: 300,
          child: SafeArea(
            /// ---------------------------
            /// Building scrolling  content for drawer .
            /// ---------------------------
            child:
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      Container(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.power_settings_new,
                            color: Colors.red,
                          ),
                          onPressed: () {
                             prefs.clearDatosUser();
                            //Navigator.pushReplacementNamed(context, AppConfig.acuerdoConfiPage);
                           // exit(0);
                          },
                        ),
                      ),
                    ],),

                  /// ---------------------------
                  /// Building header for drawer .
                  /// ---------------------------

                  Container(
                    height: 130,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [Colors.black54, Colors.blueAccent])),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(image),
                    ),
                  ),
                  SizedBox(height: 5.0),

                  /// ---------------------------
                  /// Building header title for drawer .
                  /// ---------------------------
                  Text(
                    prefs.getnombresMiUpc(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    prefs.getemailMiUpc(),
                    style: TextStyle(color: active, fontSize: 16.0),
                  ),

                  /// ---------------------------
                  /// Building items list  for drawer .
                  /// ---------------------------
                  SizedBox(height: 20.0),
                  _buildDivider(),
                  _buildRow(MiUpcAppConfig.imgPaquitoCovid, "Perfil", onTap: () {
                    widget.myKey.currentState.openEndDrawer();
                    Navigator.of(context).pushNamed(MiUpcAppConfig.ModificarDatosPage);
                  }),
                  _buildDivider(),








                  _buildRow(
                      MiUpcAppConfig.imgRegistrardesaparecido, "Pantalla Inicio",


                      showBadge: true,onTap: () {
                    final prefsSelectApp=new PreferenciasSelectApp();
                    prefsSelectApp.setSelectSiipne(false);
                    prefsSelectApp.setSelecMiUpc(false);

                    //oculta el drawer
                    widget.myKey.currentState.openEndDrawer();


                    UtilidadesUtil.pantallasAbrirNuevaCerrarTodas(context: context,pantalla: AppConfig.pantallaBienvenida);

                  }),
                  _buildDivider(),
                  _buildRow(
                      'assets/miUpc/img/upedificio.png', "Compartir Aplicación",
                      showBadge: true,
                      numNotificaciones:0 , onTap: () {
                    //oculta el drawer
                    Share.share("https://play.google.com/store/apps/details?id=mmeo.system.pne&hl=es");
                    widget.myKey.currentState.openEndDrawer();

                  }),
                  _buildDivider(),
                  Text('Versión: '+version +' '+MiUpcUrlApi.ambiente,style: TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),




            )

            ,
          ),
        ),
      ),
    );
  }
 //https://play.google.com/store/apps/details?id=mmeo.system.pne&hl=es
  /// ---------------------------
  /// Building divider for drawer .
  /// ---------------------------

  Divider _buildDivider() {
    return Divider(
      color: divider,
    );
  }

  /// ---------------------------
  /// Building item  for drawer .
  /// ---------------------------

  Widget _buildRow(String image, String title,
      {bool showBadge = false,
        int numNotificaciones = 0,
        GestureTapCallback onTap}) {
    final TextStyle tStyle = TextStyle(color: active, fontSize: 15.0);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: [
            Container(
              height: 20,
              child: Image.asset(
                image,
              ),
            ),
            SizedBox(width: 10.0),
            Flexible(
              child: Text(
                title,
                style: tStyle,
              ),
            ),


            // se dibuja las notificaciones
            if (numNotificaciones > 0)
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.all(2.5),
                  child: Material(
                    color: Colors.blueAccent,
                    elevation: 5.0,
                    shadowColor: Colors.black,
                    borderRadius: BorderRadius.circular(5.0),
                    child: Container(
                      width: 25,
                      height: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: MiUpcAppConfig.colorBarras,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(
                        numNotificaciones.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// ------------------
/// for shaping the drawer. You can customize it as your own
/// ------------------
class OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width - 50, 0);
    path.quadraticBezierTo(
        size.width, size.height / 4, size.width, size.height / 2);
    path.quadraticBezierTo(size.width, size.height - (size.height / 4),
        size.width - 60, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
