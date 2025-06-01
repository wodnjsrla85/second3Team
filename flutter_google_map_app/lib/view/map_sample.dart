import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {
  late Position currentPosition;
  late double latData;
  late double longData;
  late bool canRun;

  final Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    canRun = false;
    checkLocationPermission();
  }

  Future<void> checkLocationPermission() async {
    // print("위치 권한 확인 시작");
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      // print("권한 요청: denied 요청 중");
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      // print("위치 권한 영구 거부됨");
      return;
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      // print("권한 승인 현재 위치 요청");
      getCurrentLocation();
    }
  }

  Future<void> getCurrentLocation() async {
    // print("현재 위치 요청 중");
    Position position = await Geolocator.getCurrentPosition();
    // print("위치 받아옴: ${position.latitude}, ${position.longitude}");

    currentPosition = position;
    latData = position.latitude;
    longData = position.longitude;

    canRun = true;
    setState(() {});


    // 카메라 중심을 현재 위치로
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(
      LatLng(latData, longData),
      17.0,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("내 위치 지도")),
      body: canRun
          ? GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(latData, longData),
                zoom: 17,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: {
                Marker(
                  markerId: MarkerId("currentLocation"),
                  position: LatLng(latData, longData),
                  infoWindow: InfoWindow(title: "내 위치"),
                ),
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}