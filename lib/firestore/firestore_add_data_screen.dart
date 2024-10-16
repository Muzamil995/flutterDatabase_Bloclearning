import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:database_practice/firestore/firestore_image_adding.dart';
import 'package:database_practice/firestore/firestore_view_data_screen.dart';
import 'package:flutter/material.dart';

class FirestoreAddDataScreen extends StatefulWidget {
  const FirestoreAddDataScreen({super.key});

  @override
  State<FirestoreAddDataScreen> createState() => _FirestoreAddDataScreenState();
}

class _FirestoreAddDataScreenState extends State<FirestoreAddDataScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection("user");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Firebase",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "FireStore",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                TextField(
                  cursorColor: Colors.orange,
                  controller: nameController,
                  decoration: InputDecoration(
                      hintText: "Enter username",
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange)),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.orange,
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  cursorColor: Colors.orange,
                  controller: emailController,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange)),
                      hintText: "Enter email",
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.orange,
                      )),
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: () {
                      String id =
                          DateTime.now().microsecondsSinceEpoch.toString();
                      firestore.doc(id).set({
                        "id": id,
                        "username": nameController.text.toString(),
                        "email": emailController.text.toString()
                      }).then((value) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("Submit")));
                      }).onError((e, s) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())));
                      });
                    },
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.orange)),
                    child: Text(
                      "Submit Data",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 75, 72, 72),
                          fontSize: 20),
                    )),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.orange)),
                  child: Text(
                    " View Data",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 75, 72, 72),
                        fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FirestoreViewAddScreen()));
                  },
                ),
                SizedBox(
                  height: 10,
                ),  ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.orange)),
                  child: Text(
                    " Image Screen",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 75, 72, 72),
                        fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FirestoreImageAdding()));
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
