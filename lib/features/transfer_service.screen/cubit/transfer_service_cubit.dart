
import 'package:arabia/core/models/GetTransferServiceTypeModel.dart';
import 'package:arabia/core/models/get_country_model.dart';
import 'package:arabia/core/models/insert_transfare_service_model.dart';
import 'package:arabia/core/models/religions_model.dart';
import 'package:arabia/core/utils/dialogs.dart';
import 'package:arabia/features/transfer_service.screen/cubit/transfer_service_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/get_occupations_model.dart';
import '../../../core/remote/service.dart';

class TransferServiceCubit extends Cubit<TransferServiceState> {
  TransferServiceCubit(this.api) : super(TransferServiceInitial());
  ServiceApi api;
  ReligionsModel? religionsModel;
  String ? selectedReligion;
  String ? selectedCountryId;
  String ? selectedOccupation;
  String? selectedOccupationId;
  String? religionName;
  String? serviceType;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void getReligionsData() async {
    emit(GetReligionsLoadingState());
    final result = await api.getReligionsApi();
    result.fold(
          (failure) {
        emit(GetReligionsErrorState('Error loading data: $failure'));
      },
          (r) {
        religionsModel = r;
        emit(GetReligionsLoadedState());
      },
    );
  }

  GetOccupationsModel?  occupationsModel;
  void getOccupationsData({required String clientId}) async {

    emit(GetOccupationsLoadingState());
    final result = await api.getGetOccupationsApi(clientId: clientId);
    result.fold(
          (failure) {
        emit(GetOccupationsErrorState('Error loading data: $failure'));
      },
          (r) {
        occupationsModel = r;
        emit(GetOccupationsLoadedState());
      },
    );
  }
  GetCountriesModel?  getCountriesModel;
  void getCountryData() async {

    emit(GetCountrysLoadingState());
    final result = await api.getCountryApi();
    result.fold(
          (failure) {
        emit(GetCountrysErrorState('Error loading data: $failure'));
      },
          (r) {
        getCountriesModel = r;
        emit(GetCountrysLoadedState());
      },
    );
  }
  GetTransferServiceTypeModel?  getTransferServiceTypeModel;
  void getTransferServiceTypeData() async {

    emit(GetTransferServiceTypeLoadingState());
    final result = await api.getTransferServiceTypeOptionsApi();
    result.fold(
          (failure) {
        emit(GetTransferServiceTypeErrorState('Error loading data: $failure'));
      },
          (r) {
            getTransferServiceTypeModel = r;
        emit(GetTransferServiceTypeLoadedState());
      },
    );
  }
  InsertTransefareServiceModel? insertTransefareServiceModel;
  void insertTransferServiceRequestData({required BuildContext context}) async {
    emit(InsertTransferServiceLoadingState());
    final result = await api.insertTransfareServiceApi(
        currentWorkerCountryId:selectedCountryId.toString() ,
      currentWorkerOccId: selectedOccupationId.toString(),
      currentWorkerReligion:religionName.toString() ,
      transferType:serviceType.toString(),

    );
    result.fold(
          (failure) {
        emit(InsertTransferServiceErrorState('Error loading data: $failure'));
      },
          (r) {
            insertTransefareServiceModel = r;
        successGetBar("insert_transfare_service_success".tr());
        Navigator.pop(context);
        emit(InsertTransferServiceLoadedState());
      },
    );
  }
}
