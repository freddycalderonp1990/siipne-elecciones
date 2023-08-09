part of 'pages.dart';

class ConfigAppPage extends StatefulWidget {
  @override
  _ConfigAppPageState createState() => _ConfigAppPageState();
}

class _ConfigAppPageState extends State<ConfigAppPage> {
  final _formKey = GlobalKey<FormState>();
  var controllerVersionAndroid = new TextEditingController();
  var controllerVersionIos = new TextEditingController();

  var controllerCodeAndroid = new TextEditingController();
  var controllerCodeIos = new TextEditingController();

  var sizeTxt;

  bool peticionServer = false;
  bool cargaInicial = true;

  ConfigAppApi mConfigAppApi=new ConfigAppApi();

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil(context);
    sizeTxt = responsive.anchoP(AppConfig.tamTexto + 2.0);

    return WorkAreaPageWidget(
      btnAtras: true,
      peticionServer: peticionServer,
      title: "Configuraciones",
      contenido: [
        _getContenido(responsive),
      ],
    );
  }

  _getContenido(ResponsiveUtil responsive) {

    Widget wgAndroid=ContenedorDesingWidget(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: <Widget>[

            Row(
              children: [
                Container(
                  width: responsive.anchoP(40),
                  child: Column(children: [
                    TituloTextWidget(
                      title: "ANDROID",
                    ),
                    ImputTextWidget(
                      controller: controllerCodeAndroid,
                      elevation: 1,
                      label: "Code",
                      fonSize: sizeTxt,
                      hitText: "Code",
                      validar: (String text) {
                        if (text.length >= 1) {
                          return null;
                        }
                        return "Error";
                      },
                    )
                  ],),
                ),
                Container(
                  width: responsive.anchoP(40),
                  child:  Column(children: [
                    TituloTextWidget(
                      title: "IOS",
                    ),
                    ImputTextWidget(
                      controller: controllerCodeIos,
                      elevation: 1,
                      label: "Code",
                      fonSize: sizeTxt,
                      hitText: "Code",
                      validar: (String text) {
                        if (text.length >= 1) {
                          return null;
                        }
                        return "Error";
                      },
                    )
                  ],),
                ),
              ],
            ),
            SizedBox(
              height: responsive.altoP(2),
            ),
          ],
        ));


    Widget desing = Column(
      children: <Widget>[
        Form(
            key: _formKey,
            child: Column(

              children: [
              TituloDetalleTextWidget(title: "Hora Server",detalle: "02:00:00",mostrarLinea: true,mostrarBorder: true,),
              wgAndroid,

            ],)),
        SizedBox(
          height: responsive.altoP(4),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: responsive.ancho - 80,
            minWidth: responsive.ancho - 80,
          ),
          child: BotonesWidget(
            iconData: Icons.arrow_forward,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            title: VariablesUtil.GUARDAR,
            onPressed: () {
              _setConfigApp();
            },
          ),
        ),
      ],
    );

    return desing;
  }

  _setConfigApp() async{
    setState(() {
      peticionServer=true;
    });

    await mConfigAppApi.setConfigApp(codeIos: controllerCodeIos.text, codeAndroid: controllerCodeAndroid.text, context: context);
    setState(() {
      peticionServer=false;
    });

  }
}
