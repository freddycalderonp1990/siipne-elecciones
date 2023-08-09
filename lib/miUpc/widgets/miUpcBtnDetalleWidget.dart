part of  'miUpcCustomWidgets.dart';

class MiUpcBtnDetalleWidget extends StatefulWidget {

  final String txt;

  const MiUpcBtnDetalleWidget({Key key, this.txt}) : super(key: key);

  @override
  _BtnDetalleWidgetState createState() => _BtnDetalleWidgetState();
}

class _BtnDetalleWidgetState extends State<MiUpcBtnDetalleWidget> {


  @override
  Widget build(BuildContext context) {
    ResponsiveUtil resp=ResponsiveUtil(context);
    return Container(
      alignment: Alignment.center,

      width: double.infinity,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color:       Colors.black26,
          borderRadius: BorderRadius.circular(50.0)
      ),
      child: Text(

        widget.txt,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: MiUpcAppConfig.colorBarras,
          fontSize: 13.0,
          fontWeight: FontWeight.bold,

          fontFamily: 'OpenSans',
        ),
      ),
    );
  }
}
