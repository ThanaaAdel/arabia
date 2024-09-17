import 'package:arabia/core/remote/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/notification_model.dart';
import 'state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.api) : super(NotificationInitial());
   ServiceApi api;
  NotificationModel? notificationModel;

  void getNotificationData() async {
    emit(GetNotificationLoadingState());
    final result = await api.notificationApi();
    result.fold(
          (failure) {
        emit(GetNotificationErrorState('Error loading data: $failure'));
      },
          (r) {
        notificationModel = r;
        emit(GetNotificationLoadedState());
      },
    );
  }
}