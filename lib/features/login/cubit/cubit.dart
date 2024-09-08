import 'dart:async';

import 'package:arabia/core/models/login_model.dart';
import 'package:arabia/core/models/login_with_client_id_model.dart';
import 'package:arabia/core/models/verification_model.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/models/complete_register_model.dart';
import '../../../core/models/type_accomonation_type.dart';
import '../../../core/utils/dialogs.dart';
import 'state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/remote/service.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/preferences/preferences.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.api) : super(LoginStateInitial());

  final ServiceApi api;
  final TextEditingController phoneEditingController = TextEditingController();
  String _countryCode = '+966'; // Add this private field

  String get countryCode => _countryCode; // Getter for countryCode

  set countryCode(String value) {  // Setter for countryCode
    _countryCode = value;
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyCompleteRegister = GlobalKey<FormState>();
  LoginModel? loginModel;
  VerificationModel? verificationModel;
  LoginWithClientIdModel? loginWithClientIdModel;

  String? smsText;
  CompleteRegisterModel? completeRegisterModel;
  final TextEditingController otpController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  Timer? _timer;
  int _timerSeconds = 600;

  void startCountdown() {
    emit(VerificationTimerRunning(_formatTimerText(_timerSeconds)));

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        _timerSeconds--;
        emit(VerificationTimerRunning(_formatTimerText(_timerSeconds)));
      } else {
        emit(VerificationResendAvailable());
        _timer?.cancel();
      }
    });
  }

  void resendCode() {
    _timer?.cancel();
    _timerSeconds = 600;
    startCountdown();
  }

  String _formatTimerText(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$remainingSeconds";
  }


  @override
  Future<void> close() {
    // Dispose of controllers when the Cubit is closed
    phoneEditingController.dispose();
    otpController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    _timer?.cancel();
    return super.close();
  }
  String? childrenNumber;
  selectChildrenNumber(String number) {
    childrenNumber = number;
    emit(ChildrenNumberLoadedState());
  }
  String? selectTypeOfStay;
  selectTypeOfStayValue(String value) {
    selectTypeOfStay = value;
    emit(TypeOfStayLoadedState());
  }
  void verificationData(BuildContext context) async {
    emit(VerificationLoadingState());
    final result = await api.verificationApi(otpController.text);
    result.fold(
          (failure) {
        emit(VerificationErrorState('Error loading data: $failure'));
      },
          (r) {
        if (r.code == 200) {
          verificationModel = r;
          if (r.data!.code == 303) {
            loginWithClientIdData(
              context,
              r.data!.data!.clientId.toString(),
            );
          } else {
           Navigator.pushNamed(context,Routes.completeTheRegistrationDataRoute);
          }

          successGetBar("verification_success".tr());
        } else {
          errorGetBar(r.msg ?? '');
        }
        emit(VerificationLoadedState());
      },
    );
  }

  void completeRegisterData(BuildContext context) async {
    emit(CompleteRegisterLoadingState());
    final result = await api.completeRegisterApi(
      familyNumber: childrenNumber.toString(),
      houseAccommodationType: selectTypeOfStay!,
      lastName: lastNameController.text,
      firstName: firstNameController.text,
    );
    result.fold(
          (failure) {
        emit(CompleteRegisterErrorState('Error loading data: $failure'));
      },
          (r) {
        if (r.code == 200) {
          completeRegisterModel = r;
          loginWithClientIdData(context, r.data!.clientId.toString());
          successGetBar("complete_register_success".tr());
        } else {
          errorGetBar(r.msg ?? '');
        }
        emit(CompleteRegisterLoadedState());
      },
    );
  }

  void loginData(BuildContext context) async {
    emit(LoadingState());
    final result = await api.loginApi(countryCode + phoneEditingController.text);
    result.fold(
          (failure) {
        emit(ErrorState('Error loading data: $failure'));
      },
          (r) {
        if (r.code == 200) {
          Preferences.instance.setUser(r).then((value) {
            loginModel = r;
            Navigator.pushNamed(context, Routes.verificationRoute);
            successGetBar("success_login".tr());
          });
        } else {
          errorGetBar(r.msg ?? '');
        }
        emit(LoadedState());
      },
    );
  }
  HouseAccommondationTypeModel? houseAccommondationTypeModel;
  void loginWithClientIdData(BuildContext context, String clientId) async {
    emit(LoginWithClientIdLoadingState());
    final result = await api.loginWithClientIdApi(clientId: clientId);
    result.fold(
          (failure) {
        emit(LoginWithClientIdErrorState('Error loading data: $failure'));
      },
          (r) {
        if (r.code == 200) {
          loginWithClientIdModel = r;
          Navigator.pushNamed(context, Routes.homeRoute);
          Preferences.instance.setUserWithSession(loginWithClientIdModel!);
        } else {
          errorGetBar(r.msg ?? '');
        }
        emit(LoginWithClientIdLoadedState());
      },
    );
  }
  ///////////////////////get house accommodation type /////////////////
  void getHouseAccommodationTypeData(BuildContext context) async {
    emit(LoginWithClientIdLoadingState());
    final result = await api.getClientHouseAccomonationTypeApi();
    result.fold(
          (failure) {
        emit(LoginWithClientIdErrorState('Error loading data: $failure'));
      },
          (r) {
        if (r.code == 200) {
          houseAccommondationTypeModel = r;

        } else {
          errorGetBar(r.msg ?? '');
        }
        emit(LoginWithClientIdLoadedState());
      },
    );
  }

}
