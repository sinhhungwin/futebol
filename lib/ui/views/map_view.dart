import 'package:fimii/scoped_models/map_model.dart';
import 'package:fimii/ui/views/your_aqi_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong/latlong.dart" as latLng;

import 'base_view.dart';

class MapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<MapModel>(
        builder: (context, child, model) => Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => YourAqiView(
                    coordinates: model.marker.point ,
                  )),
            ),
            child: Icon(Icons.search_rounded),
          ),
          // body: FlutterMap(
          //   options: MapOptions(
          //     center: latLng.LatLng(34, -118),
          //     zoom: 13
          //   ),
          //   layers: [
          //     TileLayerOptions(
          //       urlTemplate: "https://api.mapbox.com/styles/v1/"
          //           "{id}/tiles/{z}/{x}/{y}?access_token={accessToken}",
          //       additionalOptions: {
          //         'accessToken' : "pk.eyJ1Ijoic2luaGh1bmduZ3V5ZW44IiwiYSI6ImNsMGRqa2hjbzA5bmYzZHBvc3Y0aWdmaDQifQ.WKMQsv-X5mDi0gFqVcW0sA",
          //         'id' : 'mapbox/dark-v10'
          //       }
          //     )
          //   ],
          // ),
          body: FlutterMap(
            options: MapOptions(
              onTap: (point) {
                model.changeMarker(point);
              },
              center: latLng.LatLng(21.030500, 105.763794),
              zoom: 13.0,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
                // attributionBuilder: (_) {
                //   return Text("© OpenStreetMap contributors");
                // },
              ),
              MarkerLayerOptions(
                markers: [
                  model.marker
                  // Marker(
                  //   width: 80.0,
                  //   height: 80.0,
                  //   point: latLng.LatLng(51.5, -0.09),
                  //   builder: (ctx) =>
                  //       Container(
                  //         child: FlutterLogo(),
                  //       ),
                  // ),
                ],
              ),
            ],
          ),
        ));
  }
}
