part of 'login_api_bloc.dart';

@immutable
sealed class LoginApiEvent {}

class EmailChanged extends LoginApiEvent{
  final String email;
  EmailChanged({required this.email});
}

class PasswordChanged extends LoginApiEvent{
  final String password;
  PasswordChanged({required this.password});
}


class LoginWithApi extends LoginApiEvent{}