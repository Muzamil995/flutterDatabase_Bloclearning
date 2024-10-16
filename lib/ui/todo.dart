import 'package:database_practice/bloc/todo/todo_bloc.dart';
import 'package:database_practice/bloc/todo/todo_events.dart';
import 'package:database_practice/bloc/todo/todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
        if (state.task.isEmpty) {
          return Center(
            child: Text("No Data Found"),
          );
        } else {
          return ListView.builder(
              itemCount: state.task.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.task.toString()),
                  trailing: IconButton(
                      onPressed: () {
                        context
                            .read()
                            .add(RemoveTask(value: state.task[index]));
                      },
                      icon: Icon(Icons.delete)),
                );
              });
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<TodoBloc>().add(AddTask(value: "abc"));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
