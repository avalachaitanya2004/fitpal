import 'package:camera/camera.dart';
import 'package:fit_pal/main.dart';
import 'package:flutter/material.dart';

class TakePhoto extends StatefulWidget {
  const TakePhoto({super.key});

  @override
  State<TakePhoto> createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  late CameraController _con;
  @override
  void initState() {
    _con = CameraController(cameras[0], ResolutionPreset.max);
    _con.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print("access was denied");
            break;
          default:
            print(e.description);
            break;
        }
      }
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            child: CameraPreview(_con),
          )
        ],
      ),
    );
  }
}
