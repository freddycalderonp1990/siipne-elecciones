part of 'customWidgets.dart';

class BtnUbicacion extends StatelessWidget {
  UserProvider _UserProvider;

  @override
  Widget build(BuildContext context) {
    _UserProvider = UserProvider.of(context);
    final mapaBloc = context.bloc<MapaBloc>();
    final miUbicacionBloc = context.bloc<MiUbicacionBloc>();

    final responsive = ResponsiveUtil(context);
    return Positioned(
        top: responsive.altoP(4),
        right: 0,
        child: Container(
          padding: EdgeInsets.only(top: 15, right: 10),
          child: Column(
            children: <Widget>[
              CustomMap.getBtnCustomIcon(
                  icon: Icons.my_location,
                  colorIcon: AppConfig. colorBtnMapa,
                  colorRelleno:  AppConfig.colorBtnRelleno   ,
                  ontap: () {
                    print('press BtnUbicacion');

                    final destino = miUbicacionBloc.state.ubicacion;



                    mapaBloc.moverCamara(destino:   destino,zoomMap: 17);

                  },
                  size:AppConfig. sizeBtnSobreMapa),
              CustomMap.getBtnCustomIcon(
                  icon: Icons.directions_run,
                  colorIcon:  AppConfig. colorBtnMapa,
                  colorRelleno:  AppConfig.  colorBtnRelleno,
                  ontap: () {

                  },
                  size: AppConfig.sizeBtnSobreMapa)
            ],
          ),
        ));


  }
}


