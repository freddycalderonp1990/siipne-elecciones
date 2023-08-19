part of 'miUpcPages.dart';

class MiUpcListaViolenciaPage extends StatefulWidget {
  @override
  _MiUpcListaViolenciaPageState createState() => _MiUpcListaViolenciaPageState();
}

class _MiUpcListaViolenciaPageState extends State<MiUpcListaViolenciaPage> {
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

   return WorArea2Page(      peticionServer: peticionServer,contenido:listaMenu(responsive),);




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
          await serviciosPolcoApi.consultarServicos(context, "3");
      setState(() {
        listaServicos = serviciosPolcoModel.servicio;



        cargarDatos = false;
        peticionServer = false;
      });
    }
  }

  Widget listaMenu(ResponsiveUtil responsive) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: listaServicos != null ? listaServicos.length : 0,
        itemBuilder: (context, ind) {
          imgMemory =  PhotoHelper.convertStringToUint8List( listaServicos[ind].imgBase64);
          if(listaServicos[ind].servicio.trim().toUpperCase()!="CUENTALE A PAQUITO".trim().toUpperCase()) {
            return InkWell(

              onTap: () =>
                  cargarDatosItems(
                      context,
                      listaServicos[ind].idUpcServicio,
                      listaServicos[ind].servicio,
                      listaServicos[ind].imgBase64),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          imgMemory!=null?Container(
                            height: responsive.altoP(8),
                            width: responsive.altoP(8),
                            child: Image.memory(imgMemory) ,):Container(
                              height: responsive.altoP(8),
                              width: responsive.altoP(8),
                              child:Image.asset(MiUpcAppConfig.imgEscpolicia)
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  " " +
                                      listaServicos[ind].servicio.toUpperCase(),
                                  textAlign: TextAlign.justify,
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
          }
          return Container();
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
    print("cargarDatosItems");

    String title = titulo.toString().toUpperCase().trimLeft().trimRight();
    print(title);

    if (title == "CUENTALE A PAQUITO") {
      generarAlerta(context);
    } else {
      print("no generarAlerta");
      MiUpcItemsServiciosApi itemsServiciosApi = new MiUpcItemsServiciosApi();
      ItemsServiciosModel itemsServiciosModel;
      itemsServiciosModel =
          await itemsServiciosApi.consultarServicos(context, id);
      setState(() {
        listaDetalleServicos = itemsServiciosModel.dServicio;
        datosC = false;
        peticionServer = false;
        List<String> lista = List();
        for (int i = 0; i < listaDetalleServicos.length; i++) {
          lista.add(listaDetalleServicos[i].descripcion);
        }

        MiUpcDialogosWidget.alertItems(
            context: context, imagen: img, title: titulo, listaIt: lista);
        //  AlertasWidget.alertaDetalleItems(ctxt: context, imagen:img, title: titulo, listaIt: lista);
      });

      String _ip = await UtilidadesUtil.getIp();
      MiUpcAuditoriaApi auditoria = new MiUpcAuditoriaApi();
      auditoria.grabaAccion(MiUpcConstApi.latitud, MiUpcConstApi.longitud, 'CONSULTA',
          'CONCEJOS VIOLENCIA-' + titulo, prefs.getidUsuarioMiUpc(), _ip, context);
    }

    setState(() {
      peticionServer = false;
    });
  }

  generarAlerta(BuildContext ctx) {
    String a = "Esta notificación debe ser usada en casos de Emergencia";
    String b =
        "Se recuerda que los datos proporcionados en el registro de la aplicación son confidenciales y se guardará absoluta reserva.\n";
    String c =
        "El mal uso de la aplicación será sancionado según la Normativa Legal Vigente del Estado Ecuatoriano.\n";
    String d = "RECUERDA\nESTA ALERTA ES INFORMATIVA";
    String e =
        'Si Tienes Miedo de Denunciar y eres víctima de VIOLENCIA puedes registrar esta notificación para poder analizar tú caso y poderte brindar la ayuda profesional y oportuna necesaria.';
    MiUpcDialogosWidget.alertOpciones(
        context: ctx, t: a, i: b, i1: c, i2: d, i3: e, op: "4");
  }
}
