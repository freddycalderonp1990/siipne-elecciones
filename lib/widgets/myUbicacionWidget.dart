part of 'customWidgets.dart';

class MyUbicacionWidget extends StatefulWidget {

  final FrameCallback callback;
  final bool mostraUbicacion;
  const MyUbicacionWidget({Key key, this.callback, this.mostraUbicacion=false}) : super(key: key);
  @override
  _MyUbicacionWidgetState createState() => _MyUbicacionWidgetState();
}
typedef FrameCallback = void Function(Duration timeStamp);

class _MyUbicacionWidgetState extends State<MyUbicacionWidget> {
  //CONFIGURACIONES
  final anchoContenedor = AppConfig.anchoContenedor;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  UserProvider _UserProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(context.bloc!=null) {
      context.bloc<MiUbicacionBloc>().iniciarSeguimiento();
    }
    UtilidadesUtil.getTheme();
  }

  @override
  void dispose() {
    if(context!=null &&  context?.bloc!=null ){


      context?.bloc<MiUbicacionBloc>()?.cancelarSeguimiento();

    }

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {


    _UserProvider = UserProvider.of(context);

    return cabecera(context);
  }

  Widget cabecera(BuildContext context) {
    final responsive = ResponsiveUtil(context);

    return  ContenedorDesingWidget(
        anchoPorce: anchoContenedor,

        child: BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
            builder: (context, state) => getUbicacion(responsive, state)));
  }

  Widget getUbicacion(ResponsiveUtil responsive, MiUbicacionState state) {
    if (!state.existeUbicacion)
      return Center(child: Text('Obteniendo Ubicación...'));


    print("actualizaa");
    _UserProvider.getUser.ubicacionSeleccionada = state.ubicacion;


    String latitud =
    _UserProvider.getUser.ubicacionSeleccionada.latitude.toString();
    String longitud =
    _UserProvider.getUser.ubicacionSeleccionada.longitude.toString();

    WidgetsBinding.instance.addPostFrameCallback(
      widget.callback

    );

    return widget.mostraUbicacion? SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          Container(
            width: responsive.anchoP(anchoContenedor),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Icon(
                    Icons.location_on_outlined,
                    color: Colors.red,
                    size: responsive.isVertical()
                        ? responsive.altoP(2)
                        : responsive.anchoP(5),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 5),
                  child: Text(
                    VariablesUtil.Ubicacion,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: responsive.anchoP(AppConfig.tamTextoTitulo)),
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: responsive.anchoP(15.5),
                            child: Text(
                              "Latitud: ",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                  responsive.anchoP(AppConfig.tamTexto)),
                            ),
                          ),
                          Text(
                            latitud,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                responsive.anchoP(AppConfig.tamTexto)),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: responsive.anchoP(15.5),
                            child: Text(
                              "Longitud: ",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                  responsive.anchoP(AppConfig.tamTexto)),
                            ),
                          ),
                          Text(
                            longitud,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                responsive.anchoP(AppConfig.tamTexto)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: responsive.anchoP(1),
                ),
              ],
            ),
          ),
          SizedBox(
            height: responsive.altoP(0.4),
          )
        ],
      ),
    ):Container();
  }

}
