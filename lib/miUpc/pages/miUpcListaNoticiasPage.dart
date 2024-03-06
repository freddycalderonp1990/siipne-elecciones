part of 'miUpcPages.dart';

class MiUpcListaNoticiasPage extends StatefulWidget {
  @override
  _MiUpcListaNoticiasPageState createState() => _MiUpcListaNoticiasPageState();
}

class _MiUpcListaNoticiasPageState extends State<MiUpcListaNoticiasPage> {
  List<Noticia> listaNoticias = new List();
  bool cargarDatos = true;
  bool datosC = true; //variable para que solo carge una vez los datos
  bool peticionServer = false;
  String fecha;
  final prefs = new MiUpcPreferenciasUsuario();

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
    //   Image(image: AssetImage(AppConfig.imgFondo));

    return WorArea2Page(      peticionServer: peticionServer,contenido: listaNoti( responsive),);

  }

  cargarDatosLista(BuildContext context) async {
    if (cargarDatos) {
      if (peticionServer) {
        return;
      }
      setState(() {
        peticionServer = true;
      });
      MiUpcListaNoticiasApi listaNoticiasApi = new MiUpcListaNoticiasApi();
      ListaNoticiasModel listaNoticiasModel;
      listaNoticiasModel = await listaNoticiasApi.getListaNoticia(context);
      print('listaNoticiasModel');
      print(listaNoticiasModel);

      setState(() {
        if (listaNoticiasModel != null) {
          listaNoticias = listaNoticiasModel.noticias;
          MiUpcConstApi.numNotiNoticias = listaNoticias.length;
        }
        else{
          MiUpcConstApi.numNotiNoticias =0;
        }
        cargarDatos = false;
        peticionServer = false;
      });

      if (MiUpcConstApi.numNotiNoticias == 0) {
        print('sin noticias');
        MiUpcDialogosWidget.alertaBtnAceptar(
            context: context,
            texto: 'No existen noticias que mostrar.',
            onPressed: (){
              Navigator.of(context).pop();
              Navigator.of(context).pop();

            }
           );
      }

      String _ip = await UtilidadesUtil.getIp();
      MiUpcAuditoriaApi auditoria = new MiUpcAuditoriaApi();
      auditoria.grabaAccion(MiUpcConstApi.latitud, MiUpcConstApi.longitud, 'CONSULTA',
          'NOTICIAS', prefs.getidUsuarioMiUpc(), _ip, context);
    }
  }

  Widget listaNoti(ResponsiveUtil responsive) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: listaNoticias != null ? listaNoticias.length : 0,
      itemBuilder: (context, ind) {
        Noticia noticia = listaNoticias[ind];
        return BorderListaAlerta(
          child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      child: Image.asset(MiUpcAppConfig.imgEscpolicia),
                      width: responsive.altoP(5),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "     " +
                                UtilidadesUtil.trasnformarFecha(
                                    noticia.fechaNoticia.toString()),
                            textAlign: TextAlign.center,
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
                  ],
                ),
                Container(
                  child: Image.asset(MiUpcAppConfig.imgLinea),
                  width: responsive.altoP(50),
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            noticia.descripcionNocticia.toUpperCase(),
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Container(
                    width: responsive.anchoP(70),
                    height: responsive.altoP(30),
                    child: getImgVideo(noticia)),
                Divider(
                  color: MiUpcAppConfig.colorBarras,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            noticia.hashtagNoticia,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.blueAccent,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),

                    Container(

                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.lightGreen, //                   <--- border color
                          width: 1,
                        ),
                      ),
                      child: InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,

                          children: [ Text(
                            "Compartir",
                            style: TextStyle(

                                fontSize: responsive.anchoP(5)),
                          ), Image.asset(MiUpcAppConfig.imgShared,width: responsive.altoP(3),)],
                        ),
                        onTap: () {
                          Share.share(noticia.linkHashtag);
                        },

                      ),
                    ),

                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  'MI-UPC-PNEC00-' + prefs.getidGenPersonaMiUpc()+MiUpcUrlApi.ambiente,
                  style: TextStyle(
                    fontSize: responsive.altoP(1.2),
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue,
                    decorationStyle: TextDecorationStyle.solid,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(UtilidadesUtil.getFechaActual(),style: TextStyle(fontSize: responsive.altoP(0.8)),),
                Container(
                  child: Image.asset(MiUpcAppConfig.imgLinea),
                  width: responsive.altoP(50),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget getImgVideo(Noticia noticia) {
    Widget wg = Container();
    //Se veridica si es imagen

    print(noticia.tieneVideo.trim().toUpperCase());

    if (noticia.tieneVideo.trim().toUpperCase() == 'I') {
      print('es imagennnn');
      wg = PosticionStackLocalizado(
        altoP: 35.0,
        anchoP: 35.0,
        titulo: 'NOTITLE',
        estadoAlerta: "NOESTADO",
        foto: noticia.imagenNoticia,
      );

    } else {
      // es un video
      //se verifica que la url no este vacia

      if (noticia.urlVideo.isNotEmpty) {
        wg = VideoWidget(
          url: noticia.urlVideo,
        );
      } else {
        wg = ImagenesWidget(
          isImg: false,
          altoP: 35.0,
          anchoP: 35.0,
          imgString: noticia.urlVideo,
        );
      }
    }

    return wg;
  }
}
