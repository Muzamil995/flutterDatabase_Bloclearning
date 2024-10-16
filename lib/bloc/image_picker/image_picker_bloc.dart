import 'package:bloc/bloc.dart';
import './image_picker_event.dart';
import './image_picker_state.dart';
import '../../utils/image_picking.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final UtilsImagePicking _utilsImagePicking;
  ImagePickerBloc(this._utilsImagePicking) : super(ImagePickerState()) {
    on<CameraImage>(cameraImage);
    on<GalleryImage>(galleryImage);
  }

  void cameraImage(CameraImage event, Emitter<ImagePickerState> emit) async {
    final XFile? file = await _utilsImagePicking.imageFromCamera();
    emit(state.copyWith(file: file));
  }

  void galleryImage(GalleryImage event, Emitter<ImagePickerState> emit) async {
    final XFile? file = await _utilsImagePicking.imageFromGallery();
    emit(state.copyWith(file: file));
  }
}
