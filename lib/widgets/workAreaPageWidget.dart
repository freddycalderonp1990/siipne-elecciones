part of 'customWidgets.dart';

class WorkAreaPageWidget extends StatefulWidget {
  final bool peticionServer;
  final String title;
  final List<Widget> contenido;
  final bool btnAtras;
  final Widget widgetBtnFinal;
  final EdgeInsetsGeometry paddin;
  final FloatingActionButtonLocation ubicacionBtnFinal;
  final imgPerfil;
  final String imgFondo;
  final double sizeTittle;
  final bool mostrarVersion;

  const WorkAreaPageWidget({
    this.peticionServer = false,
    @required this.title = null,
    @required this.contenido,
    this.btnAtras = false,
    this.widgetBtnFinal,
    this.paddin,
    this.ubicacionBtnFinal = FloatingActionButtonLocation.centerFloat,
    this.imgPerfil = null,
    this.imgFondo = AppConfig.imgFondoDefault,
    this.sizeTittle,
    this.mostrarVersion = false,
  });

  @override
  _WorkAreaPageWidgetState createState() => _WorkAreaPageWidgetState();
}

class _WorkAreaPageWidgetState extends State<WorkAreaPageWidget> {
  String version = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadVersion();
  }

  _loadVersion() async {
    String _version = await UtilidadesUtil.getVersionCodeNameApp();
    setState(() {
      version = _version;
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil(context);

    return Scaffold(
        floatingActionButtonLocation: widget.ubicacionBtnFinal,
        floatingActionButton: widget.widgetBtnFinal,
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Stack(
              children: [
                Container(
                  height: responsive.alto,
                  width: responsive.ancho,
                  child: Image.asset(
                    widget.imgFondo,
                    fit: BoxFit.fill,
                  ),
                ),
                getDesingImgProceso(responsive),
                SafeArea(
                  child: Column(
                    children: [
                      Container(
                        width: responsive.ancho,
                        height: responsive.isVertical()
                            ? responsive.altoP(8.5)
                            : responsive.altoP(20),
                        child: Stack(
                          children: [
                            Positioned(
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: Container(
                                width: responsive.anchoP(38),
                                height: responsive.anchoP(38),
                              ),
                            ),
                            widget.btnAtras ? BtnAtrasWidget() : Container(),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: SingleChildScrollView(
                              padding: widget.paddin,
                              child: Container(
                                  padding: EdgeInsets.only(
                                      top: responsive.isVertical()
                                          ? responsive.anchoP(13)
                                          : 0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      title(),
                                      Container(
                                        width: responsive.anchoP(100),
                                        margin: EdgeInsets.only(
                                          top: responsive.altoP(2.0),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              AppConfig.radioBordecajas),
                                        ),
                                        child: Center(
                                          child: Column(
                                            children: <Widget>[
                                              imgPerfilRedonda(
                                                size: 22,
                                                img: widget.imgPerfil,
                                              ),
                                              widget.mostrarVersion
                                                  ? TextSombrasWidget(
                                                colorTexto: Colors.white,
                                                      colorSombra: Colors.black45,
                                                      title: 'V.' +
                                                          version +
                                                          '-' +
                                                          AppConfig.ambiente,
                                                    )
                                                  : Container()
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: responsive.altoP(3),
                                      ),
                                      Column(
                                        children: widget.contenido != null
                                            ? widget.contenido
                                            : [Container()],
                                      ),
                                    ],
                                  ))),
                        ),
                      )
                    ],
                  ),
                ),
                CargandoWidget(
                  mostrar: widget.peticionServer,
                )
              ],
            )));
  }

  Widget title() {
    final responsive = ResponsiveUtil(context);
    return widget.title != null
        ? Text(
            widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 10,
                    color: Colors.black,
                    offset: Offset(2, 2),
                  ),
                  Shadow(
                    blurRadius: 10,
                    color: Colors.black,
                    offset: Offset(-2, 2),
                  ),
                ],
                fontWeight: FontWeight.bold,
                fontSize: widget.sizeTittle == null
                    ? responsive.anchoP(5)
                    : responsive.anchoP(widget.sizeTittle)),
          )
        : Container();

    return Text(
      'Hola mundo',
      style: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget getDesingImgProceso(ResponsiveUtil responsive) {
    ImgProcesoProvider _imgProcesoProvider = ImgProcesoProvider.of(context);

    print("enbtro a dibujar");
    if (_imgProcesoProvider.getProcesoImg == null) {
      print("enbtro a dibujar-c");
      return Container();
    }

    print("enbtro a dibujar-nn");
    String img = _imgProcesoProvider.getProcesoImg.imgBase64;

    Uint8List imgDecode = null;
    print("enbtro a dibujar-1111111${img}");
    print(
        "enbtro a dibujar-1111111${_imgProcesoProvider.getProcesoImg.urlImagen}");

    final decodedBytes = base64Decode(img);
    print(decodedBytes);
    imgDecode = decodedBytes;

    print(
        "enbtro a dibujar-222222${_imgProcesoProvider.getProcesoImg.urlImagen}");
    return Positioned(
      right: responsive.diagonalP(1),
      top: responsive.altoP(3),
      child: Container(
          height: responsive.isHorizontal()
              ? responsive.altoP(24)
              : responsive.altoP(12),
          width: responsive.isHorizontal()
              ? responsive.anchoP(50)
              : responsive.anchoP(48),
          child: Center(
            child: Image.memory(imgDecode, fit: BoxFit.contain),
          )),
    );
  }
}

class imgPerfilRedonda extends StatefulWidget {
  final double size;

  final img;

  const imgPerfilRedonda({Key key, this.size = 22, this.img}) : super(key: key);

  @override
  _imgPerfilRedondaState createState() => _imgPerfilRedondaState();
}

class _imgPerfilRedondaState extends State<imgPerfilRedonda> {
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil(context);

    return widget.img != null
        ? Container(
            width: responsive.isVertical()
                ? responsive.anchoP(widget.size)
                : responsive.anchoP(widget.size - 8),
            height: responsive.isVertical()
                ? responsive.anchoP(widget.size)
                : responsive.anchoP(widget.size - 8),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white.withOpacity(0.5),
                style: BorderStyle.solid,
                width: 2.5,
              ),
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(150.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: Image.memory(widget.img).image, fit: BoxFit.fill),
              ),
            ),
          )
        : Container();
  }
}
