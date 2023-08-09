
part of 'customWidgets.dart';

class ContenedorDesingWidget extends StatelessWidget {
  final Widget child;
  final double anchoPorce;

  final EdgeInsetsGeometry margin;

  const ContenedorDesingWidget({
    Key key,
    this.child,
    this.anchoPorce = 97.0,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      final responsive = ResponsiveUtil(context);
      return Container(

          width: responsive.anchoP(anchoPorce),
          margin: margin,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(1),
              borderRadius: BorderRadius.circular(AppConfig.radioBordecajas),
              boxShadow: [
                BoxShadow(
                    color: AppConfig.colorBordecajas,
                    blurRadius: AppConfig.sobraBordecajas)
              ]),
          child: child);
    }
    catch(e){


    }
  }

}
