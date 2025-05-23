import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MapPlace extends StatelessWidget {
  const MapPlace({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments ?? "__";
    final double lat = args[0];
    final double lng = args[1];

    return Scaffold(
      appBar: AppBar(
        title: Text('위치 보기'),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(lat, lng),
          initialZoom: 15,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 80,
                height: 80,
                point: LatLng(lat, lng),
                child: Icon(Icons.pin_drop,
                    size: 50,
                    color: Colors.red,
                )
              )
            ]
          )
        ]
        
        ),

    );
  }
}