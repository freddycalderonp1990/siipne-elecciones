part of '../pages.dart';

class VerificaOpertaivoRecintoAbiertoPage extends StatefulWidget {
  @override
  _VerificaOpertaivoRecintoAbiertoPageState createState() =>
      _VerificaOpertaivoRecintoAbiertoPageState();
}

class _VerificaOpertaivoRecintoAbiertoPageState
    extends State<VerificaOpertaivoRecintoAbiertoPage> {
  UserProvider _UserProvider;
  RecintoAbiertoProvider _RecintoProvider;
  bool peticionServer = false;
  bool cargaInicial = true;

  String totalPersonal = "0";
  String totalNovedades = "0";

  RecintosElectoralesApi _recintosElectoralesApi = new RecintosElectoralesApi();
  NovedadesElectoralesApi _novedadesElectoralesApi =
      new NovedadesElectoralesApi();

  String idDgoCreaOpReci, nombreRecinto = "", encargadoRecinto, idDgoReciElect;

  double separacionBtnMenu = 1.5;
  Widget wgMenu = Container();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("VerificaOpertaivoRecintoAbiertoPage - elecciones");
    UtilidadesUtil
        .getTheme(); //cambia el color de texto de barra superios del telefono
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //Variable para obtener el tamaño de la pantalla

    final responsive = ResponsiveUtil(context);

    _UserProvider = UserProvider.of(context);
    _RecintoProvider = RecintoAbiertoProvider.of(context);

    _verificarPersonalEncargadoAsignadoRecElectPorIdGenPersona(
        _UserProvider.getUser.idGenPersona, responsive);
    return WorkAreaPageWidget(
      peticionServer: peticionServer,
      title: nombreRecinto != "" ? nombreRecinto : "VERIFICAR OPERATIVOS",
      imgPerfil: _UserProvider.getUser.foto,
      contenido: <Widget>[],
    );
  }

//Metodo para saber si el usuario esta asignado a un recinto electoral
  //en caso de true es personal asignado y no jefe
  _verificarPersonalEncargadoAsignadoRecElectPorIdGenPersona(
      String idGenPersona, ResponsiveUtil responsive) async {
    try {
      if (!cargaInicial) return;
      if (peticionServer) return;

      setState(() {
        peticionServer = true;
      });
      RecintosElectoralesAbiertos _RecintosElectoralesAbiertos =
          await _recintosElectoralesApi
              .verificarPersonalEncargadoAsignadoRecElectPorIdGenPersona(
                  context: context, idGenPersona: idGenPersona);

      //NO HAY NINGUN ABIERTO
      if (_RecintosElectoralesAbiertos.idDgoCreaOpReci == "0") {
        //NOS DIRIGUIMOS AL MENU DE SELECCIONAR OPERATIVO

        _RecintoProvider.setRecinto(new RecintosElectoralesAbiertos());
        UtilidadesUtil.pantallasAbrirNuevaCerrarTodas(
            context: context, pantalla: AppConfig.pantallaMenuCrearCodigo);
      } else {
        //Existe un Operativo Abierto
        idDgoCreaOpReci = _RecintosElectoralesAbiertos.idDgoCreaOpReci;
        nombreRecinto = _RecintosElectoralesAbiertos.nomRecintoElec;
        encargadoRecinto = _RecintosElectoralesAbiertos.encargado;
        idDgoReciElect = _RecintosElectoralesAbiertos.idDgoReciElect;
        _RecintoProvider.setRecinto(_RecintosElectoralesAbiertos);
        print(
            'Set datos Recinto ${_RecintoProvider.getRecintoAbierto.idDgoReciElect}');
        //Hay Abierto Verifico si es Recinto
        if (_RecintosElectoralesAbiertos.isRecinto) {
          //Menu Recintos Electorales
          print('entroaquii');
          UtilidadesUtil.pantallasAbrirNuevaCerrarTodas(
              context: context,
              pantalla: AppConfig.pantallaMenuRecintoElectoral);
        } else {
          //Menu Unidades Policiales u Otros
          UtilidadesUtil.pantallasAbrirNuevaCerrarTodas(
              context: context,
              pantalla: AppConfig.pantallaMenuUnidadesPolicialesOtros);
        }
      }
    } catch (e) {}
  }

  _cerrarSession() {
    //Aquí (Route <dynamic> route) => false se asegurará de que se eliminen todas las rutas antes de hacer push de la ruta .
    Navigator.of(context).pushNamedAndRemoveUntil(
        AppConfig.pantallaInicioRapido, (Route<dynamic> route) => false);
  }
}
