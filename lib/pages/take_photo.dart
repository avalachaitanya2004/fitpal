import 'dart:ffi';

import 'package:camera/camera.dart';
import 'package:fit_pal/main.dart';
import 'package:fit_pal/pages/preview_food.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class TakePhoto extends StatefulWidget {
  const TakePhoto({super.key});

  @override
  State<TakePhoto> createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  late CameraController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(cameras[0], ResolutionPreset.max);
    _controller.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        print(e.description ?? "Camera error without a description.");
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    var cameraAspectRatio = _controller.value.aspectRatio;
    var scale = cameraAspectRatio * 0.7;

    Future<void> onTakePictureButtonPressed() async {
      try {
        final XFile? image = await _controller.takePicture();
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
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          ClipRect(
            child: Transform.scale(
              scale: scale,
              child: Center(
                child: CameraPreview(_controller),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 40,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.4),
                child: Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              color: Colors.black54,
              height: 0.125 * MediaQuery.of(context).size.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var i = 0; i < 2; i++)
                    GestureDetector(
                      onTap: onTakePictureButtonPressed,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            AssetImage('assets/images/default_pic.jpeg'),
                      ),
                    ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_controller.value.flashMode == FlashMode.off) {
                          _controller.setFlashMode(FlashMode.torch);
                        } else {
                          _controller.setFlashMode(FlashMode.off);
                        }
                      });
                    },
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage:
                          AssetImage('assets/images/default_pic.jpeg'),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
