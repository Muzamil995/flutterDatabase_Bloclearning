import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FirestoreImageAdding extends StatefulWidget {
  const FirestoreImageAdding({super.key});

  @override
  State<FirestoreImageAdding> createState() => _FirestoreImageAddingState();
}

class _FirestoreImageAddingState extends State<FirestoreImageAdding> {
  File? image;

  ImagePicker picker = ImagePicker();
  FirebaseStorage firebasestorage = FirebaseStorage.instance;

  Future pickImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
      Reference ref = firebasestorage
          .ref()
          .child("images/${DateTime.now().millisecondsSinceEpoch.toString()}");
      await ref.putFile(File(pickedImage.path));
      setState(() {
        
      });
    } else {
      print("No image selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: Container(
              height: 200,
              width: 200,
              child:
                  image != null ? Image.file(File(image!.path)) : Icon(Icons.person),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                pickImage();
              },
              child: Text("Select Image"))
        ],
      ),
    );
  }
}
