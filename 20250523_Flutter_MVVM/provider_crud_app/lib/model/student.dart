class Student {
  final String scode;
  final String sname;
  final String sdept;
  final String sphone;
  final String saddress;
  
  Student(
    {
      required this.scode,
      required this.sname,
      required this.sdept,
      required this.sphone,
      required this.saddress
    }
  );

  // 서버에서 받은 JSON -> Student 객체
  factory Student.fromJson(List<dynamic> json){
    return Student(
      scode: json[0] ?? "", 
      sname: json[1] ?? "", 
      sdept: json[2] ?? "", 
      sphone: json[3] ?? "", 
      saddress:json[4] ?? "__",
      );
  }

  // Student -> Map
  Map<String, dynamic> toMap(){
    return{
      'scode': scode,
      'sname': sname,
      'sdept': sdept,
      'sphone': sphone,
      'saddress': saddress,
    };
  }

  // 복사본 생성시 특정 필드만 변경 // 못가져 오면 기존거 쓴다.
  Student copyWith(
    {
      String? scode,
      String? sname,
      String? sdept,
      String? sphone,
      String? saddress,
    }) {
      return Student(
        scode: scode ?? this.scode,
        sname: sname ?? this.sname,
        sdept: sdept ?? this.sdept,
        sphone: sphone ?? this.sphone,
        saddress: saddress ?? this.saddress,
      );
    }

}