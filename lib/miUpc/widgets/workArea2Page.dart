part of  'miUpcCustomWidgets.dart';

class WorArea2Page extends StatefulWidget {
  final bool peticionServer;

  final Widget contenido;
  final Widget drawer;
  final Key myKey;

  const WorArea2Page(
      {Key key,
      this.peticionServer = false,
      this.contenido,
      this.drawer,
      this.myKey})
      : super(key: key);

  @override
  _WorArea2PageState createState() => _WorArea2PageState();
}

class _WorArea2PageState extends State<WorArea2Page> {
  final prefs = new MiUpcPreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil(context);

    return Scaffold(
      key: widget.myKey,
      drawer: widget.drawer,
      appBar: AppBar(
        title: Center(
          child: Container(
            height: responsive.altoP(5.0),
            child: Image(
              image: AssetImage(MiUpcAppConfig.imgCabecera2),
            ),
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage(MiUpcAppConfig.imgFondo),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                  child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child:
                    widget.contenido != null ? widget.contenido : Container(),
              )),
              Container(
                height: responsive.isVertical()
                    ? responsive.altoP(5)
                    : responsive.altoP(10),
                child: bannerInferior(responsive),
              )
            ],
          ),
          CargandoWidget(mostrar: widget.peticionServer),
        ],
      )),
    );
  }

  _launchURLFace() async {
    const url = 'https://www.facebook.com/policia.ecuador';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLTwitter() async {
    const url = 'https://twitter.com/PoliciaEcuador';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLInsta() async {
    const url = 'https://www.instagram.com/policiaecuadoroficial';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLYou() async {
    const url = 'https://www.youtube.com/user/policiaecuador2';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget imgBanner(
      {GestureTapCallback onTap, String ruta, ResponsiveUtil responsive}) {
    double size =
        responsive.isVertical() ? responsive.altoP(8) : responsive.anchoP(8);
    return Container(
        height: size,
        width: size,
        child: InkWell(
          onTap: onTap,
          child: Container(
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                ruta,
              ),
            ),
          ),
        ));
  }

  Widget bannerInferior(ResponsiveUtil responsive) {
    return Container(
      color: Colors.blue,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          imgBanner(
              onTap: _launchURLFace,
              ruta: MiUpcAppConfig.imgFacebook,
              responsive: responsive),
          imgBanner(
              onTap: _launchURLTwitter,
              ruta: MiUpcAppConfig.imgTwitter,
              responsive: responsive),
          imgBanner(
              onTap: _launchURLInsta,
              ruta: MiUpcAppConfig.imgInstagran,
              responsive: responsive),
          imgBanner(
              onTap: _launchURLYou,
              ruta: MiUpcAppConfig.imgYoutube,
              responsive: responsive),
        ],
      ),
    );
  }
}
