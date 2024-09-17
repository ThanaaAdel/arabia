import 'package:arabia/core/models/transfer_service_model.dart';
import 'package:arabia/core/utils/dialogs.dart';
import 'package:arabia/features/transfer_service_screen/cubit/state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/remote/service.dart';

class TransferServiceCubit extends Cubit<TransferServiceCubitState> {
  TransferServiceCubit(this.api) : super(MainInitial());

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
    getTransferService();
  }

  TransferServiceModel? transferServiceModel;

  // Function to fetch contracts
  getTransferService() async {
    emit(GetTransferServiceLoadingState());

    final response = await api.transferServiceApi(
      pageNo: pageNo,
      status: statusFromOrder, // Use status from the selected tab
    );

    response.fold(
          (l) => emit(GetTransferServiceErrorState()),
          (r) {
            transferServiceModel = r;

        if (r.data != null && r.data!.pagination != null && r.data!.pagination!.pages != null) {
          totalPages = r.data!.pagination!.count!;
        } else {
          totalPages = 1;
        }
        emit(GetTransferServiceSuccessState());
      },
    );
  }
archiveTransferService({required String itemId,required BuildContext context}) async {
  emit(ArchiveTransferServiceLoadingState());
  final response = await api.transferServiceArchiveApi(itemId:itemId);
  response.fold(
        (l) => emit(ArchiveTransferServiceErrorState()),
        (r) {
      getTransferService();
      Navigator.pop(context);
      successGetBar('archive_Mediation_contract_successfully'.tr());
      emit(ArchiveTransferServiceSuccessState());
    },
  );
}

  // Function to change the page
  void changePage(int newPage) {
    pageNo = newPage;
    getTransferService(); // Fetch the new page data
  }
}
