part of 'mapa_bloc.dart';

@immutable
abstract class MapaEvent {}

class OnMapaListo extends MapaEvent {}
class OnNuevaUbicacion extends MapaEvent {
  //recibe la nueva ubicacion
  final LatLng ubicacion;

  OnNuevaUbicacion(this.ubicacion);

}
