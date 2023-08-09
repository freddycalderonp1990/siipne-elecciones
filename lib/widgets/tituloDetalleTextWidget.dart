part of 'customWidgets.dart';



class TituloDetalleTextWidget extends StatelessWidget {
  final BuildContext context;
  final String title;
  final String detalle;
  final  Color colorTitulo ;
  final  Color colorDetalle ;
  final bool mostrarBorder;
  final bool mostrarLinea;


  TituloDetalleTextWidget({this.context, this.title, this.detalle, this.colorTitulo= Colors.black, this.colorDetalle= Colors.black, this.mostrarBorder=true, this.mostrarLinea=false});
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil(context);

    Widget wg=Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        TituloTextWidget(title: title,colorTitulo: colorTitulo,ancho: 22,),
        DetalleTextWidget(detalle: detalle,colorDetalle: colorDetalle,)

      ],
    );

    if(mostrarBorder) {
      wg = Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(color: AppConfig.colorBordecajas, blurRadius: 1)
              ]),
          child: wg);
    }


    if(mostrarLinea) {
      wg = Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(bottom: 5),
          decoration:BoxDecoration(
            border: Border(

              bottom: BorderSide( //                    <--- top side
                color: AppConfig.colorBordecajas.withOpacity(0.5),
                width: 1,
              ),
            ),
          ),
          child: wg);
    }

    return wg;
  }
}


