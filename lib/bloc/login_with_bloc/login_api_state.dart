part of 'login_api_bloc.dart';
enum LoadingStatus {initial,loading,success,failure}
@immutable
sealed class LoginApiState {}

 class LoginState extends LoginApiState{
  String email;
  String password;
  String message;
  LoadingStatus loadingStatus;

  LoginState({
    this.email='',
    this.password='',
    this.message='',
    this.loadingStatus=LoadingStatus.initial
 });


  LoginState copyWith({
    String ? email,
    String ? password,
    String ? message,
    LoadingStatus ? loadingStatus
 }){
return LoginState(
  email: email ?? this.email,
  password: password ?? this.password,
  message: message ?? this.message,
  loadingStatus: loadingStatus ?? this.loadingStatus
);
  }
 }
