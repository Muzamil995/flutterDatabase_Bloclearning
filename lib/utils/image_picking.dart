import 'package:image_picker/image_picker.dart';

class UtilsImagePicking {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> imageFromCamera() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.camera);
    return file;
  }

  Future<XFile?> imageFromGallery() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    return file;
    
  }
}
