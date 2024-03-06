part of 'miUpcPages.dart';

class MiUpcMapaUpcPage extends StatefulWidget {
  @override
  _MiUpcMapaUpcPageState createState() => _MiUpcMapaUpcPageState();
}

class _MiUpcMapaUpcPageState extends State<MiUpcMapaUpcPage> {

  List<Miupc> datosUpc = new List();
  bool cargarDatos = true;
  bool peticionServer = false;
  MapController _mapController = new MapController();
  Geolocator geolocator = Geolocator();
  final prefs = new MiUpcPreferenciasUsuario();
  //para botoenes del zoom
  Alignment alignment = Alignment.topRight;
  bool mini = true;
  double padding = 2.0;
  bool btnZoomMas = true;
  bool btnZoomMenos = true;
  Color colorBtnMapa = Colors.blue;
  Color colorBtnRelleno = Colors.white;
  //configuraciones del mapa
  double latitudMiUbicacion = 0.0, longitudMiUbicacion = 0.0;
  double zoomMap = 7;

  double minZoom = 5;
  double maxZoom = 18;
  double sizeBtnSobreMapa = 40;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLocation();
  }

  @override
  Widget build(BuildContext context) {

    final responsive = ResponsiveUtil(context);
    return new Scaffold(

      appBar: AppBar(
        title: Center(
          child: Container(
            height: responsive.altoP(5.0),
            child: Image(
              image: AssetImage(MiUpcAppConfig.imgTitulo),
            ),
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            new FlutterMap(
                mapController: _mapController,
                options: new MapOptions(
                    center: new LatLng(-0.2143, -78.50179),
                    minZoom: 10.0,
                    maxZoom: 20.0,
                    zoom: 8,
                    debug: true),
                layers: [
                  getMapa(),
                  getMarcadores(),
                ]),
            getBtnMyUbicacion(),
            getBtnZoom(),
            CargandoWidget(mostrar: peticionServer),
          ],
        ),
      ),
    );
  }

  Widget getBtnZoom() {
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
                  colorIcon: colorBtnMapa,
                  colorRelleno:
                   colorBtnRelleno ,
                  ontap: () {
                    var centerZoom = zoomMap;
                    var zoom = centerZoom + 1;

                    if (zoom <= maxZoom) {
                      zoomMap = zoom;
                      _mapController.move(
                          new LatLng(latitudMiUbicacion, longitudMiUbicacion),
                          zoomMap);
                      setState(() {
                        btnZoomMas = true;
                        btnZoomMenos = true;

                      });
                    }
                  },
                  size: sizeBtnSobreMapa)),
          Padding(
              padding: EdgeInsets.all(padding),
              child: CustomMap.getBtnCustomIcon(
                  icon: Icons.zoom_out,
                  colorIcon: colorBtnMapa ,
                  colorRelleno:
                  colorBtnRelleno ,
                  ontap: () {
                    var centerZoom = zoomMap;
                    var zoom = centerZoom - 1;
                    print(zoom);
                    print(minZoom);
                    if (zoom >= minZoom) {
                      zoomMap = zoom;
                      _mapController.move(
                          new LatLng(latitudMiUbicacion, longitudMiUbicacion),
                          zoomMap);
                      setState(() {
                        btnZoomMenos = true;
                        btnZoomMas = true;

                      });
                    }
                  },
                  size: sizeBtnSobreMapa)),
        ],
      ),
    );

    return Positioned(bottom: 0, right: 0, child: wgZoom);
  }

  Widget getBtnMyUbicacion() {
    final responsive = ResponsiveUtil(context);
    return Positioned(
        top: responsive.altoP(0),
        right: 0,
        child: Container(
          padding: EdgeInsets.only(top: 15, right: 10),
          child: Column(
            children: <Widget>[
              CustomMap.getBtnCustomIcon(
                  icon: Icons.my_location,
                  colorIcon:  colorBtnMapa ,
                  colorRelleno:
                       colorBtnRelleno
                      ,
                  ontap: () {
                    _getLocation();

                  },
                  size: sizeBtnSobreMapa),
              CustomMap.getBtnCustomIcon(
                  icon: Icons.filter_center_focus,
                  colorIcon:  colorBtnMapa,
                  colorRelleno:
                       colorBtnRelleno,
                  ontap: () {
                    getBount();
                  },
                  size: sizeBtnSobreMapa)
            ],
          ),
        ));
  }

  LayerOptions getMapa() {
    return new TileLayerOptions(
        urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        subdomains: ['a', 'b', 'c']);
  }

  LatLngBounds getBount() {
    LatLngBounds bounds = LatLngBounds();
    //recoreemos los marcadores existentes
    //el ultimo punto es la posicion actual
    print('datosUpc');
    print(datosUpc.length);
    for (int i = 0; i < datosUpc.length; i++) {
      LatLng punto=new LatLng(double.parse( datosUpc[i].latitudUpc),double.parse( datosUpc[i].longitudUpc));
      bounds.extend(punto);
    }

    bounds.extend(new LatLng(latitudMiUbicacion,longitudMiUbicacion));
    _mapController.fitBounds(
      bounds,
      options: FitBoundsOptions(
        padding: EdgeInsets.all(100),
      ),
    );
  }

  Widget stiloMarcador(String icon, String valueKey, String nom, String dir,
      String ml, String tel, String dist, String latitudI, String longitudI,String latitudU, String longitudU) {
    Key key = ValueKey(valueKey);
    return new Container(
      key: key,
      child: IconButton(
        icon: Image.asset(icon),
        color: Colors.blue,
        iconSize: 40.0,
        onPressed: () {
          print(key);
          pasarPantalla(
              context: context,
              nombre: nom,
              dir: dir,
              mail: ml,
              tel: tel,
              distancia: dist,
              latitudI: latitudI,
              longitudI: longitudI,
              latitudU: latitudU,
              longitudU: longitudU);
        },
      ),
    );
  }

  cargarDatosUpc(BuildContext context, String lt, String lg) async {
    if (cargarDatos) {
      if (peticionServer) {
        return;
      }
      setState(() {
        peticionServer = true;
      });
      GetDatosUpcApi getDatosUpcApi = new GetDatosUpcApi();
      GetDatosUpcModel datosUpcModel;
      datosUpcModel =
          await getDatosUpcApi.consultarDatosUpc(context, lt, lg);

      setState(() {
        if(datosUpcModel!=null) {
          datosUpc = datosUpcModel.miupc;
        }
        else{


          MiUpcDialogosWidget.alertasV(
              context: context,
              txt:
              "No existen UPC'S que mostrar.");
        }
        cargarDatos = false;
        peticionServer = false;
      });



    }
  }

  Future<String> getObtenerDistancia(
      double latP, double longP, double latU, double longU) async {
    double distanceInMeters =
        await Geolocator.distanceBetween(latP, longP, latU, longU);
    return distanceInMeters.toString();
    //getObtenerDistancia(lat,long,double.parse(datosUpc[i].latitudUpc),double.parse(datosUpc[i].longitudUpc)
  }

  LayerOptions getMarcadores() {
    List<Marker> markers = new List();


    for (int i = 0; i < datosUpc.length; i++) {
      markers.add(Marker(
          width: 70.0,
          height: 70.0,
          point: new LatLng(double.parse(datosUpc[i].latitudUpc),
              double.parse(datosUpc[i].longitudUpc)),
          builder: (context) => stiloMarcador(
                MiUpcAppConfig.imgMarker_upc,
                i.toString(),
                datosUpc[i].descripcionUpc,
                datosUpc[i].dirUpc,
                datosUpc[i].mailUpc,
                datosUpc[i].fonoUpc,
                (double.parse(datosUpc[i].distance) * 1000).toString(),
            latitudMiUbicacion.toString(),
                longitudMiUbicacion.toString(),
                datosUpc[i].latitudUpc,
                datosUpc[i].longitudUpc,
              )));
    }
    markers.add(Marker(
      width: 70.0,
      height: 70.0,
      point: new LatLng(latitudMiUbicacion, longitudMiUbicacion),
      builder: (context) => new Container(
        child: IconButton(
          icon: Image.asset(MiUpcAppConfig.imgMarker_persona),
          color: Colors.blue,
          iconSize: 40.0,
          onPressed: () {},
        ),
      ),
    ));

    return new MarkerLayerOptions(markers: markers);
  }

  _getLocation() async {
    setState(() {
      peticionServer = true;
    });

    Position position;
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      setState(() {
        peticionServer = false;
      });

      if (position != null) {


        setState(() {
          latitudMiUbicacion = double.parse(position.latitude.toString());
          longitudMiUbicacion = double.parse(position.longitude.toString());
          cargarDatos=true;
          cargarDatosUpc(context, latitudMiUbicacion.toString(), longitudMiUbicacion.toString());
          zoomMap=15;
          _mapController.move(new LatLng(latitudMiUbicacion, longitudMiUbicacion), zoomMap);
        });


      }
    } catch (e) {}
  }

  pasarPantalla({BuildContext context,String nombre, String dir,String mail,String tel,String distancia,String latitudI, String longitudI,String latitudU, String longitudU}) {
    OpcionesUpcWidget.opcionUpc( ctxt: context,  nombreUpc: nombre,  direccion: dir,  mail: mail,   telefono: tel,  distancia: distancia,   latitudIni: latitudI, longitudIni: longitudI,   latitudUpc: latitudU, longitudUpc: longitudU);
  }
}
