import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


import '../model/student.dart'; 

class StudentModel with ChangeNotifier {
  final String baseUrl = "http://127.0.0.1:8000";

  List<Student> _students = [];
  bool isLoading = false;
  String? error;

  List<Student> get students => _students;

  Future<void> fetchStudents() async {
    isLoading = true;
    error = null;
    notifyListeners(); // 로딩 시작 알림

    try {
      final res = await http.get(Uri.parse("$baseUrl/select"));
      final data = json.decode(utf8.decode(res.bodyBytes));

      _students = (data['results'] as List)
          .map((d) => Student.fromJson(d))
          .toList();
    } catch (e) {
      error = "불러오기 실패: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<String> insertStudent(Student s) async {
    final url = Uri.parse(
      "$baseUrl/insert?code=${s.scode}&name=${s.sname}&phone=${s.sphone}&dept=${s.sdept}&address=${s.saddress}",
    );

    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        await fetchStudents(); 
        return "등록 성공";
      } else {
        return "등록 실패: ${res.statusCode}";
      }
    } catch (e) {
      return "오류 발생: $e";
    }
  }

  Future<String> updateStudent(Student s) async {
    final url = Uri.parse(
      "$baseUrl/update?code=${s.scode}&name=${s.sname}&phone=${s.sphone}&dept=${s.sdept}&address=${s.saddress}",
    );

    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        await fetchStudents(); 
        return "수정 성공";
      } else {
        return "수정 실패: ${res.statusCode}";
      }
    } catch (e) {
      return "오류 발생: $e";
    }
  }

    Future<String> deleteStudent(String scode) async {
    final url = Uri.parse(
      "$baseUrl/delete?code=$scode",
    );

    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        await fetchStudents(); 
        return "삭제 성공";
      } else {
        return "삭제 실패: ${res.statusCode}";
      }
    } catch (e) {
      return "오류 발생: $e";
    }
  }



}


