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
  int selectedIndexOrder = 0; // 0 : new
  String status = 'new'; // تحديد الحالة افتراضيًا كـ "new"

  // قوائم لتخزين العقود بناءً على الحالة
  List<Item>? newContracts = [];
  List<Item>? archivedContracts = [];

  // عند تغيير ترتيب العرض بناءً على حالة الفلتر
  onTapChangeCurrentOrder(int index, BuildContext context) {
    selectedIndexOrder = index;
    // تحديث الحالة بناءً على الفلتر المختار
    status = selectedIndexOrder == 0 ? 'new' : 'archived';

    emit(ChangeStatusOfSelectedIndexOrder());
    getContractData(); // استدعاء الدالة بدون تمرير status
  }

  ContractModel? contractModel;

  // دالة لجلب البيانات من الـ API بناءً على الحالة المخزنة
  void getContractData() async {
    emit(GetContractsLoadingState());
    final result = await api.contractApi(
      status: status, // استخدام الحالة المخزنة داخليًا
    );
    result.fold(
          (failure) {
        emit(GetContractsErrorState('Error loading data: $failure'));
      },
          (r) {
        contractModel = r;

        // تحديث القوائم بناءً على الحالة
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

  // دالة لأرشفة العقد
  archiveContract({required String fileId, required BuildContext context}) async {
    emit(ArchiveContractLoadingState());
    final response = await api.archiveContractApi(fileId: fileId);
    response.fold(
          (l) => emit(ArchiveContractErrorState()),
          (r) {
        getContractData(); // بعد الأرشفة، أعد تحميل العقود بناءً على الحالة الحالية
        successGetBar('archive_contract_successfully'.tr());
        emit(ArchiveContractSuccessState());
      },
    );
  }

  // دالة لإرجاع العقود المفلترة بناءً على الفلتر المختار (جديد أو مؤرشف)
  List<Item>? getFilteredContracts() {
    return selectedIndexOrder == 0 ? newContracts : archivedContracts;
  }
}
