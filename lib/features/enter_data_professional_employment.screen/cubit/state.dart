abstract class EnterDataProfissionalEmployementState {}

class MainInitial extends EnterDataProfissionalEmployementState {}
class GetExperiencesLoadedState extends EnterDataProfissionalEmployementState{}
class GetExperiencesErrorState extends EnterDataProfissionalEmployementState {
  final String error;

  GetExperiencesErrorState(this.error);
}
class GetExperiencesLoadingState extends EnterDataProfissionalEmployementState {}
class GetCountriesLoadingState extends EnterDataProfissionalEmployementState{}
class GetCountriesErrorState extends EnterDataProfissionalEmployementState {
  final String error;

  GetCountriesErrorState(this.error);
}
class GetCountriesLoadedState extends EnterDataProfissionalEmployementState {}

class InsertProfissionalEmploymentLoadingState extends EnterDataProfissionalEmployementState{}
class InsertProfissionalEmploymentErrorState extends EnterDataProfissionalEmployementState {
  final String error;

  InsertProfissionalEmploymentErrorState(this.error);
}
class GetReligionLoadedState extends EnterDataProfissionalEmployementState {}
class GetReligionErrorState extends EnterDataProfissionalEmployementState {
  final String error;

  GetReligionErrorState(this.error);
}
class GetReligionLoadingState extends EnterDataProfissionalEmployementState {}
class InsertProfissionalEmploymentLoadedState extends EnterDataProfissionalEmployementState {}