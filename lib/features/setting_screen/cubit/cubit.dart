import 'package:arabia/core/remote/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/setting_model.dart';
import 'state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit(this.api) : super(SettingInitial());
ServiceApi api;
  SettingModel? settingModel;
  Future<void> getSettingsData() async {
    emit(GetSettingsLoadingState());
    final result = await api.getSettingApi();
    result.fold(
          (failure) {
        emit(GetSettingsErrorState('Error loading data: $failure'));
      },
          (r) {
        settingModel = r;
        emit(GetSettingsLoadedState());
      },
    );
  }
}