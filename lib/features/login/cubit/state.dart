abstract class LoginState {}

class LoginStateInitial extends LoginState {}
class LoadingState extends LoginState {}
class LoadedState extends LoginState {}
class ErrorState extends LoginState {
  final String message;
  ErrorState(this.message);
}
class SendCodeLoading extends LoginState {}

class OnSmsCodeSent extends LoginState {
  final String smsCode;

  OnSmsCodeSent(this.smsCode);
}

class VerificationLoadingState extends LoginState {}
class VerificationErrorState extends LoginState {
  final String message;

  VerificationErrorState(this.message);
}
class VerificationLoadedState extends LoginState {}
class CompleteRegisterLoadingState extends LoginState {}
class CompleteRegisterErrorState extends LoginState {
  final String message;

  CompleteRegisterErrorState(this.message);
}
class CompleteRegisterLoadedState extends LoginState {}
class LoginWithClientIdLoadingState extends LoginState {}
class LoginWithClientIdErrorState extends LoginState {
  final String message;

  LoginWithClientIdErrorState(this.message);
}
class LoginWithClientIdLoadedState extends LoginState {}
class ChildrenNumberLoadedState extends LoginState {}
class TypeOfStayLoadedState extends LoginState {}
class VerificationTimerRunning extends LoginState {
  final String timerText;

  VerificationTimerRunning(this.timerText);
}

class VerificationResendAvailable extends LoginState {}