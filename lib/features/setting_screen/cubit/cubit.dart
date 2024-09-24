import 'package:arabia/core/remote/service.dart';
import 'package:arabia/core/utils/dialogs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/models/delete_model.dart';
import '../../../core/models/setting_model.dart';
import '../../../core/preferences/preferences.dart';
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
  DeleteAccountModel? deleteAccountModel;
  Future<void> deleteAccount(
      BuildContext context
      ) async {
    emit(GetSettingsLoadingState());
    final result = await api.deleteApi();
    result.fold(
          (failure) {
        emit(GetSettingsErrorState('Error loading data: $failure'));
      },
          (r) {
         deleteAccountModel = r;
         Navigator.pushNamed(context, Routes.initialRoute);
         Preferences.instance.clearShared().then((value) =>
             Navigator.pushNamedAndRemoveUntil(context,
                 Routes.initialRoute, (route) => false));
         successGetBar("delete_account_successfully".tr());
        emit(GetSettingsLoadedState());
      },
    );
  }
}