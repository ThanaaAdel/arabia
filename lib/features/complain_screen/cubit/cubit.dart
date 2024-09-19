import 'dart:convert';
import 'dart:io';

import 'package:arabia/core/models/closed_complain_model.dart';
import 'package:arabia/core/models/reply_from_complain.dart';
import 'package:arabia/core/utils/dialogs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/models/add_complain_model.dart';
import '../../../core/models/opening_complain_model.dart';
import '../../../core/models/replaies_complain_model.dart';
import '../../../core/remote/service.dart';
import 'state.dart';

class ComplaintsCubit extends Cubit<ComplaintsState> {
  ComplaintsCubit(this.api) : super(MainInitial());

  ServiceApi api;
  int selectedIndexOrder = 0; // 0: open, 1: closed
  int openCurrentPage = 1; // رقم الصفحة الحالية للشكاوى المفتوحة
  int openTotalPages = 1; // إجمالي الصفحات للشكاوى المفتوحة
  int closedCurrentPage = 1; // رقم الصفحة الحالية للشكاوى المغلقة
  int closedTotalPages = 1; // إجمالي الصفحات للشكاوى المغلقة
  OpeningComplainModel? openedComplaintsModel;
  ClosedComplainModel? closedComplainModel;

  TextEditingController contactController = TextEditingController();
  TextEditingController contactReplyController = TextEditingController();
  onTapChangeCurrentOrder(int index, BuildContext context) {
    selectedIndexOrder = index;
    emit(ChangeStatusOfSelectedIndexOrder());

    if (selectedIndexOrder == 0) {
      getOpenedComplaints(page: openCurrentPage);
    } else {
      getClosedComplaints(page: closedCurrentPage);
    }
  }
  String? selectedFile;

  Future<void> pickFile() async {
    emit(LoadingUploadImage());
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.any, // Allows picking any file type
      );

