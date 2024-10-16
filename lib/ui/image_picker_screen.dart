import 'dart:io';

import 'package:database_practice/bloc/image_picker/image_picker_bloc.dart';
import 'package:database_practice/bloc/image_picker/image_picker_event.dart';
import 'package:database_practice/bloc/image_picker/image_picker_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
           
          children: [
            Text("Image Picker With Bloc"),
            BlocBuilder<ImagePickerBloc, ImagePickerState>(
              builder: (context, state) {
                if (state.file == null) {
                  return InkWell(
                    onTap: () {
                      context.read<ImagePickerBloc>().add(CameraImage());
                    },
                    child: CircleAvatar(
                    //     backgroundImage: AssetImage(
                    //   File(state.file!.path).toString(),
                    // )
                   child: Icon(Icons.camera),
        
                    ),
                  );
                }
                else{
                 return Image.file(File(state.file!.path.toString()));
                }
                
              },
            )
          ],
        ),
      ),
    );
  }
}
