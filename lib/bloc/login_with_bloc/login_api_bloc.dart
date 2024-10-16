import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart'as http;

part 'login_api_event.dart';
part 'login_api_state.dart';

class LoginApiBloc extends Bloc<LoginApiEvent, LoginState> {
  LoginApiBloc() : super(LoginState()) {

    on<EmailChanged>(emailChanged) ;
    on<PasswordChanged>(passwordChanged) ;
    on<LoginWithApi>(loginWithApi) ;


  }

  void emailChanged(EmailChanged event, Emitter<LoginState> emit){
    emit(
        state.copyWith(
      email: event.email
    ));

  }
  void passwordChanged(PasswordChanged event , Emitter<LoginState> emit){
emit (state.copyWith(
  password: event.password
)) ;

  }

  void loginWithApi(LoginWithApi event,Emitter<LoginState> emit) async{
    emit(state.copyWith(
      loadingStatus: LoadingStatus.loading
    ));
    Map data = {"email":state.email,"password":state.password};
    try{
 final response= await http.post(Uri.parse("https://reqres.in/api/login")

     ,body: data);
 if(response.statusCode==200){
emit(state.copyWith(
  message: "Login Successfully",
  loadingStatus: LoadingStatus.success
));

 }
 else{
   emit(state.copyWith(
     message: "some error is occuring",
     loadingStatus: LoadingStatus.failure
   ));
 }
    }
    catch(e) {
      emit(state.copyWith(message: e.toString()));

    }
    }

  }

 
