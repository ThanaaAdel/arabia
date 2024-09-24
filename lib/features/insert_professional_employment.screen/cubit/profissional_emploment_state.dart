
abstract class InsertProfissionalEmplomentState {}

 class InsertProfissionalEmplomentInitial extends InsertProfissionalEmplomentState {}
class GetOccupationsLoadingState extends InsertProfissionalEmplomentState {}
class GetOccupationsErrorState extends InsertProfissionalEmplomentState {
 final String error;

 GetOccupationsErrorState(this.error);
}
class GetOccupationsLoadedState extends InsertProfissionalEmplomentState {}
class GetCountriesLoadingState extends InsertProfissionalEmplomentState{}
class GetCountriesErrorState extends InsertProfissionalEmplomentState {
 final String error;

 GetCountriesErrorState(this.error);
}
class GetCountriesLoadedState extends InsertProfissionalEmplomentState {}
class GetExperiencesLoadedState extends InsertProfissionalEmplomentState{}
class GetExperiencesErrorState extends InsertProfissionalEmplomentState {
 final String error;

 GetExperiencesErrorState(this.error);
}
class GetExperiencesLoadingState extends InsertProfissionalEmplomentState {}


class InsertProfissionalEmploymentLoadingState extends InsertProfissionalEmplomentState{}
class InsertProfissionalEmploymentErrorState extends InsertProfissionalEmplomentState {
 final String error;

 InsertProfissionalEmploymentErrorState(this.error);
}
class GetReligionLoadedState extends InsertProfissionalEmplomentState {}
class GetReligionErrorState extends InsertProfissionalEmplomentState {
 final String error;

 GetReligionErrorState(this.error);
}
class GetReligionLoadingState extends InsertProfissionalEmplomentState {}
class InsertProfissionalEmploymentLoadedState extends InsertProfissionalEmplomentState {}