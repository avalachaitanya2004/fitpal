// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tflite/tflite.dart';

// class TfliteModel extends StatefulWidget {
//   const TfliteModel({Key? key}) : super(key: key);

//   @override
//   _TfliteModelState createState() => _TfliteModelState();
// }

// class _TfliteModelState extends State<TfliteModel> {
//   late File _image;
//   late List _results;
//   bool imageSelect = false;
//   @override
//   void initState() {
//     super.initState();
//     loadModel();
//   }

//   Future loadModel() async {
//     Tflite.close();
//     String res;
//     res = (await Tflite.loadModel(
//         model: "assets/model.tflite", labels: "assets/labels.txt"))!;
//     print("Models loading status: $res");
//   }

//   Future imageClassification(File image) async {
//     try {
//       final List? recognitions = await Tflite.runModelOnImage(
//         path: image.path,
//         numResults: 6,
//         threshold: 0,
//         imageMean: 127.5,
//         imageStd: 127.5,
//       );
//       setState(() {
//         _results = recognitions!;
//         _image = image;
//         imageSelect = true;
//         print(_results);
//         var v = recognitions.toString();
//         var dataList = List<Map<String, dynamic>>.from(jsonDecode(v));
//         print(dataList);
//       });
//     } catch (e) {
//       print('Error running model: $e');
//       // Handle the error in a way suitable for your app context
//     }
//   }
//   // Future imageClassification(File image) async {
//   //   int startTime = new DateTime.now().millisecondsSinceEpoch;
//   //   var recognitions = await Tflite.runModelOnImage(
//   //     path: image.path,
//   //     numResults: 6,
//   //     threshold: 0.05,
//   //     imageMean: 127.5,
//   //     imageStd: 127.5,
//   //   );
//   //   setState(() {
//   //     _results = recognitions!;
//   //     // v = recognitions.toString();
//   //     // dataList = List<Map<String, dynamic>>.from(jsonDecode(v));
//   //   });
//   //   print("//////////////////////////////////////////////////");
//   //   print(_results);
//   //   // print(dataList);
//   //   print("//////////////////////////////////////////////////");
//   //   int endTime = new DateTime.now().millisecondsSinceEpoch;
//   //   print("Inference took ${endTime - startTime}ms");
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Image Classification"),
//       ),
//       body: ListView(
//         children: [
//           (imageSelect)
//               ? Container(
//                   margin: const EdgeInsets.all(10),
//                   child: Image.file(_image),
//                 )
//               : Container(
//                   margin: const EdgeInsets.all(10),
//                   child: const Opacity(
//                     opacity: 0.8,
//                     child: Center(
//                       child: Text("No image selected"),
//                     ),
//                   ),
//                 ),
//           SingleChildScrollView(
//             child: Column(
//               children: (imageSelect)
//                   ? _results.map((result) {
//                       return Card(
//                         child: Container(
//                           margin: EdgeInsets.all(10),
//                           child: Text(
//                             "${result['label']} - ${result['confidence'].toStringAsFixed(2)}",
//                             style: const TextStyle(
//                                 color: Colors.red, fontSize: 20),
//                           ),
//                         ),
//                       );
//                     }).toList()
//                   : [],
//             ),
//           )
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: pickImage,
//         tooltip: "Pick Image",
//         child: const Icon(Icons.image),
//       ),
//     );
//   }

//   Future pickImage() async {
//     final ImagePicker _picker = ImagePicker();
//     final XFile? pickedFile = await _picker.pickImage(
//       source: ImageSource.gallery,
//     );
//     File image = File(pickedFile!.path);
//     imageClassification(image);
//   }
// }
