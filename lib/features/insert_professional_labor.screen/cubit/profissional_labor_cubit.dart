

import 'package:arabia/core/models/get_occupations_model.dart';
import 'package:arabia/core/models/religions_model.dart';
import 'package:arabia/core/remote/service.dart';
import 'package:arabia/core/utils/dialogs.dart';
import 'package:arabia/features/insert_professional_labor.screen/cubit/profissional_labor_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/experance_model.dart';
import '../../../core/models/get_country_model.dart';
import '../../../core/models/insert_profissional_employment_model.dart';

class InsertProfessionalLaborCubit extends Cubit<InsertProfissionalLaborState> {
  InsertProfessionalLaborCubit(this.api) : super(InsertProfissionalLaborInitial());
  ServiceApi api;
  GetOccupationsModel? occupationsData;
  GetCountriesModel?  getCountriesModel;
  TextEditingController visaNumberController = TextEditingController();
  ExperanceModel? experanceModel;
  String? experanceName;
  String? religionName;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void getCountryData() async {

    emit(GetCountriesLoadingState());
    final result = await api.getCountryApi();
    result.fold(
          (failure) {
        emit(GetCountriesErrorState('Error loading data: $failure'));
      },
          (r) {
        getCountriesModel = r;
        emit(GetCountriesLoadedState());
      },
    );
  }
  ReligionsModel? religionsModel;
  void getReligionData() async {
    emit(GetReligionLoadingState());
    final result = await api.getReligionsApi();
    result.fold(
          (failure) {
        emit(GetReligionErrorState('Error loading data: $failure'));
      },
          (r) {
        religionsModel = r;
        emit(GetReligionLoadedState());
      },
    );
  }
  void getExperiencesData() async {
    emit(GetExperiencesLoadingState());
    final result = await api.getExperianceApi();
    result.fold(
          (failure) {
        emit(GetExperiencesErrorState('Error loading data: $failure'));
      },
          (r) {
        experanceModel = r;
        emit(GetExperiencesLoadedState());
      },
    );
  }
  InsertProfissionalEmployementModel? insertProfissionalEmployementModel;
  void insertProfissionalEmploymentData({
    required BuildContext context,
    required String countryId,
    required String occId,
    required String visaNo,

  }) async {
    emit(InsertProfissionalEmploymentLoadingState());
    final result = await api.insertProfissionalEmploymentApi(
      religion: religionName.toString(),
      countryId: countryId,
      occId: occId,
      experince: experanceName.toString(),
      visaNo: visaNo,
    );

    result.fold(
          (failure) {
        emit(InsertProfissionalEmploymentErrorState('Error loading data: $failure'));
      },
          (r) {
        insertProfissionalEmployementModel = r;
        Navigator.pop(context);
        successGetBar("insert_professional_employment_success".tr());
        emit(InsertProfissionalEmploymentLoadedState());
      },
    );
  }

  void getOccupationsData({required String clientId}) async {

    emit(GetOccupationsLoadingState());
    final result = await api.getGetOccupationsApi(clientId: clientId);
    result.fold(
          (failure) {
        emit(GetOccupationsErrorState('Error loading data: $failure'));
      },
          (r) {
            occupationsData = r;
        emit(GetOccupationsLoadedState());
      },
    );
  }
}
