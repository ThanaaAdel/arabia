
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