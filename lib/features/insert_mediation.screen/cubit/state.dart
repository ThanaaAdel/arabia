abstract class InsertMediationState {}

class MediatationInitial extends InsertMediationState {}
class GetMediatationLoadedState extends InsertMediationState{}
class GetMediatationErrorState extends InsertMediationState {
  final String error;

  GetMediatationErrorState(this.error);
}
class GetMediatationLoadingState extends InsertMediationState {}
class GetExperiencesLoadedState extends InsertMediationState{}
class GetExperiencesErrorState extends InsertMediationState {
  final String error;

  GetExperiencesErrorState(this.error);
}
class GetExperiencesLoadingState extends InsertMediationState {}
class GetReligionsLoadedState extends InsertMediationState{}
class GetReligionsErrorState extends InsertMediationState {
  final String error;

  GetReligionsErrorState(this.error);
}
class GetReligionsLoadingState extends InsertMediationState {}
class GetOccupationsLoadingState extends InsertMediationState {}
class GetOccupationsErrorState extends InsertMediationState {
  final String error;

  GetOccupationsErrorState(this.error);
}
class GetOccupationsLoadedState extends InsertMediationState {}
class GetCountrysLoadingState extends InsertMediationState {}
class GetCountrysErrorState extends InsertMediationState {
  final String error;

  GetCountrysErrorState(this.error);
}
class GetCountrysLoadedState extends InsertMediationState {}