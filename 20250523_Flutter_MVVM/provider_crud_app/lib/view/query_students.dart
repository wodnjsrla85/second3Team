import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:provider_crud_app/view/insert_students.dart';
import 'package:provider_crud_app/view/update_students.dart';
import 'package:provider_crud_app/vm/student_provider.dart';

class QueryStudents extends StatelessWidget {
  const QueryStudents({super.key});

  @override
  Widget build(BuildContext context) {
    final studentModel = context.watch<StudentModel>();
    final students = studentModel.students;

    return Scaffold(
      appBar: AppBar(
        title: Text('Provider CRUD for Students'),
        actions: [
          IconButton(
            onPressed: () => Get.to(()=> InsertStudents()), 
            icon: Icon(Icons.add)
            ),
        ],
      ),
      body: studentModel.isLoading
      ? Center(child: CircularProgressIndicator())
      : ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final s = students[index];
          return GestureDetector(
            onLongPress: () {
              _showDialog(context, students[index].scode);
            },
            onTap: () {
              Get.to(()=>UpdateStudents(),
              arguments: [
                s.scode,
                s.sname,
                s.sdept,
                s.sphone,
                s.saddress
              ]
              );
            },
            child: ListTile(
              title: Text("${s.sname} (${s.scode})"),
              subtitle: Text("${s.sdept} | ${s.sphone}"),
            ),
          );
        },
      ),
    );
  } // build

  _showDialog(BuildContext context, String scode) {
    Get.defaultDialog(
      title: '삭제 여부',
      middleText: '정말로 삭제하시겠습니까?',
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              Get.back();
            }, 
            child: Text('아니오')
          ),
          TextButton(
            onPressed: () {
              context.read<StudentModel>().deleteStudent(scode);
              Get.back();
            }, 
            child: Text('예')
          ),
        ],
      )
    );
}

} // class