import 'package:bloc/bloc.dart';
import 'package:database_practice/bloc/todo/todo_events.dart';
import 'package:database_practice/bloc/todo/todo_state.dart';

class TodoBloc extends Bloc<TodoEvents, TodoState> {
  List<String> todoList = [];
  
  TodoBloc() : super(TodoState(task: [])) {  // Initialize state with an empty list
    on<AddTask>(addtask);
    on<RemoveTask>(removetask);
  }

  void addtask(AddTask event, Emitter<TodoState> emit) async {
    todoList.add(event.value);  // No need to cast to String
    emit(state.copyWith(task: List.from(todoList)));  // Emit updated state
  }

  void removetask(RemoveTask event, Emitter<TodoState> emit) async {
    todoList.remove(event.value);  // No need to cast to String
    emit(state.copyWith(task: List.from(todoList)));  // Emit updated state
  }
}
