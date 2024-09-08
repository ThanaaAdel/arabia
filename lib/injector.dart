import 'package:arabia/features/home_screen/cubit/cubit.dart';
import 'package:arabia/features/new_compliants_screen/cubit/cubit.dart';
import 'package:dio/dio.dart';
import 'package:arabia/features/login/cubit/cubit.dart';
import 'package:arabia/features/splash/cubit/cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:arabia/core/remote/service.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'core/api/app_interceptors.dart';
import 'core/api/base_api_consumer.dart';
import 'core/api/dio_consumer.dart';
import 'features/complain_screen/cubit/cubit.dart';
import 'features/contarcts_screen/cubit/cubit.dart';
import 'features/contract_houres_screen/cubit/cubit.dart';
import 'features/follow_up_on_orders_screen/cubit/cubit.dart';
import 'features/hourly_contracts_screen/cubit/cubit.dart';


final serviceLocator = GetIt.instance;

Future<void> setup() async {
  //! Features

  ///////////////////////// Blocs ////////////////////////

  serviceLocator.registerFactory(
    () => SplashCubit(),
  );

  serviceLocator.registerFactory(
    () => LoginCubit(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => HomeCubit(
      serviceLocator(),
    ),
  );  serviceLocator.registerFactory(
    () => ContractHourCubit(
      serviceLocator(),
    ),
  );


  serviceLocator.registerFactory(
    () => ComplaintsCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => NewComplaintsCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => ContractsCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => FollowUpOnOrdersCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => HourlyContractsCubit(
      serviceLocator(),
    ),
  );
  ///////////////////////////////////////////////////////////////////////////////

  //! External
  // Shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);

  serviceLocator.registerLazySingleton(() => ServiceApi(serviceLocator()));

  serviceLocator.registerLazySingleton<BaseApiConsumer>(
      () => DioConsumer(client: serviceLocator()));
  serviceLocator.registerLazySingleton(() => AppInterceptors());

  // Dio
  serviceLocator.registerLazySingleton(
    () => Dio(
      BaseOptions(
        contentType: "application/x-www-form-urlencoded",
        headers: {
          "Accept": "application/json",
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true,
    ),
  );
}
