part of  'miUpcCustomWidgets.dart';

class BorderListaAlerta extends StatefulWidget {
  final GestureTapCallback onTap;
  final Widget child;

  const BorderListaAlerta({Key key, this.onTap, @required this.child})
      : super(key: key);

  @override
  _BorderListaAlertaState createState() => _BorderListaAlertaState();
}

class _BorderListaAlertaState extends State<BorderListaAlerta> {
  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: MiUpcAppConfig.colorBarras,
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent,
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),

        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: widget.child),
      ),
    );
  }
}
