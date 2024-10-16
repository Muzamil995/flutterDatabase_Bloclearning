 
import 'package:image_picker/image_picker.dart';

import 'package:equatable/equatable.dart';

class ImagePickerState extends Equatable {

    XFile ? file;
  ImagePickerState({this.file});

  ImagePickerState copyWith({XFile? file}){
    return ImagePickerState(
      file: file ?? this.file
    );
  }


  @override
  // TODO: implement props
  List<Object?> get props =>[file];
}
