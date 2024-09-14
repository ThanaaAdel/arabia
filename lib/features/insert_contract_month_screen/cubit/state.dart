abstract class InsertContractMonthState {}

class MainInitial extends InsertContractMonthState {}
class GetOccupationsLoadingState extends InsertContractMonthState {}
class GetOccupationsErrorState extends InsertContractMonthState {
  final String error;

  GetOccupationsErrorState(this.error);
}
class GetOccupationsLoadedState extends InsertContractMonthState {}
class GetMonthlyPackageLoadedState extends InsertContractMonthState {}
class GetMonthlyPackageErrorState extends InsertContractMonthState {
  final String error;

  GetMonthlyPackageErrorState(this.error);
}
class GetMonthlyPackageLoadingState extends InsertContractMonthState {}
class LoadedGetUserDataWithSession extends InsertContractMonthState {}
class LoadingGetUserDataWithSession  extends InsertContractMonthState {}
class GetPackagesLoadedState extends InsertContractMonthState {}
class GetPackagesErrorState extends InsertContractMonthState {
  final String error;

  GetPackagesErrorState(this.error);
}
class GetPackagesLoadingState extends InsertContractMonthState {}
class InsertHourlyDataLoadedState extends InsertContractMonthState {}
class InsertHourlyDataErrorState extends InsertContractMonthState {
  final String error;

  InsertHourlyDataErrorState(this.error);
}
class InsertHourlyDataLoadingState extends InsertContractMonthState {}