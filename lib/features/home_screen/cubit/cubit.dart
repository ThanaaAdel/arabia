import 'package:arabia/core/models/get_profile_data_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/login_with_client_id_model.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/remote/service.dart';
import 'state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.api) : super(HomeInitial()){
    getProfileData();
    getUserDataWithSession();
  }
  ServiceApi api;
  LoginWithClientIdModel? model;
  GetProfileDataModel? getProfileDataModel;
  Future getUserDataWithSession() async {
    emit(LoadingGetUserDataWithSession());
    Preferences.instance.getUserModelWithSession().then(
          (value) {
        model = value;
        emit(LoadedGetUserDataWithSession());
          },
    );

  }

  void getProfileData() async {
    emit(GetProfileLoadingState());
    final result = await api.getProfileDataApi();
    result.fold(
          (failure) {
        emit(GetProfileErrorState('Error loading data: $failure'));
      },
          (r) {
        getProfileDataModel = r;
        getUserDataWithSession();
        emit(GetProfileLoadedState());
      },
    );
  }
}