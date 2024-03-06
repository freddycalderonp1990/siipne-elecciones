part of 'miUpcPages.dart';

class MiUpcListaTipsCovidPage extends StatefulWidget {
  @override
  _MiUpcListaTipsCovidPageState createState() => _MiUpcListaTipsCovidPageState();
}

class _MiUpcListaTipsCovidPageState extends State<MiUpcListaTipsCovidPage> {
  List<Servicio> listaServicos = new List();
  List<DServicio> listaDetalleServicos = new List();
  bool cargarDatos = true;
  bool datosC = true; //variable para que solo carge una vez los datos
  bool peticionServer = false;
  final prefs = new MiUpcPreferenciasUsuario();
  var imgMemory=null;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil(context);
    // final size = MediaQuery.of(context).size;
    cargarDatosLista(context);

    return WorArea2Page(  peticionServer: peticionServer,contenido: getContenido( responsive),);


  }

  cargarDatosLista(BuildContext context) async {
    if (cargarDatos) {
      if (peticionServer) {
        return;
      }
      setState(() {
        peticionServer = true;
      });
      ServiciosPolcoApi serviciosPolcoApi = new ServiciosPolcoApi();
      ServiciosPolcoModel serviciosPolcoModel;
      serviciosPolcoModel =
          await serviciosPolcoApi.consultarServicos(context, "5");
      setState(() {
        listaServicos = serviciosPolcoModel.servicio;
        cargarDatos = false;
        peticionServer = false;
      });
    }
  }

  Widget getContenido(ResponsiveUtil responsive) {

    return ListView.builder(
      shrinkWrap: true,
      itemCount: listaServicos != null ? listaServicos.length : 0,
      itemBuilder: (context, ind) {
        imgMemory =  PhotoHelper.convertStringToUint8List( listaServicos[ind].imgBase64);
        return InkWell(
          onTap: () => cargarDatosItems(
              context,
              listaServicos[ind].idUpcServicio,
              listaServicos[ind].servicio,
              listaServicos[ind].img),
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: responsive.altoP(8),
                        height: responsive.altoP(8),
                        child:imgMemory!=null?Container(
                          height: responsive.altoP(8),
                          width: responsive.altoP(8),
                          child: Image.memory(imgMemory) ,):Container(
                            height: responsive.altoP(8),
                            width: responsive.altoP(8),
                            child:Image.asset(MiUpcAppConfig.imgEscpolicia)
                        ),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("     " + listaServicos[ind].servicio.toUpperCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: MiUpcAppConfig.colorBarras,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                          ],
                        ),

                      ),
                      Divider(
                        color: MiUpcAppConfig.colorBarras,
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: MiUpcAppConfig.colorBarras,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  cargarDatosItems(BuildContext context, id, titulo, img) async {
    if (peticionServer) {
      return;
    }
    setState(() {
      peticionServer = true;
    });
    MiUpcItemsServiciosApi itemsServiciosApi = new MiUpcItemsServiciosApi();
    ItemsServiciosModel itemsServiciosModel;
    itemsServiciosModel =
        await itemsServiciosApi.consultarServicos(context, id);
    setState(()  {
      listaDetalleServicos = itemsServiciosModel.dServicio;
      datosC = false;
      peticionServer = false;
      List<String> lista = List();
      for (int i = 0; i < listaDetalleServicos.length; i++) {
        lista.add(listaDetalleServicos[i].descripcion);
      }

      MiUpcDialogosWidget.alertItems(context: context, imagen: img, title: titulo, listaIt: lista);

     /* AlertasWidget.alertaDetalleItems(
         ctxt: context, imagen: img, title: titulo, listaIt: lista);*/
    });

    String _ip = await UtilidadesUtil.getIp();
    MiUpcAuditoriaApi auditoria = new MiUpcAuditoriaApi();
    auditoria.grabaAccion(MiUpcConstApi.latitud, MiUpcConstApi.longitud, 'CONSULTA',
        'TIPS COVID-'+titulo, prefs.getidUsuarioMiUpc(), _ip, context);
  }

  atras(BuildContext context) {
    //Navigator.of(context).pop();
  }
}
