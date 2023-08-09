part of 'mi_ubicacion_bloc.dart';

@immutable
abstract class MiUbicacionEvent {}

//los eventos empiezan con On
//se extiende de MiUbicacionEvent por neceito las variables que se encuentran en esa clase
class OnUbicacionCambio extends MiUbicacionEvent{

  final LatLng ubicacion;

  OnUbicacionCambio(this.ubicacion);


}
