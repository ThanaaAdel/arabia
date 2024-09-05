import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/remote/service.dart';
import 'state.dart';
import 'package:image_picker/image_picker.dart';

class NewComplaintsCubit extends Cubit<NewComplaintsState> {
  NewComplaintsCubit(this.api) : super(NewComplaintsInitial());
  ServiceApi api;
  String? selectedImage;
  Future<void> pickLogoImage() async {
    emit(LoadingUploadImage());
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      selectedImage = image.path;
      emit(LoadedUploadImage());
    } on PlatformException catch (e) {
      print('error $e');
      emit(ErrorHomeState('Error picking image: $e'));
    }
  }
}