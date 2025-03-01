part of 'customWidgets.dart';



class TituloTextWidget extends StatelessWidget {

  final String title;

  final  Color colorTitulo ;
  final  Color colorSombra ;
  final double ancho;
  final TextAlign textAlign;


  TituloTextWidget({this.title,  this.colorTitulo= Colors.black, this.ancho=0, this.textAlign=TextAlign.start, this.colorSombra=Colors.white,});
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil(context);

    Widget wg;

    if(ancho==0){
      wg=Text(
        title,
        textAlign: textAlign,
        style: TextStyle(
            shadows: [
              Shadow(
                blurRadius: 15,
                color: colorSombra,
                offset: Offset(2, 2),
              ),
              Shadow(
                blurRadius: 15,
                color: colorSombra,
                offset: Offset(-2, 2),
              ),
            ],
            color: colorTitulo,
            fontWeight: FontWeight.bold,
            fontSize: responsive.anchoP(AppConfig.tamTextoTitulo)),
      );
    }
    else{
      wg=Container(
        width: responsive.anchoP(ancho),
        child: Text(
          title,
          textAlign: textAlign,
          style: TextStyle(
              shadows: [
                Shadow(
                  blurRadius: 15,
                  color: colorSombra,
                  offset: Offset(2, 2),
                ),
                Shadow(
                  blurRadius: 15,
                  color: colorSombra,
                  offset: Offset(-2, 2),
                ),
              ],
              color: colorTitulo,
              fontWeight: FontWeight.bold,
              fontSize: responsive.anchoP(AppConfig.tamTextoTitulo)),
        ),
      );
    }

    return wg;
  }
}


