import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:provider_crud_app/model/student.dart';
import 'package:provider_crud_app/vm/student_provider.dart';

class UpdateStudents extends StatelessWidget {
  UpdateStudents({super.key});

 final scodeController = TextEditingController();
  final snameController = TextEditingController();
  final sdeptController = TextEditingController();
  final sphoneController = TextEditingController();
  final saddressController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final arg = Get.arguments ?? "__";
    scodeController.text = arg[0];
    snameController.text = arg[1];
    sdeptController.text = arg[2];
    sphoneController.text = arg[3];
    saddressController.text = arg[4];
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Insert Student'),
      ),
      body: Center(
        child: Column(
          children: [
            _buildTextField(scodeController, "학번"),
            _buildTextField(snameController, "성명"),
            _buildTextField(sdeptController, "전공"),
            _buildTextField(sphoneController, "전화번호"),
            _buildTextField(saddressController, "주소"),

            ElevatedButton(
              onPressed: () {
                _update(context);
              }, 
              child: Text('수정')
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
        readOnly: label =='학번'?true:false,
      ),
    );
  }

  // --- Functions ---
  _update(BuildContext context){
    Student student = Student(
      scode: scodeController.text.trim(), 
      sname: snameController.text.trim(), 
      sdept: sdeptController.text.trim(), 
      sphone: sphoneController.text.trim(), 
      saddress: saddressController.text.trim()
      );

    context.read<StudentModel>().updateStudent(student);
    Get.back();
    

  }

} // class