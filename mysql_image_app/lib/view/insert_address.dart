import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class InsertAddress extends StatefulWidget {
  const InsertAddress({super.key});

  @override
  State<InsertAddress> createState() => _InsertAddressState();
}

class _InsertAddressState extends State<InsertAddress> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController relationController = TextEditingController();

  XFile? imageFile;
  final ImagePicker picker = ImagePicker();

  String filename = ""; // ImagePicker에서 선택한 filename

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('주소록 입력'),
      ),
      body: Center(
        child: Column(

          children: [
            _buildTextField(nameController, "이름을 입력하세요"),
            _buildTextField(phoneController, "전화번호을 입력하세요"),
            _buildTextField(addressController, "주소을 입력하세요"),
            _buildTextField(relationController, "관계을 입력하세요"),
            ElevatedButton(
              onPressed:() => getImageFromGallery(ImageSource.gallery), 
              child: Text('이미지 가져오기'),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              color: Colors.grey,
              child: Center(
                child: imageFile == null 
                ? Text('이미지가 선택되지 않았습니다.')
                : Image.file(File(imageFile!.path)),
              ),
            ),
            ElevatedButton(
              onPressed: () => InsertAction(), 
              child: Text('입력')
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildTextField(TextEditingController controller, String labelText){
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }


  getImageFromGallery(ImageSource imageSource) async{
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    imageFile = XFile(pickedFile!.path);
    setState(() {});
  }

  //백엔드에서 multipart를 쓰기 때문에 multipart사용 (이미지 때문에 사용 퍼포먼스때문에)
  InsertAction() async{
    var request = http.MultipartRequest(
      "POST", 
      Uri.parse('http://127.0.0.1:8000/insert'),
    );
    request.fields['name'] = nameController.text;
    request.fields['phone'] = phoneController.text;
    request.fields['address'] = addressController.text;
    request.fields['relation'] = relationController.text;
    if(imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath('file', imageFile!.path));
    }

    var res = await request.send();
    if(res.statusCode == 200){
      showDialog();
    }else{
      errorSnackBar();
    }
  }

  showDialog(){
    Get.defaultDialog(
      title: '입력 결과',
      middleText: '입력이 완료 되었습니다.',
      barrierDismissible: false,
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            Get.back();
          }, 
          child: Text('OK')
        ),
      ]
    );
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