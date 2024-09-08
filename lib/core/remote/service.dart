

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../api/base_api_consumer.dart';
import '../api/end_points.dart';
import '../error/exceptions.dart';
import '../error/failures.dart';
import '../models/complete_register_model.dart';
import '../models/get_hourly__package_model.dart';
import '../models/get_occupations_model.dart';
import '../models/get_profile_data_model.dart';
import '../models/login_model.dart';
import '../models/login_with_client_id_model.dart';
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
          "mobile_no":loginModel.data!.mobileNum,
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
           'client_id':clientId,
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
  ////////////////////////HouseAccommondationType ///////////////////////
  Future<Either<Failure, HouseAccommondationTypeModel>> getClientHouseAccomonationTypeApi() async {

    try {
      var response = await dio.post(
        EndPoints.baseUrl,
        body: {
          'action': "__getClientHouseAccommodationTypeOptions",
          'apiToken': "x93mY",

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
          'client_id':clientId
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
  ////////////////////////Get hour package  ///////////////////////
  Future<Either<Failure, GetHourlyPackageModel>> getHourlyPackageApi(
      {required String clientId}) async {
    LoginWithClientIdModel? loginWithSessionModel = await Preferences.instance.getUserModelWithSession();

    try {
      var response = await dio.post(
        EndPoints.baseUrl,
        body: {
          'action': "getAllRentalHourlyPackages",
          'apiToken': "x93mY",
          'client_id':clientId,
          'lang': await Preferences.instance.getSavedLang() == 'ar' ? 1 : 2,
          'session_token':loginWithSessionModel?.data?.sessionToken ?? ''
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
  ////////////////////////Get Profile Data  ///////////////////////
  Future<Either<Failure, GetProfileDataModel>> getProfileDataApi() async {
    LoginWithClientIdModel? loginWithSessionModel = await Preferences.instance.getUserModelWithSession();

    try {
      var response = await dio.post(
        EndPoints.baseUrl,
        body: {
          'action': "___getClientProfileDataAsLanguage",
          'apiToken': "x93mY",
          'client_id':loginWithSessionModel?.data?.clientId,
          'lang': await Preferences.instance.getSavedLang() == 'ar' ? 1 : 2,
          'session_token':loginWithSessionModel?.data?.sessionToken ?? '',
          'y':66
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
//   //
//   // Future<Either<Failure, ServiceStoreModel>> postServiceStore(ServiceModel serviceModel) async {
//   //   LoginModel loginModel = await Preferences.instance.getUserModel();
//   //
//   //   try {
//   //     List<MultipartFile> images = [];
//   //     for (int i = 0; i < serviceModel.images.length; i++) {
//   //
//   //       var image =  await MultipartFile.fromFile(serviceModel.images[i]!.path)  ;
//   //       images.add(image);
//   //     }      List phones = [];
//   //     for(int i = 0 ; i<serviceModel.phones.length ; i++){
//   //       phones.add(serviceModel.phones[i]);
//   //     }
//   //     final response = await dio.post(
//   //       EndPoints.serviceStoreUrl,
//   //       formDataIsEnabled: true,
//   //       options: Options(
//   //         headers: {'Authorization': loginModel.data!.accessToken!},
//   //       ),
//   //       body: {
//   //         'name': serviceModel.name,
//   //         "category_id":serviceModel.category_id,
//   //         "sub_category_id":serviceModel.sub_category_id,
//   //         "city_id":serviceModel.cityId,
//   //         "phones[]": phones,
//   //         "details":serviceModel.details,
//   //         "logo": await MultipartFile.fromFile(serviceModel.logo.path),
//   //         "location":serviceModel.location,
//   //         "images[]":images,
//   //         "longitude":serviceModel.longitude,
//   //         "latitude":serviceModel.latitude,
//   //       },
//   //     );
//   //     return Right(ServiceStoreModel.fromJson(response));
//   //   } on ServerException {
//   //
//   //     return Left(ServerFailure());
//   //   }
//   // }
//
//   Future<Either<Failure,UpdatedModel >> edit(ServiceToUpdate serviceToUpdate,catId) async {
//     LoginModel loginModel = await Preferences.instance.getUserModel();
//
//     try {
//       List<MultipartFile> images = [];
//       for (int i = 0; i < serviceToUpdate.images!.length; i++) {
//
//         var image =  await MultipartFile.fromFile(serviceToUpdate.images?[i]!.path)  ;
//         images.add(image);
//       }      List phones = [];
//       for(int i = 0 ; i<serviceToUpdate.phones!.length ; i++){
//         phones.add(serviceToUpdate.phones?[i]);
//       }
//       final response = await dio.post(
//         EndPoints.editServicesUrl + catId.toString(),
//
//         formDataIsEnabled: true,
//         options: Options(
//           headers: {'Authorization': loginModel.data!.accessToken!},
//         ),
//         body: {
//           'name': serviceToUpdate.name,
//           "category_id":serviceToUpdate.categoryId,
//          // "sub_category_id":1,
//           "phones[]": phones,
//           "details":serviceToUpdate.details,
//            "city_id":serviceToUpdate.cityId,
//           "longitude":serviceToUpdate.longitude,
//           "latitude":serviceToUpdate.latitude,
//           "logo": serviceToUpdate.logo,
//           "location":serviceToUpdate.location,
//           "images[]":images,
//         },
//       );
//       return Right(UpdatedModel.fromJson(response));
//     } on ServerException {
//
//       return Left(ServerFailure());
//     }
//   }
//
//   Future<Either<Failure, RateResponseModel>> postRate({required serviceId,required value,comment}) async {
//     LoginModel loginModel = await Preferences.instance.getUserModel();
//     try {
//
//       final response = await dio.post(
//         EndPoints.rateUrl,
//         options: Options(
//           headers: {'Authorization': loginModel.data!.accessToken!},
//         ),
//         body: {
//           'service_id': serviceId,
//           "value":value,
//           "comment":comment
//         },
//       );
//       return Right(RateResponseModel.fromJson(response));
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }
//
//
//   Future<Either<Failure, LoginModel>> postEditProfile(
//       String name) async {
//     LoginModel loginModel = await Preferences.instance.getUserModel();
//
//     try {
//       final response = await dio.post(
//         EndPoints.updateProfileUrl,
//         options: Options(headers: {"Authorization":loginModel.data!.accessToken!}),
//         body: {
//           'name': name,
//           "phone":loginModel.data?.user?.phone,
//         },
//       );
//
//       return Right(LoginModel.fromJson(response));
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }
//
//
//   Future<Either<Failure, LoginModel>> postLogin(
//       String phone, String phoneCode) async {
//     try {
//       final response = await dio.post(
//         EndPoints.loginUrl,
//         body: {
//           'phone': phone,
//         },
//       );
//       return Right(LoginModel.fromJson(response));
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }
//
//   Future<Either<Failure, HomeModel>> homeData() async {
//     LoginModel loginModel = await Preferences.instance.getUserModel();
//     try {
//       final response = await dio.get(
//         EndPoints.homeUrl,
//         options: Options(
//           headers: {'Authorization': loginModel.data?.accessToken!},
//         ),
//       );
//       return Right(HomeModel.fromJson(response));
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }
//
//   Future<Either<Failure, CategoriesServicesModel>> servicesData(
//       int catId) async {
//     LoginModel loginModel = await Preferences.instance.getUserModel();
//     try {
//       final response = await dio.get(
//         EndPoints.servicesUrl + catId.toString(),
//         options: Options(
//           headers: {'Authorization': loginModel.data!.accessToken!},
//         ),
//       );
//       return Right(CategoriesServicesModel.fromJson(response));
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }
//   Future<Either<Failure, UpdatedModel>> editService(
//       int catId,ServiceToUpdate serviceToUpdate) async {
//     LoginModel loginModel = await Preferences.instance.getUserModel();
//
//     try {
//
//       List<MultipartFile> images = [];
//       for (int i = 0; i < serviceToUpdate.images!.length; i++) {
//
//         var imageFile = serviceToUpdate.images![i];
//         if (imageFile.path.startsWith('http')) {
//           // This is a remote URL, so we need to download the image and save it locally before uploading it
//           var response = await http.get(Uri.parse(imageFile.path));
//           var bytes = response.bodyBytes;
//           var tempDir = await getTemporaryDirectory();
//           var filePath = '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
//           await File(filePath).writeAsBytes(bytes);
//           var image = await MultipartFile.fromFile(filePath);
//           images.add(image);
//         } else {
//           // This is a local file, so we can create a MultipartFile object from it
//           var image = await MultipartFile.fromFile(imageFile.path);
//           images.add(image);
//         }
//       }
//       final response = await dio.post(
//         EndPoints.editServicesUrl + catId.toString(),
//
//         options: Options(
//           headers: {'Authorization': loginModel.data!.accessToken!},
//         ),
//         body: {
//           "name":serviceToUpdate.name,
//           "category_id":serviceToUpdate.categoryId,
//           "sub_category_id":serviceToUpdate.subCategoryId,
//           "phones[0]":serviceToUpdate.phones?[0],
//           "phones[1]":serviceToUpdate.phones?[1],
//           "details":serviceToUpdate.details,
//          // "logo":serviceToUpdate.logo,
//           //"logo": await MultipartFile.fromFile(serviceToUpdate.logo!),
//           "logo": !serviceToUpdate.logo!.path.startsWith("http")?await MultipartFile.fromFile(serviceToUpdate.logo!.path):null,
//           "location":serviceToUpdate.location,
//           "images[]":images,
//
//         }
//
//       );
//      print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
//       print(response);
//       return Right(UpdatedModel.fromJson(response));
//     } on ServerException {
//       print("erroooooor");
//       return Left(ServerFailure());
//     }
//   }
//
//   Future<Either<Failure, CategoriesServicesModel>> servicesSearchData(
//       int catId,searchKey) async {
//     LoginModel loginModel = await Preferences.instance.getUserModel();
//     try {
//       final response = await dio.get(
//         EndPoints.servicesUrl + catId.toString(),
//         options: Options(
//           headers: {'Authorization': loginModel.data!.accessToken!},
//         ),
//         queryParameters: {"search_key":searchKey}
//       );
//       return Right(CategoriesServicesModel.fromJson(response));
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }
//
//   Future<Either<Failure, FavoriteModel>>getFavoriteData() async {
//     LoginModel loginModel = await Preferences.instance.getUserModel();
//     try {
//       final response = await dio.get(
//         EndPoints.favoriteUrl ,
//         options: Options(
//           headers: {'Authorization': loginModel.data!.accessToken!},
//         ),
//       );
//       return Right(FavoriteModel.fromJson(response));
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }
//
//   Future<Either<Failure,CitiesModel>> getCities()async{
//     LoginModel loginModel = await Preferences.instance.getUserModel();
//     try{
//       final response = await dio.get(
//           EndPoints.citiesUrl,
//         options: Options(
//           headers: {'Authorization': loginModel.data!.accessToken!},
//         ),
//       );
//       return Right(CitiesModel.fromJson(response));
//     } on ServerException{
//       return Left(ServerFailure());
//     }
//   }
//
//   Future<Either<Failure, FavoriteModel>>getFavoriteSearchData(searchKey) async {
//
//     LoginModel loginModel = await Preferences.instance.getUserModel();
//     try {
//       final response = await dio.get(
//         EndPoints.favoriteUrl ,
//         options: Options(
//           headers: {'Authorization': loginModel.data!.accessToken!},
//         ),
//         queryParameters: {"search_key":searchKey}
//       );
//
//       return Right(FavoriteModel.fromJson(response));
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }
//
//   Future<Either<Failure, MyServicesModel>>getMyServicesData() async {
//
//     LoginModel loginModel = await Preferences.instance.getUserModel();
//     try {
//       final response = await dio.get(
//         EndPoints.myServicesUrl ,
//         options: Options(
//           headers: {'Authorization': loginModel.data!.accessToken!},
//         ),
//       );
//       return Right(MyServicesModel.fromJson(response));
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }
//
//
//   Future<Either<Failure, MyServicesModel>>getMyServicesSearchData(searchKey) async {
//
//     LoginModel loginModel = await Preferences.instance.getUserModel();
//     try {
//
//       final response = await dio.get(
//         EndPoints.myServicesUrl ,
//         options: Options(
//           headers: {'Authorization': loginModel.data!.accessToken!},
//         ),
//         queryParameters: {"search_key":searchKey}
//
//       );
//
//       return Right(MyServicesModel.fromJson(response));
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }
//
//   // Future<Either<Failure, NotificationModel>>getNotifications() async {
//   //
//   //   LoginModel loginModel = await Preferences.instance.getUserModel();
//   //   try {
//   //
//   //     final response = await dio.get(
//   //         EndPoints.notificationUrl ,
//   //         options: Options(
//   //           headers: {'Authorization': loginModel.data!.accessToken!},
//   //         ),
//   //
//   //
//   //     );
//   //
//   //     return Right(NotificationModel.fromJson(response));
//   //   } on ServerException {
//   //     return Left(ServerFailure());
//   //   }
//   // }
//   //
//
//
//
//   Future<Either<Failure, CategoriesModel>>getCategoriesData() async {
//     LoginModel loginModel = await Preferences.instance.getUserModel();
//     try {
//       final response = await dio.get(
//         EndPoints.categoriesUrl ,
//         options: Options(
//           headers: {'Authorization': loginModel.data!.accessToken!},
//         ),
//       );
//       return Right(CategoriesModel.fromJson(response));
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }
//
//   Future<Either<Failure, SettingModel>> getSettingData() async {
//     LoginModel loginModel = await Preferences.instance.getUserModel();
//     try {
//       final response = await dio.get(
//         EndPoints.settingUrl,
//         options: Options(
//           headers: {'Authorization': loginModel.data!.accessToken!},
//         ),
//       );
//
//       return Right(SettingModel.fromJson(response));
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }
//
//   Future<Either<Failure,AddToFavouriteResponseModel>> addToFavourite(serviceId) async {
//     LoginModel loginModel = await Preferences.instance.getUserModel();
// try{
//
//   final response = await dio.post(
//       EndPoints.addToFavouriteUrl,
//       options: Options(
//         headers: {"Authorization":loginModel.data!.accessToken},
//       ),
//       body: {"service_id":serviceId}
//   );
//   return Right(AddToFavouriteResponseModel.fromJson(response));
// } on ServerException{
//   return Left(ServerFailure());
// }
//   }

  // Future<Either<Failure, SearchModel>> search(searchKey) async {
  //   LoginModel loginModel = await Preferences.instance.getUserModel();
  //
  //   try {
  //     final response = await dio.get(
  //       EndPoints.searchUrl+searchKey,
  //       options: Options(
  //         headers: {'Authorization': loginModel.data!.accessToken!},
  //       ),
  //     );
  //     return Right(SearchModel.fromJson(response));
  //   } on ServerException {
  //     return Left(ServerFailure());
  //   }
  // }
}
