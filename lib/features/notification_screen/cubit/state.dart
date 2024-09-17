abstract class NotificationState {}

class NotificationInitial extends NotificationState {}
class GetNotificationLoadingState extends NotificationState {}

class GetNotificationLoadedState extends NotificationState {}
class GetNotificationErrorState extends NotificationState {
  final String error;
  GetNotificationErrorState(this.error);
}