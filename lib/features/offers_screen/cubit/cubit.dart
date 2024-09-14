import 'package:arabia/core/models/offers_model.dart';
import 'package:arabia/features/offers_screen/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/remote/service.dart';

class OffersCubit extends Cubit<OffersState> {
  OffersCubit(this.api) : super(OffersInitial());
  ServiceApi api;
  OffersModel? offersModel;
  Future<void> getOffersData() async {
    emit(GetOffersLoadingState());
    final result = await api.getOffersApi();
    result.fold(
          (failure) {
        emit(GetOffersErrorState('Error loading data: $failure'));
      },
          (r) {
            offersModel = r;
        emit(GetOffersLoadedState());
      },
    );
  }

}