      if (result != null && result.files.single.path != null) {
        selectedFile = result.files.single.path; // Save the file path
        emit(LoadedUploadImage());
      } else {
        // User canceled the picker
        emit(ErrorHomeState('No file selected.'));
      }
    } on PlatformException catch (e) {
      print('Error: $e');
      emit(ErrorHomeState('Error picking file: $e'));
    }
  }
  String? selectedImage;
  Future<void> pickLogoImage() async {
    emit(LoadingUploadImage());
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      selectedImage = image.path; // Save the image path
      emit(LoadedUploadImage());
    } on PlatformException catch (e) {
      print('Error: $e');
      emit(ErrorHomeState('Error picking image: $e'));
    }
  }

  Future<void> pickImageAndConvertToBase64() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      // قراءة الملف كبيانات ثنائية
      final bytes = await imageFile.readAsBytes();
      // تحويل البيانات إلى Base64
      final base64Image = base64Encode(bytes);

      print('Base64 Encoded Image: $base64Image');
    } else {
      print('No image selected.');
    }
  }

  Future<void> getOpenedComplaints({int page = 1}) async {
    emit(GetOpeningComplaintsLoadingState());
    final response = await api.getOpeningComplainApi(page: page.toString());
    response.fold(
      (l) => emit(GetOpeningComplaintsErrorState()),
      (r) {
        if (r.data != null &&
            r.data!.replies != null &&
            r.data!.replies!.isNotEmpty) {
          openedComplaintsModel = r;
          emit(GetOpeningComplaintsLoadedState());
        } else {
          emit(GetOpeningComplaintsErrorState());
        }
      },
    );
  }

  ReplaiesComplainModel? replaiesComplainModel;
  getRepliesComplaints({required String complainId}) async {
    emit(GetRepliesComplaintsLoadingState());
    final response = await api.replaiesComplianApi(complainId: complainId);
    response.fold(
      (l) => emit(GetRepliesComplaintsErrorState()),
      (r) {
        replaiesComplainModel = r;
        emit(GetRepliesComplaintsLoadedState());
      },
    );
  }

  AddComplainModel? addComplainModel;


  addNewComplaint(BuildContext context) async {
    emit(AddRepliesComplaintsLoadingState());
    try {
      String? base64Content;
      String? fileName;

      // Check if an image is selected
      if (selectedImage != null) {
        final File imageFile = File(selectedImage!);
        base64Content = base64Encode(imageFile.readAsBytesSync());
        fileName = selectedImage!.split('/').last;
      }
      // Check if a file is selected
      else if (selectedFile != null) {
        final File file = File(selectedFile!);
        base64Content = base64Encode(file.readAsBytesSync());
        fileName = selectedFile!.split('/').last;
      }

      // API call to add complaint
      final response = await api.addComplianApi(
        image: fileName ?? "",
        base64FileContant: base64Content ?? "",
        contact: contactController.text ?? "",
      );

      response.fold(
            (l) => emit(AddRepliesComplaintsErrorState()),
            (r) {
          addComplainModel = r;
          successGetBar('add_reply_success'.tr());
          print("Complaint Content: ${contactController.text}");
          print("File/Image Path: $fileName");
          print("Base64 Content: $base64Content");
          contactController.clear();
          selectedFile = null;
          selectedImage = null;
          Navigator.pop(context);
          getOpenedComplaints(page: openCurrentPage);
          getClosedComplaints(page: closedCurrentPage);
          emit(AddRepliesComplaintsLoadedState());
        },
      );
    } catch (e) {
      print('Error converting file/image to Base64: $e');
      emit(ErrorHomeState('Error converting file/image to Base64: $e'));
    }
  }



  ReplyFromComplainModel? replyFromComplainModel;
  replyFromComplaintData({required BuildContext context,required String complainId}) async {

    emit(ReplyFromComplaintLoadingState());
    try {
      String? base64ImageFromChat;
      String? imageNameFromChat;

      // Check if an image is selected
      if (selectedImage != null) {
        final File imageFile = File(selectedImage!);
        base64ImageFromChat = base64Encode(imageFile.readAsBytesSync());
        imageNameFromChat = selectedImage!.split('/').last;
      }
      // Check if a file is selected
      else if (selectedFile != null) {
        final File file = File(selectedFile!);
        base64ImageFromChat = base64Encode(file.readAsBytesSync());
        imageNameFromChat = selectedFile!.split('/').last;
      }
      final response = await api.replyFromComplianApi(
        complainId: complainId,
        image: imageNameFromChat ?? "",
        base64FileContant: base64ImageFromChat ?? "",
        contact: contactReplyController.text ?? "",
      );

      response.fold(
        (l) => emit(ReplyFromComplaintErrorState()),
        (r) {
          replyFromComplainModel = r;

          getRepliesComplaints(complainId: complainId);
          contactReplyController.clear();
          imageNameFromChat = null;
          selectedImage = null;
          selectedFile = null;
          base64ImageFromChat = null;
          emit(ReplyFromComplaintLoadedState());
        },
      );
    } catch (e) {
      print('Error encoding image to Base64: $e');
      emit(ErrorHomeState('Error encoding image to Base64: $e'));
    }
  }
  getClosedComplaints({int page = 1}) async {
    emit(GetClosedComplaintsLoadingState());
    final response = await api.getClosedComplainApi(page: page.toString());
    response.fold(
      (l) => emit(GetClosedComplaintsErrorState()),
      (r) {
        if (r.data != null &&
            r.data!.replies != null &&
            r.data!.replies!.isNotEmpty) {
          closedComplainModel = r;
          closedTotalPages =
              r.data?.pagination?.count ?? 1; // تحديث إجمالي الصفحات
          emit(GetClosedComplaintsLoadedState());
        } else {
          closedTotalPages = 1;
          emit(GetClosedComplaintsErrorState());
        }
      },
    );
  }
  changeOpenPage(int page) {
    openCurrentPage = page;
    getOpenedComplaints(page: page);
  }

  changeClosedPage(int page) {
    closedCurrentPage = page;
    getClosedComplaints(page: page);
  }
}
