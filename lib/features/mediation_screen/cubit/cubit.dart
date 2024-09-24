import 'package:arabia/core/utils/dialogs.dart';
import 'package:arabia/features/mediation_screen/cubit/state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/mediation_contract_model.dart';
import '../../../core/remote/service.dart';

class MediationCubit extends Cubit<MediationState> {
  MediationCubit(this.api) : super(MainInitial());

  ServiceApi api;
  int selectedIndexOrder = 0;
  String statusFromOrder = 'pending';
  int pageNo = 1;
  int totalPages = 1;
  onTapChangeCurrentOrder(int index, BuildContext context) {
    selectedIndexOrder = index;
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
  getMediationContract() async {
    emit(GetMediationContractLoadingState());

    final response = await api.mediationContractApi(
      pageNo: pageNo,
      status: statusFromOrder,
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

  void changePage(int newPage) {
    pageNo = newPage;
    getMediationContract();
  }
}
