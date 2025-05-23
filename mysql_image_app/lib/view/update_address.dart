import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart'as http;

class UpdateAddress extends StatefulWidget {
  const UpdateAddress({super.key});

  @override
  State<UpdateAddress> createState() => _UpdateAddressState();
}

class _UpdateAddressState extends State<UpdateAddress> {
TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController relationController = TextEditingController();

  var value = Get.arguments ?? "__";

  XFile? imageFile;
  final ImagePicker picker = ImagePicker();

  String filename = ""; // ImagePicker에서 선택한 filename

  // Gallery를 선택 했는지
  int firstDips = 0;

  @override
  void initState() {
    super.initState();
    nameController.text = value[1];
    phoneController.text = value[2];
    addressController.text = value[3];
    relationController.text = value[4];

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('주소록 수정'),
      ),
      body: Center(
        child: Column(

          children: [
            _buildTextField(nameController, "이름을 수정하세요"),
            _buildTextField(phoneController, "전화번호을 수장하세요"),
            _buildTextField(addressController, "주소을 수정하세요"),
            _buildTextField(relationController, "관계을 수정하세요"),
            ElevatedButton(
              onPressed:() => getImageFromGallery(ImageSource.gallery), 
              child: Text('이미지 가져오기'),
            ),
            firstDips == 0
            ? Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              color: Colors.grey,
              child: Center(
                child: Image.network(
                  "http://127.0.0.1:8000/view/${value[0]}?t=${DateTime.now().microsecondsSinceEpoch}"
                )
              ),
            )
            :
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
              onPressed: () => updateAction(), 
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
    firstDips += 1;
    setState(() {});
  }

  //백엔드에서 multipart를 쓰기 때문에 multipart사용 (이미지 때문에 사용 퍼포먼스때문에)
  updateAction() async{
    final uri = firstDips != 0 
    ? Uri.parse('http://127.0.0.1:8000/upadte_with_image')
    : Uri.parse('http://127.0.0.1:8000/update');
  

    var request = http.MultipartRequest(
      "POST", 
      uri,
    );

    request.fields['seq'] = value[0].toString();
    request.fields['name'] = nameController.text;
    request.fields['phone'] = phoneController.text;
    request.fields['address'] = addressController.text;
    request.fields['relation'] = relationController.text;

    if(firstDips != 0 && imageFile != null) {
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
      title: '수정 결과',
      middleText: '수정이 완료 되었습니다.',
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