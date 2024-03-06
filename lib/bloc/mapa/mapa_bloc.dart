import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:meta/meta.dart';
import 'package:latlong/latlong.dart';

import 'myPolylines.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(MapaState());

  //Controlador del Mapa
  MapController _mapController;

  //capas para el mapa
  List<LayerOptions> layers;

  //Polylines

  myPolylines _miRuta = new    myPolylines(
    strokeWidth: 4.0,
    gradientColors: [Colors.red],
  );




  void initMapa({MapController mapController, List<LayerOptions> layers}){
    if(!state.mapaListo){
      this._mapController=mapController;



      //Cambiar estilo del mapa

      add(OnMapaListo());
    }
  }


  void mover_a_Ubicacion( {LatLng destino,double zoomMap} ) {

    this._mapController?.move(destino, zoomMap);
  }

  void moverCamara( {LatLng destino,double zoomMap} ) {

    this._mapController?.move(destino, zoomMap);
  }

  void zoomMas( {LatLng destino} ) {
    double zoomMap= this._mapController.zoom + 1;
    this._mapController?.move(destino, zoomMap);
  }
  void zoomMenos( {LatLng destino} ) {
    double zoomMap= this._mapController.zoom - 1;
    this._mapController?.move(destino, zoomMap);
  }

  @override
  Stream<MapaState> mapEventToState(
    MapaEvent event,
  ) async* {
    //controla que nuestro mapa este listo para dibujarse y mostrarse
    if(event is OnMapaListo){
      print('Mapa listo');
      yield state.copyWith(mapaListo: true);
    }
    else  if(event is OnNuevaUbicacion){



      print(' mapa_bloc-OnNuevaUbicacion ${event.ubicacion}');

     /* List<LatLng> puntosPolylinea=[...this._miRuta.points,event.ubicacion];
      this._miRuta = this._miRuta.copyWith(points: puntosPolylinea);

      final currentPolylines = state.polylines;
      currentPolylines['mi_ruta']=this._miRuta;
      //emitimos un nuevo estado

      yield state.copyWith(polylines: currentPolylines);*/

    }
  }
}
