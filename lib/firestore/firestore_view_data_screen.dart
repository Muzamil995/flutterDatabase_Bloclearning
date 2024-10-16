import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreViewAddScreen extends StatefulWidget {
  const FirestoreViewAddScreen({super.key});

  @override
  State<FirestoreViewAddScreen> createState() => _FirestoreViewAddScreenState();
}

class _FirestoreViewAddScreenState extends State<FirestoreViewAddScreen> {
  final firestore = FirebaseFirestore.instance.collection("user").snapshots();
  TextEditingController updateEmailController = TextEditingController();
  TextEditingController updateUsernameController = TextEditingController();
  CollectionReference ref = FirebaseFirestore.instance.collection("user");
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
          StreamBuilder(
              stream: firestore,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(
                            snapshot.data!.docs[index]['username'].toString()),
                        subtitle: Text(
                            snapshot.data!.docs[index]['email'].toString()),
                        trailing: Container(
                          width: 100,
                          height: 50,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: Text("Delete"),
                                              content: Text(
                                                  "Are you sure you want to Delete!"),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Cancel"),
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      ref.doc(snapshot.data!.docs[index]['id']
                                        .toString()).delete();
                                                    },
                                                    child: Text("Done"))
                                              ],
                                            ));
                                  },
                                  icon: Icon(Icons.delete)),
                              IconButton(
                                  onPressed: () {
                                    String id = snapshot.data!.docs[index]['id']
                                        .toString();
                                    String username = snapshot
                                        .data!.docs[index]['username']
                                        .toString();
                                    String email = snapshot
                                        .data!.docs[index]['email']
                                        .toString();
                                    showingUpdateDialog(id, email, username);
                                  },
                                  icon: Icon(Icons.edit))
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              })
        ],
      ),
    );
  }

  Future<void> showingUpdateDialog(String id, String email, String username) {
    updateEmailController.text = email;
    updateUsernameController.text = username;
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("update username and email"),
              content: Column(children: [
                TextField(
                  controller: updateUsernameController,
                  decoration: InputDecoration(hintText: "Enter username"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: updateEmailController,
                  decoration: InputDecoration(hintText: "Enter email"),
                ),
              ]),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ref.doc(id).update({
                        "username": updateUsernameController.text.toString(),
                        "email": updateEmailController.text.toString()
                      });
                    },
                    child: Text("Done")),
              ],
            ));
  }
}
