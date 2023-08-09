part of 'customWidgets.dart';

class BtnZoomMapWidget extends StatelessWidget {
  Alignment alignment = Alignment.topRight;
  double padding = 2.0;

  @override
  Widget build(BuildContext context) {

    final mapaBloc = context.bloc<MapaBloc>();
    final miUbicacionBloc = context.bloc<MiUbicacionBloc>();

    final responsive = ResponsiveUtil(context);
    Widget wgZoom = Align(
      alignment: alignment,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
              padding:
              EdgeInsets.only(left: padding, top: padding, right: padding),
              child: CustomMap.getBtnCustomIcon(
                  icon: Icons.zoom_in,
                  colorIcon: AppConfig.colorBtnMapa ,
                  colorRelleno:
                  AppConfig.colorBtnRelleno,
                  ontap: () {
                    print('press zoom mas');

                    final destino = miUbicacionBloc.state.ubicacion;
                    print(destino);
                    mapaBloc.zoomMas(destino: destino);
                  },
                  size: AppConfig.sizeBtnSobreMapa)),
          Padding(
              padding: EdgeInsets.all(padding),
              child: CustomMap.getBtnCustomIcon(
                  icon: Icons.zoom_out,
                  colorIcon: AppConfig.colorBtnMapa ,
                  colorRelleno:
                  AppConfig. colorBtnRelleno ,
                  ontap: () {
                    print('press zoom menos');

                    final destino = miUbicacionBloc.state.ubicacion;
                    print(destino);
                    mapaBloc.zoomMenos(destino: destino);
                  },
                  size: AppConfig.sizeBtnSobreMapa)),
        ],
      ),
    );

    return Positioned(bottom: 0, right: 0, child: wgZoom);


  }
}


