import 'package:arabia/core/models/contract_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/remote/service.dart';
import '../../../core/utils/dialogs.dart';
import 'state.dart';

class ContractsCubit extends Cubit<ContractsState> {
  ContractsCubit(this.api) : super(MainInitial());

  ServiceApi api;
  int selectedIndexOrder = 0;
  String status = 'new';

  List<Item>? newContracts = [];
  List<Item>? archivedContracts = [];

  onTapChangeCurrentOrder(int index, BuildContext context) {
    selectedIndexOrder = index;
    status = selectedIndexOrder == 0 ? 'new' : 'archived';
    emit(ChangeStatusOfSelectedIndexOrder());
    getContractData();
  }

  ContractModel? contractModel;
  void getContractData() async {
    emit(GetContractsLoadingState());
    final result = await api.contractApi(
      status: status,
    );
    result.fold(
          (failure) {
        emit(GetContractsErrorState('Error loading data: $failure'));
      },
          (r) {
        contractModel = r;

        if (status == "new") {
          newContracts = contractModel?.data?.items
              ?.where((item) => item.statusClient == 'new')
              .toList();
        } else if (status == "archived") {
          archivedContracts = contractModel?.data?.items
              ?.where((item) => item.statusClient == 'archived')
              .toList();
        }

        emit(GetContractsLoadedState());
      },
    );
  }

  archiveContract({required String fileId, required BuildContext context}) async {
    emit(ArchiveContractLoadingState());
    final response = await api.archiveContractApi(fileId: fileId);
    response.fold(
          (l) => emit(ArchiveContractErrorState()),
          (r) {
        getContractData();
        successGetBar('archive_contract_successfully'.tr());
        emit(ArchiveContractSuccessState());
      },
    );
  }

  List<Item>? getFilteredContracts() {
    return selectedIndexOrder == 0 ? newContracts : archivedContracts;
  }
}
