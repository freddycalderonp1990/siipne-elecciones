
part of 'customWidgets.dart';

class CabeceraWidget   {

  static Widget circuloDerecha(BuildContext context){
    final size = MediaQuery.of(context).size;
    return   Positioned(
      right: -size.width * 0.25,
      top: -size.width * 0.45,
      child: CircleWidget(
        radio: size.width * 0.45,
        ColoresUtil: AppConfig.colorCirculo1,
      ),
    );

  }


  static Widget circuloIzquierda(BuildContext context){
    final size = MediaQuery.of(context).size;
    return    Positioned(
      left: -size.width * 0.15,
      top: -size.width * 0.40,
      child: CircleWidget(
        radio: size.width * 0.32,
        ColoresUtil: AppConfig.colorCirculo2,
      ),
    );

  }

  static Widget imgMinisterio(BuildContext context){

    final responsive = ResponsiveUtil(context);
    return      Positioned(
      right: 0,
      top: 0,
      child: Image.asset(
        AppConfig.iconNoImg,
        width: responsive.anchoP(38),
        height: responsive.anchoP(38),
      ),
    );

  }





}