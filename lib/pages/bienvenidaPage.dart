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
          child: Image.asset(AppConfig.escudopolicia,
              width: responsive.altoP(10)),
        ),

        ContenedorDesingWidget(
          anchoPorce: 90,
          margin: EdgeInsets.all(5),
          child: DetalleTextWidget(
            textAlign: TextAlign.justify,
          todoElAncho: true,
            padding: EdgeInsets.all(20),
            detalle:
                "Nuestro compromiso es el trabajo profesional de hombres y mujeres policías mediante la prestación de un servicio efectivo y el respeto de los derechos humanos, que se evidencia en la confianza, transparencia, credibilidad y legitimidad ante la ciudadanía, a través del control y prevención del delito mediante los Componentes de la gestión preventiva: servicio a la comunidad, investigación de la infracción, inteligencia anti delincuencial, gestión operativa, control y evaluación.",
          ),
        ),

                ContenedorDesingWidget(
                  anchoPorce: 90,
                  margin: EdgeInsets.all(1),
                  child:  Container(
                    padding: EdgeInsets.all(10),
                    child: TituloTextWidget(

                    textAlign: TextAlign.center,
                    title: '¿Es usted un Servidor Policial?',

                  ),),),


        SizedBox(
          height: responsive.altoP(3),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BotonesWidget(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              title: VariablesUtil.SI,
              onPressed: () {
                prefs.setSelectSiipne(true);
                prefs.setSelecMiUpc(false);
                UtilidadesUtil.pantallasAbrirNuevaCerrarTodas(
                    context: context, pantalla: AppConfig.pantallaInicioRapido);
              },
            ),
            BotonesWidget(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              title: VariablesUtil.NO,
              onPressed: () {
                prefs.setSelectSiipne(false);
                prefs.setSelecMiUpc(true);
                UtilidadesUtil.pantallasAbrirNuevaCerrarTodas(
                    context: context, pantalla: MiUpcAppConfig.splashPage);
              },
            )
          ],
        )
      ],
    );
  }




  verificarSelectApp(){

    if(prefs.selecMiUpc()==true ){
      UtilidadesUtil.pantallasAbrirNuevaCerrarTodas(
          context: context, pantalla: MiUpcAppConfig.splashPage);
    }
    else if(prefs.selecSiipne()==true){
      UtilidadesUtil.pantallasAbrirNuevaCerrarTodas(
          context: context, pantalla: AppConfig.pantallaInicioRapido);
    }


  }
}
