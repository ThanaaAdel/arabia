import 'package:arabia/core/utils/dialogs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/hourly_contract_model.dart';
import '../../../core/remote/service.dart';
import 'state.dart';

class HourlyContractsCubit extends Cubit<HourlyContractsState> {
  HourlyContractsCubit(this.api) : super(MainInitial());

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
    getHourlyContract();
  }

  HourlyContractModel? hourlyContractModel;

  // Function to fetch contracts
  getHourlyContract() async {
    emit(GetHourlyContractLoadingState());

    final response = await api.hourlyContractApi(
      pageNo: pageNo,
      status: statusFromOrder, // Use status from the selected tab
    );

    response.fold(
          (l) => emit(GetHourlyContractErrorState()),
          (r) {
        hourlyContractModel = r;

        if (r.data != null && r.data!.pagination != null && r.data!.pagination!.pages != null) {
          totalPages = r.data!.pagination!.pages!.length;
        } else {
          totalPages = 1;
        }
        emit(GetHourlyContractSuccessState());
      },
    );
  }
archiveHourlyContract({required String itemId,required BuildContext context}) async {
  emit(ArchiveHourlyContractLoadingState());
  final response = await api.hourlyContractArchiveApi(itemId:itemId);
  response.fold(
        (l) => emit(ArchiveHourlyContractErrorState()),
        (r) {
      getHourlyContract();
      Navigator.pop(context);
      successGetBar('archive_hourly_contract_successfully'.tr());
      emit(ArchiveHourlyContractSuccessState());
    },
  );
}

  // Function to change the page
  void changePage(int newPage) {
    pageNo = newPage;
    getHourlyContract(); // Fetch the new page data
  }
}
