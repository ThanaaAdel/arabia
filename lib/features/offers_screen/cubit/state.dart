abstract class OffersState {}

class OffersInitial extends OffersState {}

class GetOffersLoadedState extends OffersState {}

class GetOffersErrorState extends OffersState {
  final String error;

  GetOffersErrorState(this.error);
}

class GetOffersLoadingState extends OffersState {}
