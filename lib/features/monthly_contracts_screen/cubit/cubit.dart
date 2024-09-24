import 'package:arabia/core/models/monthly_contract_model.dart';
import 'package:arabia/core/utils/dialogs.dart';
import 'package:arabia/features/monthly_contracts_screen/cubit/state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/remote/service.dart';

class MonthlyContractsCubit extends Cubit<MonthlyContractsState> {
  MonthlyContractsCubit(this.api) : super(MainInitial());

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
    getMonthlyContract();
  }

 MonthlyContractModel? monthlyContractModel;

  getMonthlyContract() async {
    emit(GetMonthlyContractLoadingState());

    final response = await api.monthlyContractApi(
      pageNo: pageNo,
      status: statusFromOrder,
    );

    response.fold(
          (l) => emit(GetMonthlyContractErrorState()),
          (r) {
            monthlyContractModel = r;

        if (r.data != null && r.data!.pagination != null && r.data!.pagination!.pages != null) {
          totalPages = r.data!.pagination!.count!;
        } else {
          totalPages = 1;
        }
        emit(GetMonthlyContractSuccessState());
      },
    );
  }
archiveMonthlyContract({required String itemId,required BuildContext context}) async {
  emit(ArchiveMonthlyContractLoadingState());
  final response = await api.monthlyContractArchiveApi(itemId:itemId);
  response.fold(
        (l) => emit(ArchiveMonthlyContractErrorState()),
        (r) {
      getMonthlyContract();
      Navigator.pop(context);
      successGetBar('archive_Monthly_contract_successfully'.tr());
      emit(ArchiveMonthlyContractSuccessState());
    },
  );
}

  void changePage(int newPage) {
    pageNo = newPage;
    getMonthlyContract();
  }
}
