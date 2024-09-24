import 'package:arabia/core/models/professional_employment_model.dart';
import 'package:arabia/core/utils/dialogs.dart';
import 'package:arabia/features/professional_labor_screen/cubit/state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/remote/service.dart';

class ProfessionalLaborCubit extends Cubit<ProfessionalLaborState> {
  ProfessionalLaborCubit(this.api) : super(MainInitial());

  ServiceApi api;
  int selectedIndexOrder = 0; // 0 : pending, 1 : in_progress, 2 : archived
  String statusFromOrder = 'pending'; // default status
  int pageNo = 1;
  int totalPages = 1;

  // Function to handle tab change
  onTapChangeCurrentOrder(int index, BuildContext context) {
    selectedIndexOrder = index;

    // Set status based on the selected index
    switch (selectedIndexOrder) {
      case 0:
        statusFromOrder = 'pending';
        break;
      case 1:
        statusFromOrder = 'in_progress';
        break;
      case 2:
        statusFromOrder = 'archived';
        break;
      default:
        statusFromOrder = 'pending';
    }

    emit(ChangeStatusOfSelectedIndexOrder());
    getProfessionalEmployment();
  }

 ProfessionalEmploymentModel? professionalEmploymentModel;

  // Function to fetch contracts
  getProfessionalEmployment() async {
    emit(GetProfessionalEmploymentLoadingState());

    final response = await api.professionalEmploymentApi(
      pageNo: pageNo,
      status: statusFromOrder, // Use status from the selected tab
    );

    response.fold(
          (l) => emit(GetProfessionalEmploymentErrorState()),
          (r) {
            professionalEmploymentModel = r;

        if (r.data != null && r.data!.pagination != null && r.data!.pagination!.pages != null) {
          totalPages = r.data!.pagination!.count!;
        } else {
          totalPages = 1;
        }
        emit(GetProfessionalEmploymentSuccessState());
      },
    );
  }
archiveProfessionalEmployment({required String itemId,required BuildContext context}) async {
  emit(ArchiveProfessionalEmploymentLoadingState());
  final response = await api.professionalEmploymentArchiveApi(itemId:itemId);
  response.fold(
        (l) => emit(ArchiveProfessionalEmploymentErrorState()),
        (r) {
      getProfessionalEmployment();
      Navigator.pop(context);
      successGetBar('archive_professional_employment_successfully'.tr());
      emit(ArchiveProfessionalEmploymentSuccessState());
    },
  );
}

  // Function to change the page
  void changePage(int newPage) {
    pageNo = newPage;
    getProfessionalEmployment(); // Fetch the new page data
  }
}
