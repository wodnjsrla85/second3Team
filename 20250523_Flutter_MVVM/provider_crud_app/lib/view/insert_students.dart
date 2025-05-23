import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:provider_crud_app/model/student.dart';

import '../vm/student_provider.dart';

class InsertStudents extends StatelessWidget {
  InsertStudents({super.key});
  
  final scodeController = TextEditingController();
  final snameController = TextEditingController();
  final sdeptController = TextEditingController();
  final sphoneController = TextEditingController();
  final saddressController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Insert Student'),
      ),
      body: Center(
        child: Column(
          children: [
            _buildTextField(scodeController, "학번", true),
            _buildTextField(snameController, "성명"),
            _buildTextField(sdeptController, "전공"),
            _buildTextField(sphoneController, "전화번호"),
            _buildTextField(saddressController, "주소"),

            ElevatedButton(
              onPressed: () {
                _insert(context);
              }, 
              child: Text('입력')
              )
          ],
        ),
      )
    );
  } // build

  // --- Widgets ---
  Widget _buildTextField(TextEditingController contoller, String label){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: contoller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }

  // --- Functions ---
  _insert(BuildContext context){
    Student student = Student(
      scode: scodeController.text.trim(), 
      sname: snameController.text.trim(), 
      sdept: sdeptController.text.trim(), 
      sphone: sphoneController.text.trim(), 
      saddress: saddressController.text.trim()
      );

    context.read<StudentModel>().insertStudent(student);
    Get.back();
    

  }

} // class