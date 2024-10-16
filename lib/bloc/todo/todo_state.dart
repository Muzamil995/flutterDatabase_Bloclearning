import 'package:equatable/equatable.dart';

class TodoState extends Equatable {
  final List<String> task;  // Task list should be final for immutability

  TodoState({required this.task});

  TodoState copyWith({List<String>? task}) {
    return TodoState(
      task: task ?? this.task,
    );
  }

  @override
  List<Object?> get props => [task];
}
