abstract class ContractHourState {}

class MainInitial extends ContractHourState {}
class GetOccupationsLoadingState extends ContractHourState {}
class GetOccupationsErrorState extends ContractHourState {
  final String error;

  GetOccupationsErrorState(this.error);
}
class GetOccupationsLoadedState extends ContractHourState {}
class GetHourlyPackageLoadedState extends ContractHourState {}
class GetHourlyPackageErrorState extends ContractHourState {
  final String error;

  GetHourlyPackageErrorState(this.error);
}
class GetHourlyPackageLoadingState extends ContractHourState {}
class LoadedGetUserDataWithSession extends ContractHourState {}
class LoadingGetUserDataWithSession  extends ContractHourState {}
class GetPackagesLoadedState extends ContractHourState {}
class GetPackagesErrorState extends ContractHourState {
  final String error;

  GetPackagesErrorState(this.error);
}
class GetPackagesLoadingState extends ContractHourState {}