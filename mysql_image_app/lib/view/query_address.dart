import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mysql_image_app/view/insert_address.dart';
import 'package:mysql_image_app/view/update_address.dart';

class QueryAddress extends StatefulWidget {
  const QueryAddress({super.key});

  @override
  State<QueryAddress> createState() => _QueryAddressState();
}

class _QueryAddressState extends State<QueryAddress> {
  List data = [];

  @override
  void initState() {
    super.initState();
    getJSONData();
  }

  getJSONData() async{
    var response = await http.get(Uri.parse("http://127.0.0.1:8000/select"));
    data.clear();
    data.addAll(json.decode(utf8.decode(response.bodyBytes))['results']);
    //model을 사용하지 않으니깐 데이터에 다 넣어버린다.
    setState(() {});
    // print(data);
  }
  //퍼포먼스 때문에 그때 그때 이미지를 가지고 올거다

  // -------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('주소록 검색'),
        actions: [
          IconButton(
            onPressed: () => Get.to(InsertAddress())!.then((value) => getJSONData(),), 
            icon: Icon(Icons.add_outlined)
          )
        ],
      ),
      body: Center(
        child: data.isEmpty
        ? Center(child: Text('데이터가 없습니다.'),)
        : ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(
                  UpdateAddress(), 
                  arguments: [
                    data[index]['seq'],
                    data[index]['name'],
                    data[index]['phone'],
                    data[index]['address'],
                    data[index]['relation'],
                  ]
                  )!.then((value) => getJSONData());
              },
              child: Slidable(
                endActionPane: ActionPane(
                  motion: BehindMotion(), 
                  children: [
                    SlidableAction(
                      backgroundColor: Colors.red,
                      icon: Icons.delete_forever,
                      label: 'Delete',
                      onPressed: (context) {
                        deleteAction(data[index]['seq']);
                      },
                    )
                  ]
                ),
                child: Card(
                  child: Row(
                    children: [
                      //이미지를 백엔드에서 불러오는 방법 ?t=~ 이미지가 바뀌면 바뀐 값을 가지고 오는거 = 밀리 세컨드 단위로 바꿔라
                      Image.network("http://127.0.0.1:8000/view/${data[index]['seq']}?t=${DateTime.now().microsecondsSinceEpoch}",
                      width: 100,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('이름 : ${data[index]['name']}'),
                          Text('전화번호 : ${data[index]['phone']}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  deleteAction(int seq){
    getJSONDataDelete(seq);
    getJSONData();
  }

  getJSONDataDelete(int seq) async{
    var response = await http.delete(Uri.parse("http://127.0.0.1:8000/delete/$seq"));
    var result = json.decode(utf8.decode(response.bodyBytes))['result'];
    if(result != "OK"){
      errorSnackBar();
    }
  }

  errorSnackBar(){
    Get.snackbar(
      'ERROR', 
      'ERROR',
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}