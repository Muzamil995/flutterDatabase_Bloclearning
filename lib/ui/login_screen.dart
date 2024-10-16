import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_with_bloc/login_api_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginApiBloc loginApiBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginApiBloc = LoginApiBloc();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login", style: TextStyle(color: Colors.orange),),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => loginApiBloc,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              BlocBuilder<LoginApiBloc, LoginState>(
                buildWhen: (previous, current) =>
                previous.email != current.email,
                builder: (context, state) {
                  return TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: "Enter Email",
                        border: OutlineInputBorder()
                    ),
                    onChanged: (value) {
                      context.read<LoginApiBloc>().add(
                          EmailChanged(email: value));
                    },
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              BlocBuilder<LoginApiBloc, LoginState>(
                buildWhen: (previous, current) =>
                previous.password != current.password,
                builder: (context, state) {
                  return TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        hintText: "Enter Password",
                        border: OutlineInputBorder()
                    ),
                    onChanged: (value) {
                      context.read<LoginApiBloc>().add(
                          PasswordChanged(password: value));
                    },
                  );
                },
              ),

              SizedBox(
                height: 30,
              ),

              BlocListener<LoginApiBloc, LoginState>(
                listener: (context, state) {
                  if(state.loadingStatus==LoadingStatus.loading){
                    ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(SnackBar(content: Text("Submitting data")));
                  }

                  else if(state.loadingStatus == LoadingStatus.failure){
                    ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(SnackBar(content: Text(state.message.toString())));
                  }
                  else if(state.loadingStatus==LoadingStatus.success){
                    ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(SnackBar(content: Text(state.message.toString())));
                  }
                },
                child: BlocBuilder<LoginApiBloc, LoginState>(
                  builder: (context, state) {
                    return ElevatedButton(onPressed: () {
                      context.read<LoginApiBloc>().add(LoginWithApi());
                    }, child: Text("Login"));
                  },
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
