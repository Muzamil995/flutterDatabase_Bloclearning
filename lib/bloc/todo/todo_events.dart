import 'package:equatable/equatable.dart';

abstract class TodoEvents extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddTask extends TodoEvents {
  String value;
  AddTask({required this.value});

  @override
  // TODO: implement props
  List<Object?> get props => [value];
}

class RemoveTask extends TodoEvents {
  String value;
  RemoveTask({required this.value});

  @override
  // TODO: implement props
  List<Object?> get props => [value];
}
