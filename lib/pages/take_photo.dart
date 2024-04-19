import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'preview_food.dart';

class TakePhoto extends StatefulWidget {
  const TakePhoto({Key? key}) : super(key: key);

  @override
  State<TakePhoto> createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  late CameraController? _controller;
  late List<CameraDescription> cameras;

  @override
  void initState() {
    super.initState();
    _controller = null;
    availableCameras().then((List<CameraDescription> cameraList) {
      cameras = cameraList;
      if (cameras.isNotEmpty) {
        _controller = CameraController(cameras[0], ResolutionPreset.max);
        _controller?.initialize().then((_) {
          if (!mounted) return;
          setState(() {});
        }).catchError((Object e) {
          if (e is CameraException) {
            print('Camera initialization error: ${e.description}');
          }
        });
      } else {
        print('No camera available');
      }
    }).catchError((e) {
      print('Failed to get camera list: $e');
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller?.value.isInitialized ?? false
          ? buildCameraPreview()
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget buildCameraPreview() {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: CameraPreview(_controller!),
          ),
        ),
        Positioned(
          left: 20,
          top: 40,
          child: backButton(context),
        ),
        buildCameraControls(),
      ],
    );
  }

  Widget backButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: const CircleAvatar(
        backgroundColor: Colors.white70,
        child: Icon(Icons.arrow_back, color: Colors.black),
      ),
    );
  }

  Positioned buildCameraControls() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.black54,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            cameraButton(onPressed: onTakePictureButtonPressed),
            flashButton(),
          ],
        ),
      ),
    );
  }

  Widget cameraButton({required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: const CircleAvatar(
        radius: 30,
        backgroundColor: Colors.white70,
        child: Icon(Icons.camera_alt, color: Colors.black87),
      ),
    );
  }

  Widget flashButton() {
    return GestureDetector(
      onTap: toggleFlashMode,
      child: const CircleAvatar(
        radius: 30,
        backgroundColor: Colors.white70,
        child: Icon(Icons.flash_on, color: Colors.black87),
      ),
    );
  }

  void toggleFlashMode() {
    setState(() {
      _controller!.setFlashMode(
        _controller!.value.flashMode == FlashMode.off
            ? FlashMode.torch
            : FlashMode.off,
      );
    });
  }

  Future<void> onTakePictureButtonPressed() async {
    try {
      final XFile? image = await _controller!.takePicture();
      if (image != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PreviewFood(image: image),
          ),
        );
      }
    } catch (e) {
      print('Error taking picture: $e');
      if (e is CameraException) {
        print('Camera exception: ${e.description}');
      }
    }
  }
}
