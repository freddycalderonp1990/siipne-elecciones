import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class myPolylines extends Polyline {

  final List<LatLng> points;
  final List<Offset> offsets = [];
  final double strokeWidth;
  final Color color;
  final double borderStrokeWidth;
  final Color borderColor;
  final List<Color> gradientColors;
  final List<double> colorsStop;
  final bool isDotted;


  myPolylines({
    this.points,
    this.strokeWidth = 1.0,
    this.color = const Color(0xFF00FF00),
    this.borderStrokeWidth = 0.0,
    this.borderColor = const Color(0xFFFFFF00),
    this.gradientColors,
    this.colorsStop,
    this.isDotted = false,
  }){

   Polyline(color: this.color,points: this.points,strokeWidth: this.strokeWidth,gradientColors: this.gradientColors) ;
  }

  copyWith({final List<LatLng> points}) {
   return  Polyline(  points:points ?? this.points);


  }

}