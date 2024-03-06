import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart' as Geolocator;
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';

//con show importamos solo lo que nos interesa

import 'package:meta/meta.dart';

part 'mi_ubicacion_event.dart';

part 'mi_ubicacion_state.dart';

class MiUbicacionBloc extends Bloc<MiUbicacionEvent, MiUbicacionState> {
  MiUbicacionBloc() : super(MiUbicacionState());
  StreamSubscription<Geolocator.Position> _positionSubscription;
  var geolocator = Geolocator.Geolocator();

  void iniciarSeguimiento() {

    print("iniciarSeguimiento");

    //escucha los cambios de la posicion del GPS
    //eschucha cuando existen cambios en la posicion
    var locationOptions = Geolocator.LocationOptions(
        accuracy: LocationAccuracy.high,
        distanceFilter: 1,
        timeInterval: 10000);



    if (this._positionSubscription == null) {
      final positionStream =Geolocator.Geolocator.getPositionStream(
        //configuracion de la presion del GPS
        //entre mas preciso mas consumo de bateria
          desiredAccuracy: Geolocator.LocationAccuracy.high,
          distanceFilter:
          10 //la distancia en metros que captura un nuevo valor el gps cuando el usuario se mueve
      );
      this._positionSubscription = positionStream.handleError((error) {
        this._positionSubscription.cancel();
        this._positionSubscription = null;
      }).listen((position) {
        print("cambio en posicion");
        print(position);


        final ubicacion= new LatLng(position.latitude, position.longitude);
        add(OnUbicacionCambio(ubicacion));
      });

    }


  }

  getPeticionUbicacion(){
    return _positionSubscription;
  }
  void cancelarSeguimiento() {
    this._positionSubscription?.cancel();
  }

  @override
  Stream<MiUbicacionState> mapEventToState(
    MiUbicacionEvent event,
  ) async* {

    if(event is OnUbicacionCambio){
      print("event.ubicacion");
      print(event.ubicacion);
      //      yield emite un nuevo estado
      yield state.copyWith(
        existeUbicacion: true,
        ubicacion: event.ubicacion
      );

    }
  }
}
