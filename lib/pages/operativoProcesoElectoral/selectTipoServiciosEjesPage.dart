part of '../pages.dart';

class SelectTipoServiciosEjesPage extends StatefulWidget {
  @override
  _SelectTipoServiciosEjesPageState createState() => _SelectTipoServiciosEjesPageState();
}

class _SelectTipoServiciosEjesPageState extends State<SelectTipoServiciosEjesPage> {

  var peticionServer = false;
  TipoEjesActivos _TipoEjesActivos=new TipoEjesActivos() ;

  UserProvider _UserProvider;
  ProcesoOperativoProvider _ProcesoOperativoProvider;


  bool cargaInicial = true;


  TiposEjesApi _TiposEjesApi=new TiposEjesApi();


  //CONFIGURACIONES
  final anchoContenedor = AppConfig.anchoContenedor;
  final anchoContenedorHijos = AppConfig.anchoContenedorHijos;
  final paddingContenido = 10.0;
  double separacionBtnMenu = 1.5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.bloc<MiUbicacionBloc>().iniciarSeguimiento();
    UtilidadesUtil.getTheme();
  }

  @override
  void dispose() {

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil(context);
    _UserProvider = UserProvider.of(context);
    _ProcesoOperativoProvider = ProcesoOperativoProvider.of(context);

    String Bienvenido = _UserProvider.getUser.sexo == 'HOMBRE'
        ? VariablesUtil.Bienvenido
        : VariablesUtil.Bienvenida;
    _getTipoEjesActivosEnProcesoOperativos();

    return WorkAreaPageWidget(
      btnAtras:true,
        mostrarVersion: false,
        peticionServer: peticionServer,
        title: 'TIPO DE SERVICIO',
        sizeTittle: 5,
    contenido: [

      TituloTextWidget(title:"OPERATIVO:"+ _ProcesoOperativoProvider.getProcesosOperativo.descProcElecc ,textAlign: TextAlign.center,colorTitulo: Colors.white, ),

      DetalleTextWidget(detalle: "Seleccione el servicio al que fue designado. ",padding: EdgeInsets.all(10),todoElAncho: true,colorDetalle: Colors.black,),
      _TipoEjesActivos .tipoEjeRecintos?  BtnMenuWidget(
        img: AppConfig.icon_abrir_rec_elec,
      titlte: 'SERVICIO EN RECINTOS',
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      VerificarGpsPage(pantalla: RecElecAbrir())));
        },
     ):Container(),
      SizedBox(
        height: responsive.altoP(separacionBtnMenu),
      ),
      _TipoEjesActivos .tipoEjeUnidadesPoliciales? BtnMenuWidget(
        img: AppConfig.icon_agregar_personal,
        titlte:  VariablesUtil.UNIDADESPOLICIALES,
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      VerificarGpsPage(pantalla: TipoEjeUnidadesPolicialesPage())));
        },
      ):Container(),
      SizedBox(
        height: responsive.altoP(separacionBtnMenu),
      ),
      _TipoEjesActivos .tipoEjeOtros? BtnMenuWidget(
        img: AppConfig.icon_registrar_novedades_rec_elec,
        titlte: 'OTROS',
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      VerificarGpsPage(pantalla: TipoEjeOtrosPage())));
        },
      ):Container(),

      ],);
  }



  _getTipoEjesActivosEnProcesoOperativos() async {
    try {
      if (!cargaInicial) return;
      if (peticionServer) return;

      setState(() {
        peticionServer = true;
      });


     String idDgoProcElec= _ProcesoOperativoProvider.getProcesosOperativo.idDgoProcElec;


       _TipoEjesActivos = await _TiposEjesApi.getTipoEjesActivosEnProcesoOperativos(context:context ,usuario: _UserProvider.getUser.idGenUsuario, idDgoProcElec:    idDgoProcElec );

      setState(() {
        peticionServer = false;
        cargaInicial = false;
      });
if(!_TipoEjesActivos.tipoEjeRecintos && !_TipoEjesActivos.tipoEjeUnidadesPoliciales&& !_TipoEjesActivos.tipoEjeOtros){
  DialogosWidget.alert(context,
      title: "UNIDADES",
      message:
      "No existen Unidades asignadas al Operativo"
          "\n\n${_ProcesoOperativoProvider.getProcesosOperativo.descProcElecc}",
      onTap: (){

        Navigator.of(context).pop();
        Navigator.of(context).pop();
      });
}


    } catch (e) {
      print(e.toString());
      setState(() {
        peticionServer = false;
        cargaInicial = false;
      });
    }
  }


}
