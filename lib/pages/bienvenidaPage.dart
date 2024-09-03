part of 'pages.dart';

class BienvenidaPage extends StatefulWidget {
  const BienvenidaPage({Key key}) : super(key: key);

  @override
  _BienvenidaPageState createState() => _BienvenidaPageState();
}

class _BienvenidaPageState extends State<BienvenidaPage> {
  final prefs = new PreferenciasSelectApp();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UtilidadesUtil.getTheme();
    print("BienvenidaPage - elecciones");
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      verificarSelectApp();
    });

    return WorkAreaPageWidget(
      title: VariablesUtil.POLICIANACIONAL,
      contenido: [
        SizedBox(
          height: responsive.altoP(3),
        ),
        Container(
          child:
              Image.asset(AppConfig.escudopolicia, width: responsive.altoP(10)),
        ),
        ContenedorDesingWidget(
          anchoPorce: 90,
          margin: EdgeInsets.all(5),
          child: DetalleTextWidget(
            textAlign: TextAlign.justify,
            todoElAncho: true,
            padding: EdgeInsets.all(20),
            detalle:
                "Nuestro compromiso es el trabajo profesional de hombres y mujeres policías, mediante "
                "la prestación de un servicio efectivo y el respeto de los derechos humanos, que se evidencia"
                " en la confianza, transparencia, credibilidad y legitimidad ante la ciudadanía; a través, del "
                "control y prevención del delito, mediante el Componente de la Gestión Preventiva, servicio a "
                "la comunidad, investigación de la infracción, inteligencia anti delincuencial, gestión operativa,"
                " control y evaluación.",
          ),
        ),
        ContenedorDesingWidget(
          anchoPorce: 90,
          margin: EdgeInsets.all(1),
          child: Container(
            padding: EdgeInsets.all(10),
            child: TituloTextWidget(
              textAlign: TextAlign.center,
              title: '¿Es usted un Servidor Policial?',
            ),
          ),
        ),
        SizedBox(
          height: responsive.altoP(3),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 5),
            Expanded(
                child: BotonesWidget(
              title: VariablesUtil.SI,
              onPressed: () {
                prefs.setSelectSiipne(true);
                prefs.setSelecMiUpc(false);
                UtilidadesUtil.pantallasAbrirNuevaCerrarTodas(
                    context: context, pantalla: AppConfig.pantallaInicioRapido);
              },
            )),
            SizedBox(width: 5),
            Expanded(
                child: BotonesWidget(
              title: VariablesUtil.NO,
              onPressed: () {
                prefs.setSelectSiipne(false);
                prefs.setSelecMiUpc(true);

                registroUsuModFalse();
              },
            )),
            SizedBox(width: 5),
          ],
        )
      ],
    );
  }

  registroUsuModFalse() async {
    final prefs = new MiUpcPreferenciasUsuario();

    if (prefs.getnombreUsuarioMiUpc().length > 4) {
      print("ssisisisisisi");
      Navigator.pushReplacementNamed(context, MiUpcAppConfig.menuPrincipalPage);
      return;
    }

    String json =
        '{"datoPer":["Correcto","JAIRO POZO CANACUAN","10000","146270"],"code":"0"}';

    RegistroUsuarioModel registroUsuarioModel =
        registroUsuarioModelFromJson(json);

    List<String> datosRegistro = registroUsuarioModel.datoPer;

    String nombres = datosRegistro[1].toString();

    String id = datosRegistro[2].toString();
    String idGenPersona = datosRegistro[3].toString();

    prefs.setDatosUser(
        idGenPersonaMiUpc: idGenPersona,
        nombreUser: "",
        cedulaMiUpcV: "",
        emailMiUpcV: "",
        nombresMiUpcV: "",
        celularMiUpc: "",
        idUsuarioMiUpc: id,
        imeiMiUpc: "",
        isnacionalMiUpc: true);

    Navigator.pushReplacementNamed(context, MiUpcAppConfig.menuPrincipalPage);
  }

  verificarSelectApp() {
    if (prefs.selecMiUpc() == true) {
      UtilidadesUtil.pantallasAbrirNuevaCerrarTodas(
          context: context, pantalla: MiUpcAppConfig.splashPage);
    } else if (prefs.selecSiipne() == true) {
      UtilidadesUtil.pantallasAbrirNuevaCerrarTodas(
          context: context, pantalla: AppConfig.pantallaInicioRapido);
    }
  }
}
