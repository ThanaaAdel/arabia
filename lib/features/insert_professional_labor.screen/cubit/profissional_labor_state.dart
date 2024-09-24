
abstract class InsertProfissionalLaborState {}

 class InsertProfissionalLaborInitial extends InsertProfissionalLaborState {}
class GetOccupationsLoadingState extends InsertProfissionalLaborState {}
class GetOccupationsErrorState extends InsertProfissionalLaborState {
 final String error;

 GetOccupationsErrorState(this.error);
}
class GetOccupationsLoadedState extends InsertProfissionalLaborState {}
class GetCountriesLoadingState extends InsertProfissionalLaborState{}
class GetCountriesErrorState extends InsertProfissionalLaborState {
 final String error;

 GetCountriesErrorState(this.error);
}
class GetCountriesLoadedState extends InsertProfissionalLaborState {}
class GetExperiencesLoadedState extends InsertProfissionalLaborState{}
class GetExperiencesErrorState extends InsertProfissionalLaborState {
 final String error;

 GetExperiencesErrorState(this.error);
}
class GetExperiencesLoadingState extends InsertProfissionalLaborState {}


class InsertProfissionalEmploymentLoadingState extends InsertProfissionalLaborState{}
class InsertProfissionalEmploymentErrorState extends InsertProfissionalLaborState {
 final String error;

 InsertProfissionalEmploymentErrorState(this.error);
}
class GetReligionLoadedState extends InsertProfissionalLaborState {}
class GetReligionErrorState extends InsertProfissionalLaborState {
 final String error;

 GetReligionErrorState(this.error);
}
class GetReligionLoadingState extends InsertProfissionalLaborState {}
class InsertProfissionalEmploymentLoadedState extends InsertProfissionalLaborState {}