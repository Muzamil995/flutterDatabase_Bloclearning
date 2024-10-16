import 'package:database_practice/firebase/second_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({super.key});

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController rollNoController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  final firebaseRef = FirebaseDatabase.instance.ref("post");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(hintText: "Enter your Name"),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: rollNoController,
              decoration: InputDecoration(hintText: "Enter your RollNo"),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: subjectController,
              decoration: InputDecoration(hintText: "Enter your Subject"),
            ),
            SizedBox(
              height: 10,
            ),
           
            ElevatedButton(
                onPressed: () {
                   String id = DateTime.now().microsecondsSinceEpoch.toString();
                  firebaseRef
                      .child(id)
                      .set({
                        'id':id,
                    "rollNo": rollNoController.text.toString(),
                    "name": nameController.text.toString(),
                    "subject": subjectController.text.toString()
                  }).then((onValue) {
                 
                        setState(() {
                             ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("posted")));
                        });
                  });
                },
                child: Text("Submit")),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SecondScreen()));
                },
                child: Text("next screen"))
          ],
        ),
      ),
    );
  }
}
