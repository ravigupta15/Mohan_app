import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerService {
  
  static Future<void> requestPermissions() async {
  final PermissionStatus cameraStatus = await Permission.camera.request();
  final PermissionStatus storageStatus = await Permission.storage.request();

  if (cameraStatus.isGranted && storageStatus.isGranted) {
    // Permissions granted, proceed with camera usage
  } else {
    // Permissions not granted, handle accordingly
  }
}
   static Future imagePicker(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? img = await picker.pickImage(
        source: source, 
        imageQuality: 50, 
         maxWidth: 800,  // Resize image to reduce memory usage
        maxHeight: 800, // Resize image to reduce memory usage
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