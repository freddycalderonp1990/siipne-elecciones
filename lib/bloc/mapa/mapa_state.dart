part of 'mapa_bloc.dart';

@immutable
class MapaState {
  final bool mapaListo;
  final bool dibujarRecorrido;

//Polylines

  //se declara con este tipo para establecer mas de una polilinea ejemplo
  //para mi ruta trazada
  //{'mi_ruta':{ points: [[lat,long],[lat,long]],
  //           strokeWidth: 4.0,
  //           gradientColors: color}}
  //para ruta recorrida
  final Map<String, Polyline> polylines;

  //otra forma de inicializar es
  //this.polylines = polylines ?? new Map();
  //Indicando que la polylines recibe una polylines de tipo   Map<String, Polyline> si no se encuentr null caso contrario recibe un Map
  MapaState(
      {this.mapaListo = false,
      this.dibujarRecorrido = true,
      Map<String, Polyline> polylines})
      : this.polylines = polylines ?? new Map();

  copyWith({bool mapaListo, Map<String, Polyline> polylines}) {
    return MapaState(
        mapaListo: mapaListo ?? this.mapaListo,
        polylines: polylines ?? this.polylines,
        dibujarRecorrido: dibujarRecorrido ?? this.dibujarRecorrido);
  }
}
