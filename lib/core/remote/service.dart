
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../api/base_api_consumer.dart';
import '../api/end_points.dart';
import '../error/exceptions.dart';
import '../error/failures.dart';
import '../models/GetTransferServiceTypeModel.dart';
import '../models/complete_register_model.dart';
import '../models/contract_model.dart';
import '../models/experance_model.dart';
import '../models/get_country_model.dart';
import '../models/get_hourly__package_model.dart';
import '../models/get_monthly_Data.dart';
import '../models/get_occupations_model.dart';
import '../models/get_profile_data_model.dart';
import '../models/insert_hourly_data_model.dart';
import '../models/insert_mediation_request_model.dart';
import '../models/insert_monthly_data_model.dart';
import '../models/insert_profissional_employment_model.dart';
import '../models/insert_transfare_service_model.dart';
import '../models/login_model.dart';
import '../models/login_with_client_id_model.dart';
import '../models/offers_model.dart';
import '../models/religions_model.dart';
import '../models/type_accomonation_type.dart';
import '../models/verification_model.dart';
import '../preferences/preferences.dart';

class ServiceApi {
  final BaseApiConsumer dio;

  ServiceApi(this.dio);

  Future<Either<Failure, LoginModel>> loginApi(String phone) async {
    try {
      var response = await dio.post(
        EndPoints.baseUrl,
        body: {
          "apiToken": "x93mY",
          "action": "sendSMSConfirmationCode",
          "mobile_num": phone,
          'lang': await Preferences.instance.getSavedLang() == 'ar' ? 1 : 2,
        },
        formDataIsEnabled: true,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      return Right(LoginModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  /////////////////// otp api ///////////////////////////
  Future<Either<Failure, VerificationModel>> verificationApi(
      String confirmCode) async {
    LoginModel loginModel = await Preferences.instance.getUserModel();
    try {
      var response = await dio.post(
        EndPoints.baseUrl,
        body: {
          'action': "checkSMSConfirmationCodeAndGetRegistrationStatusOfClient",
          'apiToken': "x93mY",
          "confirm_code": confirmCode,
          'lang': await Preferences.instance.getSavedLang() == 'ar' ? 1 : 2,
          "token": loginModel.data?.token,
        },
        formDataIsEnabled: true,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      return Right(VerificationModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  /////////////////// complete register  ///////////////////////////
  Future<Either<Failure, CompleteRegisterModel>> completeRegisterApi(
      {required String firstName,
      required String lastName,
      required String houseAccommodationType,
      required String familyNumber}) async {
    LoginModel loginModel = await Preferences.instance.getUserModel();
    try {
      var response = await dio.post(
        EndPoints.baseUrl,
        body: {
          'action': "registerNewClientPerson",
          'apiToken': "x93mY",
          "identity_no": "1234567890",
          "mobile_no": loginModel.data!.mobileNum,
          "firstname": firstName,
          "lastname": lastName,
          "y": 66,
          "house_accommodation_type": houseAccommodationType,
          "family_no": familyNumber,
          "token": loginModel.data?.token,
        },
        formDataIsEnabled: true,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      print("the dddddddddddddddddddd${loginModel.data!.mobileNum}");
      return Right(CompleteRegisterModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  /////////////////// login with ClientId   ///////////////////////////
  Future<Either<Failure, LoginWithClientIdModel>> loginWithClientIdApi(
      {required String clientId}) async {
    LoginModel loginModel = await Preferences.instance.getUserModel();
    try {
      var response = await dio.post(
        EndPoints.baseUrl,
        body: {
          'action': "loginWithClientId",
          'apiToken': "x93mY",
          'client_id': clientId,
        },
        formDataIsEnabled: true,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      print("the dddddddddddddddddddd${loginModel.data!.mobileNum}");
      return Right(LoginWithClientIdModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  ////////////////////////country ///////////////////////
  Future<Either<Failure, GetCountriesModel>> getCountryApi() async {
    try {
      var response = await dio.post(
        EndPoints.baseUrl,
        body: {
          'action': "___getCountries",
          'apiToken': "x93mY",
          'lang': await Preferences.instance.getSavedLang() == 'ar' ? 1 : 2,
        },
        formDataIsEnabled: true,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      return Right(GetCountriesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  ////////////////////////Experince ///////////////////////
  Future<Either<Failure, ExperanceModel>> getExperianceApi() async {
    try {
      var response = await dio.post(
        EndPoints.baseUrl,
        body: {
          'action': "___getExperiencesOptions",
          'apiToken': "x93mY",
          'lang': await Preferences.instance.getSavedLang() == 'ar' ? 1 : 2,
        },
        formDataIsEnabled: true,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      return Right(ExperanceModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  ////////////////////////Experince ///////////////////////
  Future<Either<Failure, GetTransferServiceTypeModel>> getTransferServiceTypeOptionsApi() async {
    try {
      var response = await dio.post(
        EndPoints.baseUrl,
        body: {
          'action': "__getTransferServiceTypeOptions",
          'apiToken': "x93mY",
          'lang': await Preferences.instance.getSavedLang() == 'ar' ? 1 : 2,
        },
        formDataIsEnabled: true,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      return Right(GetTransferServiceTypeModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  /////////////////// insert profissional employment data ///////////////////
  Future<Either<Failure, InsertProfissionalEmployementModel>>
      insertProfissionalEmploymentApi({
    required String countryId,
    required String occId,
    required String experince,
    required String visaNo,
  }) async {
    LoginWithClientIdModel? loginWithSessionModel =
        await Preferences.instance.getUserModelWithSession();

    try {

      var response = await dio.post(
        EndPoints.baseUrl,
        body: {
          'apiToken': "x93mY",
          'action': "insertMediationRequest",
          'session_token': loginWithSessionModel?.data?.sessionToken ?? '',
          'client_id': loginWithSessionModel?.data?.clientId,
          'country_id': countryId,
          'occ_id': occId,
          'experience': experince,
          'visa_no': visaNo,
          'lang': await Preferences.instance.getSavedLang() == 'ar' ? 1 : 2,
        },
        formDataIsEnabled: true,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      return Right(InsertProfissionalEmployementModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  /////////////////// insert profissional employment data ///////////////////
  Future<Either<Failure, ContractModel>>
  contractApi() async {
    LoginWithClientIdModel? loginWithSessionModel =
    await Preferences.instance.getUserModelWithSession();

    try {

      var response = await dio.post(
        EndPoints.baseUrl,
        body: {
          'apiToken': "x93mY",
          'action': "getAllClientsContractsAttachments",
          'session_token': "c9f0f895fb98ab9159f51fd0297e236d",
          'client_id': 14,
          'lang': await Preferences.instance.getSavedLang() == 'ar' ? 1 : 2,
        },
        formDataIsEnabled: true,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      return Right(ContractModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  /////////////////// insert transfare service employment data ///////////////////
  Future<Either<Failure, InsertTransefareServiceModel>>
  insertTransfareServiceApi({
    required String currentWorkerOccId,
    required String currentWorkerCountryId,
    required String currentWorkerReligion,
    required String transferType,
  }) async {
    LoginWithClientIdModel? loginWithSessionModel =
    await Preferences.instance.getUserModelWithSession();

    try {

      var response = await dio.post(
        EndPoints.baseUrl,
        body: {
          'apiToken': "x93mY",
          'action': "InsertTransferServiceRequest",
          'session_token': loginWithSessionModel?.data?.sessionToken ?? '',
          'client_id': loginWithSessionModel?.data?.clientId,
          'current_worker_country_id':currentWorkerCountryId,
          'current_worker_occ_id': currentWorkerOccId,
          'current_worker_religion':currentWorkerReligion,
          'transfer_type': transferType,
          'lang': await Preferences.instance.getSavedLang() == 'ar' ? 1 : 2,
        },
        formDataIsEnabled: true,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      return Right(InsertTransefareServiceModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  /////////////////// insert hourly data ///////////////////
  Future<Either<Failure, InsertMediationRequestModel>>
      insertMediationRequestApi({
    required String countryId,
    required int occId,
    required String experince,
    required String religion,
    required String visaNo,
  }) async {
    LoginWithClientIdModel? loginWithSessionModel =
        await Preferences.instance.getUserModelWithSession();

    try {
      // Build the body of the request dynamically
      Map<String, dynamic> body = {
        'apiToken': "x93mY",
        'action': "insertMediationRequest",
        'session_token': loginWithSessionModel?.data?.sessionToken ?? '',
        'client_id': loginWithSessionModel?.data?.clientId,
        'country_id': countryId,
        'occ_id': occId,
        'Experience': experince,
        'Religion': religion,
        'visa_no': visaNo,
        'lang': await Preferences.instance.getSavedLang() == 'ar' ? 1 : 2,
      };
      var response = await dio.post(
        EndPoints.baseUrl,
        body: body,
        formDataIsEnabled: true,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      return Right(InsertMediationRequestModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  ////////////////////////Experince ///////////////////////
  Future<Either<Failure, ReligionsModel>> getReligionsApi() async {
    try {
      var response = await dio.post(
        EndPoints.baseUrl,
        body: {
          'action': "___getReligionsOptions",
          'apiToken': "x93mY",
          'lang': await Preferences.instance.getSavedLang() == 'ar' ? 1 : 2,
        },
        formDataIsEnabled: true,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      return Right(ReligionsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  ////////////////////////offers ///////////////////////
  Future<Either<Failure, OffersModel>> getOffersApi() async {
    try {
      var response = await dio.post(
        EndPoints.baseUrl,
        body: {
          'action': "___mobileArticlesOffers",
          'apiToken': "x93mY",
          'lang': await Preferences.instance.getSavedLang() == 'ar' ? 1 : 2,
        },
        formDataIsEnabled: true,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      return Right(OffersModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  ////////////////////////HouseAccommondationType ///////////////////////
  Future<Either<Failure, HouseAccommondationTypeModel>>
      getClientHouseAccomonationTypeApi() async {
    try {
      var response = await dio.post(
        EndPoints.baseUrl,
        body: {
          'action': "__getClientHouseAccommodationTypeOptions",
          'apiToken': "x93mY",
          'lang': await Preferences.instance.getSavedLang() == 'ar' ? 1 : 2,
        },
        formDataIsEnabled: true,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      return Right(HouseAccommondationTypeModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  ////////////////////////GetOccupations  ///////////////////////
  Future<Either<Failure, GetOccupationsModel>> getGetOccupationsApi(
      {required String clientId}) async {
    try {
      var response = await dio.post(
        EndPoints.baseUrl,
        body: {
          'action': "___getOccupations",
          'apiToken': "x93mY",
          'client_id': clientId,
          'lang': await Preferences.instance.getSavedLang() == 'ar' ? 1 : 2,
        },
        formDataIsEnabled: true,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      return Right(GetOccupationsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  /////////////////// insert hourly data ///////////////////
  Future<Either<Failure, InsertHourlyDataModel>> insertHourlyDataApi({
    required String countryId,
    required int occId,
    required int hourlyRentalMobilePackageId,
    required String serviceTimeFrom,
    required String serviceTimeTo,
    required List<String> daysToServe, // List of days to serve
    required int costWithoutTax,
    required int costTax,
    required int costIncludeTax,
    required int costTaxRatio,
    required String countOfWorkers,
    required int visitPackageId,
  }) async {
    LoginWithClientIdModel? loginWithSessionModel =
        await Preferences.instance.getUserModelWithSession();

    try {
      // Build the body of the request dynamically
      Map<String, dynamic> body = {
        'apiToken': "x93mY",
        'action': "insertRentHourlyRequest",
        'session_token': loginWithSessionModel?.data?.sessionToken ?? '',
        'client_id': loginWithSessionModel?.data?.clientId,
        'country_id': countryId,
        'occ_id': occId,
        'hourly_rental_mobile_package_id': hourlyRentalMobilePackageId,
        'service_time_from': serviceTimeFrom,
        'service_time_to': serviceTimeTo,
        'cost_without_tax': costWithoutTax,
        'cost_tax': costTax,
        'cost_include_tax': costIncludeTax,
        'cost_tax_ratio': costTaxRatio,
        'count_of_workers': countOfWorkers,
        'visit_package_id': visitPackageId,
        'lang': await Preferences.instance.getSavedLang() == 'ar' ? 1 : 2,
      };

      // Dynamically add days to serve
      for (int i = 0; i < daysToServe.length; i++) {
        body['days_to_serve[$i]'] = daysToServe[i];
      }

      var response = await dio.post(
        EndPoints.baseUrl,
        body: body,
        formDataIsEnabled: true,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      return Right(InsertHourlyDataModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  /////////////////// insert Month data ///////////////////
  Future<Either<Failure, InsertMonthlyDataModel>> insertMonthlyDataApi({
    required int countryId,
    required int occId,
    required int monthlyRentalMobilePackageId,
    required String serviceTimeFrom,
    required String serviceTimeTo,
    required int countOfWorkers,
    required String totalInvoiceCostWithoutTax,
    required String totalInvoiceCostTax,
    required String totalInvoiceCostIncludeTax,
    required String totalInvoiceCostTaxRatio,
  }) async {
    LoginWithClientIdModel? loginWithSessionModel =
        await Preferences.instance.getUserModelWithSession();

    try {
      // Build the body of the request dynamically
      Map<String, dynamic> body = {
        'apiToken': "x93mY",
        'action': "insertRentMonthlyRequest",
        'session_token': loginWithSessionModel?.data?.sessionToken ?? '',
        'client_id': loginWithSessionModel?.data?.clientId,
        'country_id': countryId,
        'occ_id': occId,
        'monthly_rental_mobile_package_id': monthlyRentalMobilePackageId,
        'service_date_from': serviceTimeFrom,
        'service_date_to': serviceTimeTo,
        'total_invoice_cost_without_tax': totalInvoiceCostWithoutTax,
        'total_invoice_cost_tax': totalInvoiceCostTax,
        'count_of_workers': countOfWorkers,
        'total_invoice_cost_include_tax': totalInvoiceCostIncludeTax,
        'total_invoice_cost_tax_ratio': totalInvoiceCostTaxRatio,
        'lang': await Preferences.instance.getSavedLang() == 'ar' ? 1 : 2,
      };

      var response = await dio.post(
        EndPoints.baseUrl,
        body: body,
        formDataIsEnabled: true,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      return Right(InsertMonthlyDataModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  ////////////////////////Get hour package  ///////////////////////

  Future<Either<Failure, GetHourlyPackageModel>> getHourlyPackageApi(
      {required String clientId}) async {
    LoginWithClientIdModel? loginWithSessionModel =
        await Preferences.instance.getUserModelWithSession();

    try {
      var response = await dio.post(
        EndPoints.baseUrl,
        body: {
          'action': "getAllRentalHourlyPackages",
          'apiToken': "x93mY",
          'client_id': clientId,
          'lang': await Preferences.instance.getSavedLang() == 'ar' ? 1 : 2,
          'session_token': loginWithSessionModel?.data?.sessionToken ?? ''
        },
        formDataIsEnabled: true,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      return Right(GetHourlyPackageModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  ////////////////////////Get Month package  ///////////////////////

  Future<Either<Failure, GetMonthlyDataModel>> getMonthPackageApi(
      {required String clientId}) async {
    LoginWithClientIdModel? loginWithSessionModel =
    await Preferences.instance.getUserModelWithSession();

    try {
      var response = await dio.post(
        EndPoints.baseUrl,
        body: {
          'action': "getAllRentalMonthlyPackages",
          'apiToken': "x93mY",
          'client_id': clientId,
          'lang': await Preferences.instance.getSavedLang() == 'ar' ? 1 : 2,
          'session_token': loginWithSessionModel?.data?.sessionToken ?? ''
        },
        formDataIsEnabled: true,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      return Right(GetMonthlyDataModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  ////////////////////////Get Profile Data  ///////////////////////
  Future<Either<Failure, GetProfileDataModel>> getProfileDataApi() async {
    LoginWithClientIdModel? loginWithSessionModel =
        await Preferences.instance.getUserModelWithSession();

    try {
      var response = await dio.post(
        EndPoints.baseUrl,
        body: {
          'action': "___getClientProfileDataAsLanguage",
          'apiToken': "x93mY",
          'client_id': loginWithSessionModel?.data?.clientId,
          'lang': await Preferences.instance.getSavedLang() == 'ar' ? 1 : 2,
          'session_token': loginWithSessionModel?.data?.sessionToken ?? '',
          'y': 66
        },
        formDataIsEnabled: true,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      return Right(GetProfileDataModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

}
