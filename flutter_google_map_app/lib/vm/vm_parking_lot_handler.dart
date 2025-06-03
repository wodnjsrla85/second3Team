import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/parking_lot.dart';

class VmParkingLotHandler extends GetxController {
  final RxList<ParkingLot> parkingLots = <ParkingLot>[].obs;
  final RxBool isLoading = false.obs;
  

  @override
  void onInit() {
    super.onInit();
    fetchParkingLots();
  }

  Future<void> fetchParkingLots({int start = 1, int end = 100}) async {
    isLoading.value = true;
    final url = Uri.parse(
        'http://openapi.seoul.go.kr:8088/637478474963616e37385344636258/json/GetParkInfo/$start/$end');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));
        final List<dynamic> rows = data['GetParkInfo']['row'];

        final List<ParkingLot> lots = rows
            .map((json) => ParkingLot.fromJson(json))
            .where((lot) => lot.lat != 0 && lot.lng != 0)
            .toList();

        parkingLots.assignAll(lots);
      } else {
        Get.snackbar('에러', '데이터를 불러오는 데 실패했습니다.');
      }
    } catch (e) {
      Get.snackbar('에러', '오류 발생: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void reload() {
    fetchParkingLots();
  }
}
