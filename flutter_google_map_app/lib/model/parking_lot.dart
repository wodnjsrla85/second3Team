/// 서울시 공영주차장 간략 정보 모델
class ParkingLot {
  final String name;                  // 주차장명 (PKLT_NM)
  final String address;              // 주소 (ADDR)
  final String code;                 // 주차장 코드 (PKLT_CD)
  final String kind;                 // 주차장 종류 (PKLT_KND)
  final String kindName;            // 주차장 종류명 (PKLT_KND_NM)
  final String operationType;       // 운영 구분 (OPER_SE)
  final String operationTypeName;   // 운영 구분명 (OPER_SE_NM)
  final String tel;                 // 전화번호 (TELNO)
  final String nowInfoYn;           // 주차현황 정보 제공여부 (PRK_NOW_INFO_PVSN_YN)
  final String nowInfoYnName;       // 주차현황 정보 제공여부명 (PRK_NOW_INFO_PVSN_YN_NM)
  final int totalSpaces;            // 총 주차면 (TPKCT)
  final String chargedFree;         // 유무료 구분 (CHGD_FREE_SE)
  final String chargedFreeName;     // 유무료 구분명 (CHGD_FREE_NM)
  final String nightFreeOpenYn;     // 야간 무료 개방 여부 (NGHT_FREE_OPN_YN)
  final String nightFreeOpenName;   // 야간 무료 개방 여부명 (NGHT_FREE_OPN_YN_NAME)
  final String weekdayStart;        // 평일 운영 시작 시각 (WD_OPER_BGNG_TM)
  final String weekdayEnd;          // 평일 운영 종료 시각 (WD_OPER_END_TM)
  final String weekendStart;        // 주말 운영 시작 시각 (WE_OPER_BGNG_TM)
  final String weekendEnd;          // 주말 운영 종료 시각 (WE_OPER_END_TM)
  final String holidayStart;        // 공휴일 운영 시작 시각 (LHLDY_BGNG)
  final String holidayEnd;          // 공휴일 운영 종료 시각 (LHLDY)
  final String lastSync;            // 최종 데이터 동기화 시간 (LAST_DATA_SYNC_TM)
  final String saturdayCharged;     // 토요일 유무료 구분 (SAT_CHGD_FREE_SE)
  final String saturdayChargedName; // 토요일 유무료 구분명 (SAT_CHGD_FREE_NM)
  final String holidayCharged;      // 공휴일 유무료 구분 (LHLDY_YN)
  final String holidayChargedName;  // 공휴일 유무료 구분명 (LHLDY_NM)
  final String monthlyCharge;       // 월 정기권 금액 (MNTL_CMUT_CRG)
  final int baseCharge;             // 기본 주차 요금 (PRK_CRG)
  final int baseMinutes;            // 기본 주차 시간 (PRK_HM)
  final int addCharge;              // 추가 요금 (ADD_CRG)
  final int addMinutes;             // 추가 시간 (ADD_UNIT_TM_MNT)
  final double lat;                 // 위도 (LAT)
  final double lng;                 // 경도 (LOT)

  ParkingLot({
    required this.name,
    required this.address,
    required this.code,
    required this.kind,
    required this.kindName,
    required this.operationType,
    required this.operationTypeName,
    required this.tel,
    required this.nowInfoYn,
    required this.nowInfoYnName,
    required this.totalSpaces,
    required this.chargedFree,
    required this.chargedFreeName,
    required this.nightFreeOpenYn,
    required this.nightFreeOpenName,
    required this.weekdayStart,
    required this.weekdayEnd,
    required this.weekendStart,
    required this.weekendEnd,
    required this.holidayStart,
    required this.holidayEnd,
    required this.lastSync,
    required this.saturdayCharged,
    required this.saturdayChargedName,
    required this.holidayCharged,
    required this.holidayChargedName,
    required this.monthlyCharge,
    required this.baseCharge,
    required this.baseMinutes,
    required this.addCharge,
    required this.addMinutes,
    required this.lat,
    required this.lng,
  });

  factory ParkingLot.fromJson(Map<String, dynamic> json) {
    return ParkingLot(
      name: json['PKLT_NM'] ?? '',
      address: json['ADDR'] ?? '',
      code: json['PKLT_CD'] ?? '',
      kind: json['PKLT_KND'] ?? '',
      kindName: json['PKLT_KND_NM'] ?? '',
      operationType: json['OPER_SE'] ?? '',
      operationTypeName: json['OPER_SE_NM'] ?? '',
      tel: json['TELNO'] ?? '',
      nowInfoYn: json['PRK_NOW_INFO_PVSN_YN'] ?? '',
      nowInfoYnName: json['PRK_NOW_INFO_PVSN_YN_NM'] ?? '',
      totalSpaces: int.tryParse(json['TPKCT'].toString()) ?? 0,
      chargedFree: json['CHGD_FREE_SE'] ?? '',
      chargedFreeName: json['CHGD_FREE_NM'] ?? '',
      nightFreeOpenYn: json['NGHT_FREE_OPN_YN'] ?? '',
      nightFreeOpenName: json['NGHT_FREE_OPN_YN_NAME'] ?? '',
      weekdayStart: json['WD_OPER_BGNG_TM'] ?? '',
      weekdayEnd: json['WD_OPER_END_TM'] ?? '',
      weekendStart: json['WE_OPER_BGNG_TM'] ?? '',
      weekendEnd: json['WE_OPER_END_TM'] ?? '',
      holidayStart: json['LHLDY_BGNG'] ?? '',
      holidayEnd: json['LHLDY'] ?? '',
      lastSync: json['LAST_DATA_SYNC_TM'] ?? '',
      saturdayCharged: json['SAT_CHGD_FREE_SE'] ?? '',
      saturdayChargedName: json['SAT_CHGD_FREE_NM'] ?? '',
      holidayCharged: json['LHLDY_YN'] ?? '',
      holidayChargedName: json['LHLDY_NM'] ?? '',
      monthlyCharge: json['MNTL_CMUT_CRG'] ?? '',
      baseCharge: int.tryParse(json['PRK_CRG'].toString()) ?? 0,
      baseMinutes: int.tryParse(json['PRK_HM'].toString()) ?? 0,
      addCharge: int.tryParse(json['ADD_CRG'].toString()) ?? 0,
      addMinutes: int.tryParse(json['ADD_UNIT_TM_MNT'].toString()) ?? 0,
      lat: double.tryParse(json['LAT'].toString()) ?? 0.0,
      lng: double.tryParse(json['LOT'].toString()) ?? 0.0,
    );
  }
}