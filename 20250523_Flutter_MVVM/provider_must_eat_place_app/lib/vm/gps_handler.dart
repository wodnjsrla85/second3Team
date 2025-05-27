import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GpsModel with ChangeNotifier{
  String latitude = '';
  String longitude = '';

  Future<void> checkLocationPermission() async{
    LocationPermission permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
    }

    if(permission == LocationPermission.deniedForever) return;

    if(permission == LocationPermission.whileInUse || permission == LocationPermission.always){
      final position = await Geolocator.getCurrentPosition();
      latitude = position.latitude.toString();
      longitude = position.longitude.toString();
      notifyListeners();
    }
  }
}