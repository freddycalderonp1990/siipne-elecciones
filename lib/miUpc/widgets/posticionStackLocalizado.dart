part of  'miUpcCustomWidgets.dart';

class PosticionStackLocalizado extends StatefulWidget {
  final String estadoAlerta, titulo;
  final String foto;
  final double altoP;
  final double anchoP;

  const PosticionStackLocalizado(
      {Key key, this.estadoAlerta, this.titulo, @required this.foto, this.altoP=8, this.anchoP=8})
      : super(key: key);

  @override
  _PosticionStackLocalizadoState createState() =>
      _PosticionStackLocalizadoState();
}

class _PosticionStackLocalizadoState extends State<PosticionStackLocalizado> {
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil(context);
    double sizetext =
        responsive.isVertical() ? responsive.anchoP(10) : responsive.anchoP(3);

    Widget wg = widget.estadoAlerta == 'LOCALIZADO'
        ? Positioned(
            child: RotationTransition(
              turns: new AlwaysStoppedAnimation(-30 / 360),
              child: getMarco(
                  child: Text(
                widget.titulo,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: sizetext,
                    fontWeight: FontWeight.bold),
              )),
            ),
          )
        : widget.estadoAlerta == 'FALSA'
            ? Positioned(
                top: responsive.altoP(20),
                left: responsive.anchoP(20),
                child: RotationTransition(
                  turns: new AlwaysStoppedAnimation(-25 / 360),
                  child: getMarco(
                      child: Text(
                    "FALSA",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: sizetext,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              )
            : Container();

    wg = Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5.0,
                offset: Offset(0, 0),
                spreadRadius: 0.1,
              ),
            ],
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child:Container(

                child:  ImagenesWidget(
                altoP: widget.altoP,
                anchoP: widget.anchoP,
                imgString:  widget.foto,
              ),)),
        ),
        wg
      ],
    );
    return wg;
  }

  Widget getMarco({Widget child}) {
    return Container(
      margin: EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.redAccent,
        boxShadow: [
          BoxShadow(
            color: Colors.redAccent,
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          padding: EdgeInsets.all(2),
          margin: EdgeInsets.all(2),
          child: child),
    );
  }
}
