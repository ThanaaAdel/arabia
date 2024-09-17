

import 'package:arabia/core/models/get_occupations_model.dart';
import 'package:arabia/core/remote/service.dart';
import 'package:arabia/features/insert_professional_employment.screen/cubit/profissional_emploment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/get_country_model.dart';

class InsertProfessionalEmploymentCubit extends Cubit<InsertProfissionalEmplomentState> {
  InsertProfessionalEmploymentCubit(this.api) : super(InsertProfissionalEmplomentInitial());
  ServiceApi api;
  GetOccupationsModel? occupationsData;
  GetCountriesModel?  getCountriesModel;
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
