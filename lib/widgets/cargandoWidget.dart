
part of 'customWidgets.dart';

class CargandoWidget extends StatefulWidget {


  final bool mostrar;


  const CargandoWidget({this.mostrar}) ;

  @override
  _CargandoWidgetState createState() => _CargandoWidgetState();
}

class _CargandoWidgetState extends State<CargandoWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      widget.mostrar? Positioned.fill(
        child: Container(
          color: Colors.black54,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Theme(data: ThemeData(cupertinoOverrideTheme: CupertinoThemeData(brightness: Brightness.dark)),
                    child: CupertinoActivityIndicator( radius: 25,)),

              Text("Espere...",style: TextStyle(fontSize: 15,color: Colors.white),)
            ],),
          ),
        ))
        : Container();
  }

}