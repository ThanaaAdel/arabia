abstract class MediatationState {}

class MediatationInitial extends MediatationState {}
class GetMediatationLoadedState extends MediatationState{}
class GetMediatationErrorState extends MediatationState {
  final String error;

  GetMediatationErrorState(this.error);
}
class GetMediatationLoadingState extends MediatationState {}
class GetExperiencesLoadedState extends MediatationState{}
class GetExperiencesErrorState extends MediatationState {
  final String error;

  GetExperiencesErrorState(this.error);
}
class GetExperiencesLoadingState extends MediatationState {}
class GetReligionsLoadedState extends MediatationState{}
class GetReligionsErrorState extends MediatationState {
  final String error;

  GetReligionsErrorState(this.error);
}
class GetReligionsLoadingState extends MediatationState {}
class GetOccupationsLoadingState extends MediatationState {}
class GetOccupationsErrorState extends MediatationState {
  final String error;

  GetOccupationsErrorState(this.error);
}
class GetOccupationsLoadedState extends MediatationState {}
class GetCountrysLoadingState extends MediatationState {}
class GetCountrysErrorState extends MediatationState {
  final String error;

  GetCountrysErrorState(this.error);
}
class GetCountrysLoadedState extends MediatationState {}