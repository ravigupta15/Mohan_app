import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
   static Future imagePicker(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? img = await picker.pickImage(
      source: source,imageQuality: 70
    );
    if (img==null) return null;
  return File(img.path);
  }
}