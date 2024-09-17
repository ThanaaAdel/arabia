abstract class SettingState {}

class SettingInitial extends SettingState {}
class GetSettingsLoadedState extends SettingState {}
class GetSettingsLoadingState extends SettingState {}
class GetSettingsErrorState extends SettingState {
  final String message;
  GetSettingsErrorState(this.message);
}