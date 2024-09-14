

import 'package:arabia/core/models/insert_profissional_employment_model.dart';
import 'package:arabia/core/utils/dialogs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/experance_model.dart';
import '../../../core/models/get_country_model.dart';
import '../../../core/remote/service.dart';
import 'state.dart';

class EnterDataProfissionalEmployementCubit extends Cubit<EnterDataProfissionalEmployementState> {
  EnterDataProfissionalEmployementCubit(this.api) : super(MainInitial());

  ServiceApi api;
  TextEditingController visaNumberController = TextEditingController();
  ExperanceModel? experanceModel;
  GetCountriesModel?  getCountriesModel;
  String? experanceName;
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



}
