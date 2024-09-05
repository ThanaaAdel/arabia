import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'config/routes/app_routes.dart';
import 'config/themes/app_theme.dart';
import 'core/utils/app_strings.dart';
import 'package:arabia/injector.dart' as injector;
import 'features/complain_screen/cubit/cubit.dart';
import 'features/contarcts_screen/cubit/cubit.dart';
import 'features/follow_up_on_orders_screen/cubit/cubit.dart';
import 'features/home_screen/cubit/cubit.dart';
import 'features/hourly_contracts_screen/cubit/cubit.dart';
import 'features/login/cubit/cubit.dart';
import 'features/new_compliants_screen/cubit/cubit.dart';
import 'features/splash/cubit/cubit.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(text);

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => injector.serviceLocator<SplashCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<LoginCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<HomeCubit>(),
          ),

          BlocProvider(
            create: (_) => injector.serviceLocator<ComplaintsCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<NewComplaintsCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<ContractsCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<FollowUpOnOrdersCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<HourlyContractsCubit>(),
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          child: GetMaterialApp(
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: appTheme(),
            themeMode: ThemeMode.light,
            darkTheme: ThemeData.light(),
            // standard dark theme
            localizationsDelegates: context.localizationDelegates,
            debugShowCheckedModeBanner: false,
            title: AppStrings.appName,
            onGenerateRoute: AppRoutes.onGenerateRoute,
          ),
        ));
  }
}
