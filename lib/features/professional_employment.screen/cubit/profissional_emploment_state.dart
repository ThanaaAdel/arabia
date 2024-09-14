
abstract class ProfissionalEmplomentState {}

 class ProfissionalEmplomentInitial extends ProfissionalEmplomentState {}
class GetOccupationsLoadingState extends ProfissionalEmplomentState {}
class GetOccupationsErrorState extends ProfissionalEmplomentState {
 final String error;

 GetOccupationsErrorState(this.error);
}
class GetOccupationsLoadedState extends ProfissionalEmplomentState {}
class GetCountriesLoadingState extends ProfissionalEmplomentState{}
class GetCountriesErrorState extends ProfissionalEmplomentState {
 final String error;

 GetCountriesErrorState(this.error);
}
class GetCountriesLoadedState extends ProfissionalEmplomentState {}