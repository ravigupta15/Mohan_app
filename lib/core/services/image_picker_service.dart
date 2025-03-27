import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  
   static Future<File?> imagePicker(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? img = await picker.pickImage(
        source: source, 
        imageQuality: 55
      );

      // Check if an image was selected
      if (img == null) return null;

      // Return the image as a File
      return File(img.path);
    } catch (e) {
      // Handle any errors here, such as permission issues or other exceptions
      print('Error picking image: $e');
      return null;
    }
  }
}