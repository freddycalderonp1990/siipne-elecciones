
part of 'customWidgets.dart';

class BtnMenuWidget  extends StatefulWidget {

  final img;
  final String titlte;
  final GestureTapCallback onTap;
  final bool horizontal;
  final Color colorTexto;
  final Color colorFondo;


  const BtnMenuWidget( {this.img=null,this.titlte, this.onTap, this.horizontal=true,this.colorTexto, this.colorFondo}) ;

  @override
  _BtnMenuWidgetState createState() => _BtnMenuWidgetState();
}



class _BtnMenuWidgetState extends State<BtnMenuWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final responsive = ResponsiveUtil(context);



    Widget horizontal= Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConfig.radioBordecajas),
          boxShadow: [
            BoxShadow(
                color: AppConfig.colorBordecajas,
                blurRadius: AppConfig.sobraBordecajas)
          ]),
      child: Material(
        color:widget. colorFondo!=null?widget. colorFondo: Colors.white,
        borderRadius: BorderRadius.circular(20),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap:widget.onTap,
          // handle your onTap here
          child: Container(

            margin:
            EdgeInsets.only(left: 20.0, right: 20.0),
            width: responsive.anchoP(70),
            height: responsive.anchoP(17),
            child: Row(
              crossAxisAlignment:
              CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: responsive.anchoP(15),
                  height: responsive.anchoP(15),
                  child: widget.img!=null? Image.asset(
                    widget.img,
                  ):Image.asset(
                    AppConfig.iconNoImg,
                  ),
                ),
                SizedBox(
                  width: responsive.altoP(1),
                ),
                Expanded(
                    child: Text(
                      widget.titlte,
                      textAlign: TextAlign.center,

                      style: TextStyle(
                        color: widget.colorTexto!=null? widget.colorTexto:Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: responsive
                              .anchoP(AppConfig.tamTextoTitulo)),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
    Widget vertical= Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConfig.radioBordecajas),
          boxShadow: [
            BoxShadow(
                color: AppConfig.colorBordecajas,
                blurRadius: AppConfig.sobraBordecajas)
          ]),
      child: Material(
        shadowColor: widget. colorFondo!=null?widget. colorFondo:Colors.white,
        color:widget. colorFondo!=null?widget. colorFondo:Colors.white,
        borderRadius: BorderRadius.circular(20),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap:widget.onTap,
          // handle your onTap here
          child: Container(

            margin:
            EdgeInsets.only(left: 20.0, right: 20.0,bottom: 10.0,top: 10),
            width: responsive.anchoP(70),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: responsive.anchoP(12),
                  height: responsive.anchoP(12),
                  child: widget.img!=null? Image.asset(
                    widget.img,
                  ):Image.asset(
                    AppConfig.iconNoImg,
                  ),
                ),
                SizedBox(
                  width: responsive.altoP(1),
                ),
                Container(
                    child: Text(
                      widget.titlte,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: widget.colorTexto!=null? widget.colorTexto:Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: responsive
                              .anchoP(AppConfig.tamTextoTitulo)),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
    return  widget.horizontal?horizontal :vertical;
  }

}