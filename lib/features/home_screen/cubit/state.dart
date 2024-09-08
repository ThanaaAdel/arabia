abstract class HomeState {}

class HomeInitial extends HomeState {}
class LoadedGetUserDataWithSession extends HomeState{}
class LoadingGetUserDataWithSession extends HomeState{}
class GetProfileLoadedState extends HomeState{}
class GetProfileErrorState extends HomeState {
  final String error;

  GetProfileErrorState(this.error);
}
class GetProfileLoadingState extends HomeState {}