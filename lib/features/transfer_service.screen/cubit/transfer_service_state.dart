abstract class TransferServiceState {}

class TransferServiceInitial extends TransferServiceState {}
class InsertTransferServiceLoadedState extends TransferServiceState{}
class InsertTransferServiceErrorState extends TransferServiceState {
  final String error;

  InsertTransferServiceErrorState(this.error);
}
class InsertTransferServiceLoadingState extends TransferServiceState {}
class GetExperiencesLoadedState extends TransferServiceState{}
class GetExperiencesErrorState extends TransferServiceState {
  final String error;

  GetExperiencesErrorState(this.error);
}
class GetExperiencesLoadingState extends TransferServiceState {}
class GetReligionsLoadedState extends TransferServiceState{}
class GetReligionsErrorState extends TransferServiceState {
  final String error;

  GetReligionsErrorState(this.error);
}
class GetReligionsLoadingState extends TransferServiceState {}
class GetOccupationsLoadingState extends TransferServiceState {}
class GetOccupationsErrorState extends TransferServiceState {
  final String error;

  GetOccupationsErrorState(this.error);
}
class GetOccupationsLoadedState extends TransferServiceState {}
class GetCountrysLoadingState extends TransferServiceState {}
class GetCountrysErrorState extends TransferServiceState {
  final String error;

  GetCountrysErrorState(this.error);
}
class GetCountrysLoadedState extends TransferServiceState {}
class GetTransferServiceTypeLoadingState extends TransferServiceState {}
class GetTransferServiceTypeErrorState extends TransferServiceState {
  final String error;

  GetTransferServiceTypeErrorState(this.error);
}
class GetTransferServiceTypeLoadedState extends TransferServiceState {}