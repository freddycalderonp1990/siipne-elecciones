part of 'helpers.dart';

//sirve para mostrar animaciones al momento de mostrar una nueva pantalla
Route navegarMapaFadeIn( BuildContext context, Widget page ) {

  return PageRouteBuilder(
    pageBuilder: ( _, __ , ___ ) => page,
    transitionDuration: Duration( milliseconds: 10 ),
    transitionsBuilder: ( context, animation, _, child ) {

      return FadeTransition(
        child: child,
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOut )
        )
      );

    }
    
  );

}