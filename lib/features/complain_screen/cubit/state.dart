abstract class ComplaintsState {}

class MainInitial extends ComplaintsState {}

class GetClosedComplaintsLoadingState extends ComplaintsState {}

class GetClosedComplaintsLoadedState extends ComplaintsState {}

class GetClosedComplaintsErrorState extends ComplaintsState {}
class GetOpeningComplaintsLoadingState extends ComplaintsState {}

class GetOpeningComplaintsLoadedState extends ComplaintsState {}

class GetOpeningComplaintsErrorState extends ComplaintsState {}
class ChangeStatusOfSelectedIndexOrder extends ComplaintsState {}
class GetRepliesComplaintsLoadingState extends ComplaintsState {}

class GetRepliesComplaintsLoadedState extends ComplaintsState {}

class GetRepliesComplaintsErrorState extends ComplaintsState {}
class LoadingUploadImage extends ComplaintsState {}
class ErrorHomeState extends ComplaintsState {
  final String messageError;
  ErrorHomeState(this.messageError);
}
class LoadedUploadImage extends ComplaintsState {

}
class AddRepliesComplaintsLoadingState extends ComplaintsState {}

class AddRepliesComplaintsLoadedState extends ComplaintsState {}

class AddRepliesComplaintsErrorState extends ComplaintsState {}
class ReplyFromComplaintLoadingState extends ComplaintsState {}
class ReplyFromComplaintLoadedState extends ComplaintsState {}

class ReplyFromComplaintErrorState extends ComplaintsState {}