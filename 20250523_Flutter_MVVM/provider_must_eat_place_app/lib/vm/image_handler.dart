import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageModel with ChangeNotifier{
  final ImagePicker picker = ImagePicker(); // 사진 선택 실행
  XFile? imageFile;

  Future<void> getImageFromGallery(ImageSource source)async{
    final pickedFile = await picker.pickImage(source: source);
    if(pickedFile != null){
      imageFile = pickedFile;
      notifyListeners();
    }
  }

  void clearImage(){
    imageFile = null;
    notifyListeners();
  }
}