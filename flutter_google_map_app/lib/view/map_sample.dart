import 'package:flutter/material.dart';
import 'package:flutter_google_map_app/vm/vm_map_handler.dart';
import 'package:flutter_google_map_app/vm/vm_parking_lot_handler.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatelessWidget {
  const MapSample({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<VmMapHandler>();
    final parkingLotVm = Get.find<VmParkingLotHandler>();

    return Scaffold(
      appBar: AppBar(title: Text("내 위치 지도")),
      body: Obx(() {
        if (!vm.canRun.value || parkingLotVm.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // 현재 위치 마커 + 주차장 마커 병합
        final Set<Marker> allMarkers = {
          ...vm.currentMarkers,
          ...parkingLotVm.parkingLots.map((lot) {
            return Marker(
              markerId: MarkerId(lot.code),
              position: LatLng(lot.lat, lot.lng),
              infoWindow: InfoWindow(title: lot.name),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
            );
          }).toSet()
        };

        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(vm.latData.value, vm.longData.value),
            zoom: 14,
          ),
          onMapCreated: (GoogleMapController controller) {
            vm.mapController.complete(controller);
          },
          markers: allMarkers,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          mapType: MapType.normal,
        );
      }),
    );
  }
}