// import 'dart:io';
// import 'package:path/path.dart' as path;
// import 'package:image_picker/image_picker.dart';

// Future<void> _pickImageFromGallery() async {
//   final pickedImage =
//       await ImagePicker().pickImage(source: ImageSource.gallery);
//   if (pickedImage != null) {
//     // Handle the picked image
//     uploadImageToFirebase(pickedImage.path);
//   }
// }

// Future<void> _pickImageFromCamera() async {
//   final takenImage = await ImagePicker().pickImage(source: ImageSource.camera);
//   if (takenImage != null) {
//     // Handle the taken image
//     uploadImageToFirebase(takenImage.path);
//   }
// }

// Future<String?> uploadImageToFirebase(String filePath) async {
//   try {
//     File imageFile = File(filePath);
//     String fileName = path.basename(imageFile.path);
//     TaskSnapshot taskSnapshot = await FirebaseStorage.instance
//         .ref('images/$fileName')
//         .putFile(imageFile);
//     String downloadUrl = await taskSnapshot.ref.getDownloadURL();
//     // Return the download URL
//     return downloadUrl;
//   } catch (e) {
//     print('Error uploading image to Firebase Storage: $e');
//     return null; // Return null in case of error
//   }
// }
