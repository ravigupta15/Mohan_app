import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late List<CameraDescription> cameras;
  late CameraController controller;
  bool isCameraInitialized = false;
  int selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    _setCamera(selectedCameraIndex);
  }

  Future<void> _setCamera(int index) async {
    controller = CameraController(
      cameras[index],
      ResolutionPreset.high,
      enableAudio: false,
    );

    await controller.initialize();
    setState(() {
      isCameraInitialized = true;
    });
  }

  Future<void> _takePicture() async {
    if (!controller.value.isInitialized) return;

    try {
      final Directory appDirectory = await getApplicationDocumentsDirectory();
      final String filePath = '${appDirectory.path}/${DateTime.now().millisecondsSinceEpoch}.png';

      XFile picture = await controller.takePicture();
      await picture.saveTo(filePath);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmationScreen(imagePath: filePath),
        ),
      );
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  Future<void> _switchCamera() async {
    selectedCameraIndex = (selectedCameraIndex + 1) % cameras.length;
    await controller.dispose();
    await _setCamera(selectedCameraIndex);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: isCameraInitialized
          ? Stack(
              children: [
                CameraPreview(controller),
                Positioned(
                  bottom: 10,
                  left: MediaQuery.of(context).size.width / 2 - 35,
                  child: GestureDetector(
                    onTap: _takePicture,
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 2),
                      ),
                      child: Icon(Icons.camera_alt, color: Colors.black, size: 30),
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: IconButton(
                    icon: Icon(
                      Icons.switch_camera,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: _switchCamera,
                  ),
                ),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

class ConfirmationScreen extends StatelessWidget {
  final String imagePath;

  ConfirmationScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.arcticBreeze,
      body: Stack(
        children: [
          Image.file(File(imagePath), fit: BoxFit.cover),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30,left: 30,right: 30),
                  child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close,color: AppColors.whiteColor,size: 30,)),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context,File(imagePath) );
                      Navigator.pop(context, File(imagePath) );
                    },
                    child: Icon(Icons.check,color: AppColors.whiteColor,size: 30,)),
                               
                              ],
                            ),
                ),
              ),
      
        ],
      ),
    );
  }
}
