abstract class InsertContractHourState {}

class MainInitial extends InsertContractHourState {}
class GetOccupationsLoadingState extends InsertContractHourState {}
class GetOccupationsErrorState extends InsertContractHourState {
  final String error;

  GetOccupationsErrorState(this.error);
}
class GetOccupationsLoadedState extends InsertContractHourState {}
class GetHourlyPackageLoadedState extends InsertContractHourState {}
class GetHourlyPackageErrorState extends InsertContractHourState {
  final String error;

  GetHourlyPackageErrorState(this.error);
}
class GetHourlyPackageLoadingState extends InsertContractHourState {}
class LoadedGetUserDataWithSession extends InsertContractHourState {}
class LoadingGetUserDataWithSession  extends InsertContractHourState {}
class GetPackagesLoadedState extends InsertContractHourState {}
class GetPackagesErrorState extends InsertContractHourState {
  final String error;

  GetPackagesErrorState(this.error);
}
class GetPackagesLoadingState extends InsertContractHourState {}
class InsertHourlyDataLoadedState extends InsertContractHourState {}
class InsertHourlyDataErrorState extends InsertContractHourState {
  final String error;

  InsertHourlyDataErrorState(this.error);
}
class InsertHourlyDataLoadingState extends InsertContractHourState {}