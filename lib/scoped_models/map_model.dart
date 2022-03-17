import 'package:fimii/scoped_models/base_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong/latlong.dart" as latLng;

class MapModel extends BaseModel {
  Marker marker = Marker(
    width: 30.0,
    height: 30.0,
    point: latLng.LatLng(21.030500, 105.763794),
    builder: (ctx) => Container(
      child: Icon(Icons.pin_drop, color: Colors.redAccent,),
    ),
  );

  changeMarker(latLng.LatLng point) {
    marker = Marker(
      width: 30.0,
      height: 30.0,
      point: point,
      builder: (ctx) => Container(
        child: Icon(Icons.pin_drop, color: Colors.redAccent,),
      ),
    );

    notifyListeners();
  }
}
