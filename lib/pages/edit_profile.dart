import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fit_pal/DataBaseServices/Intialziedata.dart';
import 'package:fit_pal/DataBaseServices/useruid.dart';
import 'package:fit_pal/Profileimage.dart';
import 'package:fit_pal/pages/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  Future<void> getImage() async {
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      try {
        setState(() {
          _image = File(imageFile.path);
        });

        String filename = DateTime.now().millisecondsSinceEpoch.toString();
        Reference referenceRoot = FirebaseStorage.instance.ref();
        Reference referenceDirImages = referenceRoot.child('Profile');
        Reference referenceImageToUpload = referenceDirImages.child(filename);

        await referenceImageToUpload.putFile(
          File(imageFile.path),
          SettableMetadata(contentType: 'image/jpeg'),
        );

        String imageUrl = await referenceImageToUpload.getDownloadURL();
        print(imageUrl);
        Profilepage profilePage =
            Profilepage(uid: FirebaseAuth.instance.currentUser!.uid);
        await profilePage.setProfileLink(imageUrl);

        print('Image uploaded successfully: $imageUrl');
      } catch (e) {
        print('Error uploading image: $e');
      }
    } else {
      print('No image selected');
    }

    Navigator.pop(context);
  }

  Future<void> imageFromCamera() async {
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.camera);

    if (imageFile != null) {
      try {
        setState(() {
          _image = File(imageFile.path);
        });

        String filename = DateTime.now().millisecondsSinceEpoch.toString();
        Reference referenceRoot = FirebaseStorage.instance.ref();
        Reference referenceDirImages = referenceRoot.child('Profile');
        Reference referenceImageToUpload = referenceDirImages.child(filename);

        await referenceImageToUpload.putFile(
          File(imageFile.path),
          SettableMetadata(contentType: 'image/jpeg'),
        );

        String imageUrl = await referenceImageToUpload.getDownloadURL();
        print(imageUrl);
        Profilepage profilePage =
            Profilepage(uid: FirebaseAuth.instance.currentUser!.uid);
        await profilePage.setProfileLink(imageUrl);

        print('Image uploaded successfully: $imageUrl');
      } catch (e) {
        print('Error uploading image: $e');
      }
    } else {
      print('No image captured');
    }

    Navigator.pop(context);
  }

  bool password_not_entered = false;
  bool password_no_match = false;
  List<bool> is_visible = <bool>[false, false, false];
  void changeVisibility(int i) {
    setState(() {
      is_visible[i] = !is_visible[i];
    });
  }

  Future<void> saveProfile() async {
    String newName = nameController.text.trim();

    // Update name
    if (newName.isNotEmpty) {
      // Update name in Firestore
      Dataservices dataservices =
          Dataservices(uid: FirebaseAuth.instance.currentUser!.uid);
      setState(() {
        dataservices.updateName(newName);
      });
    }
  }

  final List<String> gender = <String>[
    'Camera',
    'Gallery',
  ];
  final List<IconData> icon = <IconData>[
    Icons.camera_alt_rounded,
    Icons.photo_library_rounded,
  ];
  TextEditingController nameController = TextEditingController();
  TextEditingController olpController = TextEditingController();
  TextEditingController newController = TextEditingController();
  TextEditingController cnfnewController = TextEditingController();
  FocusNode focusNode = FocusNode();
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.4),
            child: Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 75,
                          backgroundImage: FileImage(_image!),
                        )
                      : CircleAvatar(
                          radius: 75,
                          backgroundImage: NetworkImage(
                              'https://i.pinimg.com/564x/e9/51/25/e951250f7f452c8e278d12ac073b9b5b.jpg'),
                        ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                    color: Colors.white,
                                  ),
                                  height: 200,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children:
                                        List.generate(gender.length, (index) {
                                      return GestureDetector(
                                        onTap: () {
                                          if (index == 0)
                                            imageFromCamera();
                                          else
                                            getImage();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: const Border(),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.1),
                                                spreadRadius: 4,
                                                blurRadius: 8,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                            color: Colors.white,
                                          ),
                                          height: 150,
                                          width: 160,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              CircleAvatar(
                                                radius: 38,
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        211, 215, 215, 215),
                                                child: Icon(
                                                  icon[index],
                                                  color: Colors.black,
                                                  size: 30,
                                                ),
                                              ),
                                              Text(
                                                gender[index],
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  // fontWeight:
                                                  //     FontWeight.bold
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                );
                              });
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(),
                            color: Colors.black,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ))
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  focusNode: focusNode,
                  controller: nameController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 15, 20, 5),
                    child: Text(
                      'Change password',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 10),
                child: TextField(
                  controller: olpController,
                  obscureText: !is_visible[0],
                  decoration: InputDecoration(
                      fillColor: Colors.grey[50],
                      filled: true,
                      isDense: true,
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            changeVisibility(0);
                          },
                          child: Icon(is_visible[0]
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      labelText: 'Old password',
                      errorText: password_not_entered
                          ? 'Please enter password'
                          : (password_no_match
                              ? 'Either your email or password is incorrect'
                              : null),
                      floatingLabelStyle: TextStyle(
                        color: (password_not_entered || password_no_match)
                            ? Colors.red
                            : Colors.black,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 10, 20, 10),
                child: TextField(
                  controller: newController,
                  obscureText: !is_visible[1],
                  decoration: InputDecoration(
                      fillColor: Colors.grey[50],
                      filled: true,
                      isDense: true,
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            changeVisibility(1);
                          },
                          child: Icon(is_visible[1]
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      labelText: 'new password',
                      errorText: password_not_entered
                          ? 'Please enter password'
                          : (password_no_match
                              ? 'Either your email or password is incorrect'
                              : null),
                      floatingLabelStyle: TextStyle(
                        color: (password_not_entered || password_no_match)
                            ? Colors.red
                            : Colors.black,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 10, 20, 10),
                child: TextField(
                  controller: cnfnewController,
                  obscureText: !is_visible[2],
                  decoration: InputDecoration(
                      fillColor: Colors.grey[50],
                      filled: true,
                      isDense: true,
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            changeVisibility(2);
                          },
                          child: Icon(is_visible[2]
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      labelText: 'confirm password',
                      errorText: password_not_entered
                          ? 'Please enter password'
                          : (password_no_match
                              ? 'Either your email or password is incorrect'
                              : null),
                      floatingLabelStyle: TextStyle(
                        color: (password_not_entered || password_no_match)
                            ? Colors.red
                            : Colors.black,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () {
                    saveProfile();
                  },
                  child: Text('Save Changes'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
