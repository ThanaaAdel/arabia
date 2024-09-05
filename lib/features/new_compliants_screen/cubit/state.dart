abstract class NewComplaintsState {}

class NewComplaintsInitial extends NewComplaintsState {}
class LoadingUploadImage extends NewComplaintsState {}
class ErrorHomeState extends NewComplaintsState {
  final String messageError;
  ErrorHomeState(this.messageError);
}
class LoadedUploadImage extends NewComplaintsState {

}