import 'package:arabia/core/utils/dialogs.dart';
import 'package:arabia/features/mediation_contracts_screen/cubit/state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/mediation_contract_model.dart';
import '../../../core/remote/service.dart';

class MediationContractsCubit extends Cubit<MediationContractsState> {
  MediationContractsCubit(this.api) : super(MainInitial());

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
    getMediationContract();
  }

 MediationContractModel? mediationContractModel;

  // Function to fetch contracts
  getMediationContract() async {
    emit(GetMediationContractLoadingState());

    final response = await api.mediationContractApi(
      pageNo: pageNo,
      status: statusFromOrder, // Use status from the selected tab
    );

    response.fold(
          (l) => emit(GetMediationContractErrorState()),
          (r) {
            mediationContractModel = r;

        if (r.data != null && r.data!.pagination != null && r.data!.pagination!.pages != null) {
          totalPages = r.data!.pagination!.count!;
        } else {
          totalPages = 1;
        }
        emit(GetMediationContractSuccessState());
      },
    );
  }
archiveMediationContract({required String itemId,required BuildContext context}) async {
  emit(ArchiveMediationContractLoadingState());
  final response = await api.mediationContractArchiveApi(itemId:itemId);
  response.fold(
        (l) => emit(ArchiveMediationContractErrorState()),
        (r) {
      getMediationContract();
      Navigator.pop(context);
      successGetBar('archive_Mediation_contract_successfully'.tr());
      emit(ArchiveMediationContractSuccessState());
    },
  );
}

  // Function to change the page
  void changePage(int newPage) {
    pageNo = newPage;
    getMediationContract(); // Fetch the new page data
  }
}
