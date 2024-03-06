part of '../pages.dart';

class MenuCrearCodigoPage extends StatefulWidget {
  @override
  _MenuCrearCodigoPageState createState() => _MenuCrearCodigoPageState();
}

class _MenuCrearCodigoPageState extends State<MenuCrearCodigoPage> {
  UserProvider _UserProvider;
  RecintoAbiertoProvider _RecintoProvider;

  ProcesoOperativoProvider _ProcesoOperativoProvider;

  bool peticionServer = false;
  bool cargaInicial = true;

  String totalPersonal = "0";
  String totalNovedades = "0";

  final prefs = new PreferenciasUsuario();

  RecintosElectoralesApi _recintosElectoralesApi = new RecintosElectoralesApi();
  NovedadesElectoralesApi _novedadesElectoralesApi =
      new NovedadesElectoralesApi();

  String idDgoCreaOpReci, nombreRecinto = "", encargadoRecinto, idDgoReciElect;

  double separacionBtnMenu = 1.5;
  Widget wgMenu = Container();
  var sizeTxt;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UtilidadesUtil
        .getTheme(); //cambia el color de texto de barra superios del telefono
    print("MenuCrearCodigoPage - elecciones");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //Variable para obtener el tamaño de la pantalla

    final responsive = ResponsiveUtil(context);
    sizeTxt = responsive.anchoP(AppConfig.tamTexto + 2.0);

    _UserProvider = UserProvider.of(context);
    _RecintoProvider = RecintoAbiertoProvider.of(context);
    _ProcesoOperativoProvider = ProcesoOperativoProvider.of(context);

    String Bienvenido = _UserProvider.getUser.sexo == 'HOMBRE'
        ? VariablesUtil.Bienvenido
        : VariablesUtil.Bienvenida;

    return WorkAreaPageWidget(
      peticionServer: peticionServer,
      title: "MENÚ PRINCIPAL",
      imgPerfil: _UserProvider.getUser.foto,
      contenido: <Widget>[
        Container(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(AppConfig.radioBordecajas),
                ),
                  child: Text(
                    Bienvenido + _UserProvider.getUser.apenom,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        shadows: [
                          Shadow(
                            blurRadius: 20,
                            color: Colors.white,
                            offset: Offset(2, 2),
                          ),
                          Shadow(
                            blurRadius: 20,
                            color: Colors.white,
                            offset: Offset(-2, 2),
                          ),
                        ],
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: responsive.anchoP(3.8)),
                  )),
              SizedBox(
                height: responsive.altoP(2),
              ),
              _getMenu(responsive)
            ],
          ),
        ),
        Container(
          width: responsive.anchoP(30),
          child: BtnIconWidget(
            iconData: Icons.exit_to_app,
            title: VariablesUtil.Salir,
            colorTextoIcon: Colors.white,


            onTap: () => _cerrarSession(),
          ),
        ),
        SizedBox(
          height: responsive.altoP(3.5),
        ),
      ],
    );
  }

  _cerrarSession() {
    //Aquí (Route <dynamic> route) => false se asegurará de que se eliminen todas las rutas antes de hacer push de la ruta .
    Navigator.of(context).pushNamedAndRemoveUntil(
        AppConfig.pantallaInicioRapido, (Route<dynamic> route) => false);

    //Navigator.pushReplacementNamed(context, AppConfig.pantallaLogin);
  }

  _getMenu(ResponsiveUtil responsive) {
    return Column(
      children: [
        BtnMenuWidget(
          colorFondo: Colors.white,
            img: AppConfig.icon_abrir_rec_elec,
            titlte: VariablesUtil.CREARCODIGO,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VerificarGpsPage(
                          msj: "", pantalla: selectProcesosOperativosPage())));
            }),
        SizedBox(
          height: responsive.altoP(separacionBtnMenu),
        ),
        BtnMenuWidget(
            colorFondo: Colors.white,
            img: AppConfig.icon_registrarse_rec_elect,
            titlte: VariablesUtil.ANEXARSE,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          VerificarGpsPage(pantalla: AnexarsePage())));
            }),
        SizedBox(
          height: responsive.altoP(separacionBtnMenu),
        ),
        _getConfig(responsive),
        SizedBox(
          height: responsive.altoP(separacionBtnMenu),
        ),
      ],
    );
  }

  Widget _getConfig(ResponsiveUtil responsive) {
    if (prefs.getUser().toUpperCase() != "CPFN1206762401") {
      return Container();
    }

    return BtnMenuWidget(

        img: AppConfig.icon_clave,
        titlte: "CONFIGURACIONES",
        onTap: () {
          Navigator.pushNamed(context, AppConfig.pantallaConfigApp);
        });
  }
}
