part of 'customWidgets.dart';

class CustomMap {
  static LayerOptions getMapa() {
    return new TileLayerOptions(
        urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        subdomains: ['a', 'b', 'c']);
  }

  static getMarkerMiUbicacion(Key key, LatLng punto) {
    double size = AppConfig.sizeMarcadorMiUbicacion;
    Marker marcador = Marker(
      width: size,
      height: size,
      point: punto,
      builder: (ctx) => new MarkerWidget(
        sizeIcon: 20,
        size: size,
        icon: Icons.person_pin_circle,
        key: key,
        colorIcon: Colors.blue,
        colorRelleno: Colors.white,
      ),
    );

    return marcador;
  }

  static getMarkerVictimasSinVisitar(
      {Key key, LatLng punto, GestureTapCallback onTap}) {
    double size = AppConfig.sizeMarcadorMiUbicacion;
    Marker marcador = Marker(
      width: size,
      height: size,
      point: punto,
      builder: (ctx) => new MarkerWidget(
        onTap: onTap,
        sizeIcon: 20,
        size: size,
        icon: Icons.person,
        key: key,
        colorIcon: Colors.red,
        colorRelleno: Colors.white,
      ),
    );

    return marcador;
  }

  static getMarkerVictimasVisitadas(
      {Key key, LatLng punto, GestureTapCallback onTap}) {
    double size = AppConfig.sizeMarcadorMiUbicacion;
    Marker marcador = Marker(
      width: size,
      height: size,
      point: punto,
      builder: (ctx) => new MarkerWidget(
        onTap: onTap,
        sizeIcon: 20,
        size: size,
        icon: Icons.person,
        key: key,
        colorIcon: Colors.green,
        colorRelleno: Colors.white,
      ),
    );

    return marcador;
  }

  static Widget getBtnCustomIcon(
      {GestureTapCallback ontap,
      double size,
      Color colorIcon,
      Color colorRelleno,
      IconData icon}) {
    return CupertinoButton(
        borderRadius: BorderRadius.circular(20),
        padding: EdgeInsets.all(1),
        onPressed: ontap,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: size,
              width: size,
              decoration: BoxDecoration(
                  border: Border.all(color: colorIcon, width: 0.5),
                  color: colorRelleno,
                  borderRadius: BorderRadius.circular(50)),
              child: Container(
                child: size > 38
                    ? Icon(
                        icon,
                        color: colorRelleno,
                        size: size - 20,
                      )
                    : Container(),
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: colorIcon, borderRadius: BorderRadius.circular(50)),
              ),
            )));
  }

  static getMarkerRastro(
      {Key key,
      String num,
      LatLng punto,
      GestureTapCallback onTap,
      final GestureLongPressCallback onLongPress,
      bool isTransparente = false,
      bool valueCheck}) {
    double size = AppConfig.sizeMarcadorRastro;

    return MarkerRadioButton(
      num: num,
      size: size,
      icon: AppConfig.iconMarcadorRastro,
      key: key,
      colorIcon:
          isTransparente ? Colors.transparent : AppConfig.colorMarcadorRastro,
      colorRelleno: isTransparente ? Colors.transparent : Colors.white,
      isCheck: isTransparente ? false : true,
      onTap: onTap,
      valueCheck: valueCheck,
      onLongPress: onLongPress,
    );
  }

  static LayerOptions addPolilyne({List<LatLng> puntos}) {
    List<Color> color = [Colors.red];
    LayerOptions polilyne = PolylineLayerOptions(
      polylines: [
        Polyline(
          points: puntos,
          strokeWidth: 4.0,
          gradientColors: color,
        ),
      ],
    );

    return polilyne;
  }

  //para recorrer lo que se encuentra dibujado en el mapa
  static List<LayerOptions> getLayeres(List<LayerOptions> layers) {
    List<LayerOptions> layers2 = new List();
    for (int i = 0; i < layers.length; i++) {
      layers2.add(layers[i]);
    }

    return layers2;
  }
}
