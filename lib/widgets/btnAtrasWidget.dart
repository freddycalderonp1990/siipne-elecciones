
part of 'customWidgets.dart';

class BtnAtrasWidget  extends StatefulWidget {

const BtnAtrasWidget() ;

@override
_BtnAtrasWidgetState createState() => _BtnAtrasWidgetState();
}

class _BtnAtrasWidgetState extends State<BtnAtrasWidget> {
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil(context);
    // TODO: implement build
    return    Container(

        child: Stack(children: [
          Positioned(
              left:responsive.isVertical()? responsive.altoP(1):responsive.anchoP(1),
              top: responsive.isVertical()? responsive.altoP(1):responsive.anchoP(2),
              child:  SafeArea(
                child: CupertinoButton(
                  minSize: responsive.isVertical()?responsive.altoP(5):responsive.anchoP(5),
                  padding: EdgeInsets.all(3),
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.black26,
                  onPressed: ()=> Navigator.pop(context),//volver atras
                  child: Icon(Icons.arrow_back, color: Colors.white,size:responsive.isVertical()? responsive.altoP(3):responsive.anchoP(3),),
                ),
              )
          )
        ],));
  }

}