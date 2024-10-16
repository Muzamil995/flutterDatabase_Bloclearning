import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SecondScreen extends StatefulWidget {
  SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final ref = FirebaseDatabase.instance.ref("post");
  TextEditingController searchController = TextEditingController();
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController,
              onChanged: (String value) {
                setState(() {});
              },
              decoration: InputDecoration(hintText: "Search"),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: FirebaseAnimatedList(
                  query: ref,
                  itemBuilder: (context, snapshot, animation, index) {
                    final name = snapshot.child("name").value.toString();
                    final id = snapshot.child("id").value.toString();
                    if (searchController.text.isEmpty) {
                      return ListTile(
                        title: Text(snapshot.child("name").value.toString()),
                        subtitle:
                            Text(snapshot.child("subject").value.toString()),
                        trailing: PopupMenuButton(
                          icon: Icon(Icons.more_vert),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                child: ListTile(
                              onTap: () {
                                showingDialog(name, id);
                              },
                              title: Text("Edit"),
                              leading: Icon(Icons.edit),
                            )),
                            PopupMenuItem(
                                child: ListTile(
                              onTap: () {
                                ref.child(id).remove();
                                Navigator.pop(context);
                              },
                              title: Text("delete"),
                              leading: Icon(Icons.delete),
                            ))
                          ],
                        ),
                      );
                    } else if (name
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase())) {
                      return ListTile(
                        title: Text(snapshot.child("name").value.toString()),
                        subtitle:
                            Text(snapshot.child("subject").value.toString()),
                        trailing: PopupMenuButton(
                          icon: Icon(Icons.more_vert),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                child: ListTile(
                              onTap: () {
                                showingDialog(name, id);
                              },
                              title: Text("Edit"),
                              leading: Icon(Icons.edit),
                            )),
                            PopupMenuItem(
                                child: ListTile(
                              onTap: () {
                                ref.child(id).remove();
                                Navigator.pop(context);
                              },
                              title: Text("delete"),
                              leading: Icon(Icons.delete),
                            ))
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  })),

          // Expanded(
          //     child: StreamBuilder(
          //   stream: ref.onValue,
          //   builder: (contxt, AsyncSnapshot<DatabaseEvent> snapshot) {
          //     if (!snapshot.hasData) {
          //       return CircularProgressIndicator();
          //     } else {
          //       Map<dynamic, dynamic> map =
          //           snapshot.data?.snapshot.value as dynamic;
          //       List<dynamic> list = [];
          //       list.clear;
          //       list = map.values.toList();
          //       return ListView.builder(
          //           itemCount: snapshot.data!.snapshot.children.length,
          //           itemBuilder: (context, index) {
          //             return ListTile(
          //               title: Text(list[index]['name']),
          //               subtitle: Text(list[index]['rollNo']),
          //               //trailing: Text(list[index]['subject']),
          //             );
          //           });
          //     }
          //   },
          // ))
        ],
      ),
    );
  }

  Future<void> showingDialog(String title, String id) async {
    editingController.text = title;
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("update"),
              content: Container(
                child: TextField(
                  controller: editingController,
                  decoration: InputDecoration(hintText: "Edit"),
                ),
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ref
                          .child(id)
                          .update({"name": editingController.text.toString()});
                    },
                    child: Text("update")),
              ],
            ));
  }
}
