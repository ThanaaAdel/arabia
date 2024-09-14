import 'package:arabia/core/models/contract_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/remote/service.dart';
import 'state.dart';

class ContractsCubit extends Cubit<ContractsState> {
  ContractsCubit(this.api) : super(MainInitial());

  ServiceApi api;
  int selectedIndexOrder = 0; // 0 : new
  String statusFromOrder = 'new';

  // Lists to hold filtered contracts
  List<Item>? newContracts = [];
  List<Item>? otherContracts = [];

  onTapChangeCurrentOrder(int index, BuildContext context) {
    selectedIndexOrder = index;
    emit(ChangeStatusOfSelectedIndexOrder());
    getContractData();
  }

  ContractModel? contractModel;

  void getContractData() async {
    emit(GetContractsLoadingState());
    final result = await api.contractApi();
    result.fold(
          (failure) {
        emit(GetContractsErrorState('Error loading data: $failure'));
      },
          (r) {
        contractModel = r;

        // Filter the contracts based on their status
        newContracts = contractModel?.data?.items
            ?.where((item) => item.statusClient == 'new')
            .toList();
        otherContracts = contractModel?.data?.items
            ?.where((item) => item.statusClient != 'new')
            .toList();

        emit(GetContractsLoadedState());
      },
    );
  }

  // Function to change the status of a contract and move it between lists
  void archiveContract(Item contract) {
    if (contract.statusClient == 'new') {
      contract.statusClient = 'archived'; // Update the status to archived
      newContracts?.remove(contract); // Remove from new contracts
      otherContracts?.add(contract); // Add to archived contracts
    }
    emit(GetContractsLoadedState());
  }

  // Function to get filtered contracts based on selected index
  List<Item>? getFilteredContracts() {
    return selectedIndexOrder == 0 ? newContracts : otherContracts;
  }
}
