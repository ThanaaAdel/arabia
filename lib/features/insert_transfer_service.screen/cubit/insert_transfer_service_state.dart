abstract class InsertTransferServiceState {}

class InsertTransferServiceInitial extends InsertTransferServiceState {}
class InsertTransferServiceLoadedState extends InsertTransferServiceState{}
class InsertTransferServiceErrorState extends InsertTransferServiceState {
  final String error;

  InsertTransferServiceErrorState(this.error);
}
class InsertTransferServiceLoadingState extends InsertTransferServiceState {}
class GetExperiencesLoadedState extends InsertTransferServiceState{}
class GetExperiencesErrorState extends InsertTransferServiceState {
  final String error;

  GetExperiencesErrorState(this.error);
}
class GetExperiencesLoadingState extends InsertTransferServiceState {}
class GetReligionsLoadedState extends InsertTransferServiceState{}
class GetReligionsErrorState extends InsertTransferServiceState {
  final String error;

  GetReligionsErrorState(this.error);
}
class GetReligionsLoadingState extends InsertTransferServiceState {}
class GetOccupationsLoadingState extends InsertTransferServiceState {}
class GetOccupationsErrorState extends InsertTransferServiceState {
  final String error;

  GetOccupationsErrorState(this.error);
}
class GetOccupationsLoadedState extends InsertTransferServiceState {}
class GetCountrysLoadingState extends InsertTransferServiceState {}
class GetCountrysErrorState extends InsertTransferServiceState {
  final String error;

  GetCountrysErrorState(this.error);
}
class GetCountrysLoadedState extends InsertTransferServiceState {}
class GetTransferServiceTypeLoadingState extends InsertTransferServiceState {}
class GetTransferServiceTypeErrorState extends InsertTransferServiceState {
  final String error;

  GetTransferServiceTypeErrorState(this.error);
}
class GetTransferServiceTypeLoadedState extends InsertTransferServiceState {}