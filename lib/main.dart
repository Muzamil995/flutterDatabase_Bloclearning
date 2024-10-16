import 'package:database_practice/bloc/counter/counter_bloc.dart';
import 'package:database_practice/bloc/post/bloc/post_bloc.dart';
import 'package:database_practice/bloc/switch/switch_bloc.dart';
import 'package:database_practice/bloc/todo/todo_bloc.dart';
  import 'package:database_practice/firebase_options.dart';
import 'package:database_practice/ui/login_screen.dart';
import 'package:database_practice/ui/post_screen.dart';
 

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './bloc/image_picker/image_picker_bloc.dart';
import './utils/image_picking.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

//   Platform  Firebase App Id
// web       1:258205121309:web:0db3310c474003b16f3ff4
// android   1:258205121309:android:5297688b2ce36d146f3ff4

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CounterBloc()),
        BlocProvider(create: (context) => SwitchBloc()),
        BlocProvider(create: (context) => ImagePickerBloc(UtilsImagePicking())),
        BlocProvider(create: (context) => TodoBloc()),
         BlocProvider(create: (context) => PostBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Block',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(
          brightness: Brightness.dark
        ),
        home: LoginScreen(),
      ),
    );
  }
}
