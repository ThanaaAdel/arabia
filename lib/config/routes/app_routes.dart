import 'package:arabia/core/models/insert_monthly_data_model.dart';
import 'package:arabia/features/complain_screen/widgets/open_chat_complaints_screen.dart';
import 'package:arabia/features/insert_contract_month_screen/cubit/cubit.dart';
import 'package:arabia/features/insert_contract_month_screen/widgets/choose_package_from_contract_month.dart';
import 'package:arabia/features/insert_mediation.screen/screens/insert_mediation_screen.dart';
import 'package:arabia/features/insert_professional_employment.screen/screens/professional_employment.dart';
import 'package:arabia/features/login/screens/complete_the_registration_data_screen.dart';
import 'package:arabia/features/contarcts_screen/contarcts_screen.dart';
import 'package:arabia/features/insert_contract_houres_screen/widgets/choose_package_from_contract_hour.dart';
import 'package:arabia/features/insert_professional_employment.screen/screens/widgets/enter_data_professional_employment.screen.dart';
import 'package:arabia/features/home_screen/screens/home_Screen.dart';
import 'package:arabia/features/complain_screen/widgets/new_complaint_screen.dart';
import 'package:arabia/features/mediation_screen/mediation_contracts_screen.dart';
import 'package:arabia/features/monthly_contracts_screen/monthly_contracts_screen.dart';
import 'package:arabia/features/notification_screen/screens/notification_screen.dart';
import 'package:arabia/features/offers_screen/screens/widget/offers_details_screen.dart';
import 'package:arabia/features/offers_screen/screens/offers_screen.dart';
import 'package:arabia/features/setting_screen/screens/setting_screen.dart';
import 'package:arabia/features/login/screens/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:arabia/features/splash/screens/splash_screen.dart';
import '../../core/models/get_hourly__package_model.dart';
import '../../core/models/get_monthly_Data.dart';
import '../../core/models/insert_hourly_data_model.dart';
import '../../core/models/login_with_client_id_model.dart';
import '../../core/models/offers_model.dart';
import '../../core/models/opening_complain_model.dart';
import '../../core/utils/app_strings.dart';
import '../../features/complain_screen/complaints_screen.dart';
import '../../features/insert_contract_houres_screen/cubit/cubit.dart';
import '../../features/insert_contract_houres_screen/insert_contract_hour_screen.dart';
import '../../features/insert_contract_houres_screen/widgets/total_data_from_hour_contarct_screen.dart';
import '../../features/hourly_contracts_screen/hourly_contracts_screen.dart';
import '../../features/insert_contract_month_screen/insert_contract_month_screen.dart';
import '../../features/insert_contract_month_screen/widgets/total_data_from_month_contarct_screen.dart';
import '../../features/insert_transfer_service.screen/screens/insert_transfer_service_screen.dart';
import '../../features/login/screens/login_screen.dart';
import '../../features/professional_labor_screen/professional_labor_screen.dart';
import '../../features/transfer_service_screen/transfer_service_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String loginRoute = '/login';
  static const String verificationRoute = '/verificationRoute';
  static const String completeTheRegistrationDataRoute = '/completeTheRegistrationDataRoute';
  static const String homeRoute = '/homeRoute';
  static const String contractHoursRoute = '/contractHoursRoute';
  static const String contractMonthRoute = '/contractMonthRoute';
  static const String professionalEmploymentRoute = '/professionalEmploymentRoute';
  static const String notificationRoute = '/notificationRoute';
  static const String settingRoute = '/settingRoute';
  static const String offersRoute = '/offersRoute';
  static const String offerDetailsRoute = '/offerDetailsRoute';
  static const String complaintsRoute = '/complaintsRoute';
  static const String newComplaintRoute = '/newComplaintRoute';
  static const String openChatComplaintsRoute = '/openChatComplaintsRoute';
  static const String closeChatComplaintsRoute = '/closeChatComplaintsRoute';
  static const String contractsRoute = '/contractsRoute';
  static const String hourlyContractsRoute = '/hourlyContractsRoute';
  static const String monthlyContractsRoute = '/monthlyContractsRoute';
  static const String transferServiceRoute = '/transferServiceRoute';
  static const String mediationContractsRoute = '/mediationContractsRoute';
  static const String insertProfessionalEmploymentRoute = '/insertProfessionalEmploymentRoute';
  static const String detailsScreenRoute = '/detailsScreenRoute';
  static const String enterDataProfessionalEmploymentRoute = '/enterDataProfessionalEmploymentRoute';
  static const String insertServiceMoveRoute = '/insertServiceMoveRoute';
  static const String mediationRoute = '/mediationRoute';
  static const String choosePackageFromContractHourRoute = '/choosePackageFromContractHourRoute';
  static const String choosePackageFromContractMonthRoute = '/choosePackageFromContractMonthRoute';
  static const String totalDataFromHourContactRoute = '/totalDataFromHourContactRoute';
  static const String totalDataFromMonthContactRoute = '/totalDataFromMonthContactRoute';
}

class AppRoutes {
  static String route = '';

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );

      case Routes.verificationRoute:
        return MaterialPageRoute(
          builder: (context) => const VerificationScreen(),
        );
      case Routes.completeTheRegistrationDataRoute:
        return MaterialPageRoute(
          builder: (context) => const CompleteTheRegistrationDataScreen(),
        );
      case Routes.homeRoute:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case Routes.contractHoursRoute:
        final loginWithClientIdModel = settings.arguments as LoginWithClientIdModel;
        return MaterialPageRoute(
          builder: (context) => InsertContractHourScreen(
            loginWithClientIdModel: loginWithClientIdModel,
          ),
        );
      case Routes.contractMonthRoute:
        final loginWithClientIdModel = settings.arguments as LoginWithClientIdModel;
        return MaterialPageRoute(
          builder: (context) => InsertContractMonthScreen(
            loginWithClientIdModel: loginWithClientIdModel,
          ),
        );
      case Routes.insertProfessionalEmploymentRoute:
        final clientId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => InsertProfessionalEmploymentScreen(
            clientId: clientId,
          ),
        );
      case Routes.notificationRoute:
        return MaterialPageRoute(
          builder: (context) => const NotificationScreen(),
        );
      case Routes.settingRoute:
        return MaterialPageRoute(
          builder: (context) => const SettingScreen(),
        );
      case Routes.offersRoute:
        return MaterialPageRoute(
          builder: (context) => const OfferScreen(),
        );
      case Routes.offerDetailsRoute:
        final offersData = settings.arguments as OffersData;
        return MaterialPageRoute(
          builder: (context) => OfferDetailsScreen(
            offersData: offersData,
          ),
        );
      case Routes.complaintsRoute:
        return MaterialPageRoute(
          builder: (context) => const ComplaintsScreen(),
        );
      case Routes.openChatComplaintsRoute:
        final replyOpenComplian = settings.arguments as Reply;
        return MaterialPageRoute(
          builder: (context) => OpenChatComplainScreen(
            replyOpenComplian: replyOpenComplian,
          ),
        );
      case Routes.newComplaintRoute:
        return MaterialPageRoute(
          builder: (context) => const NewComplaintScreen(),
        );
      case Routes.contractsRoute:
        return MaterialPageRoute(
          builder: (context) => const ContractsScreen(),
        );

      case Routes.hourlyContractsRoute:
        return MaterialPageRoute(
          builder: (context) => const HourlyContractsScreen(),
        );
      case Routes.monthlyContractsRoute:
        return MaterialPageRoute(
          builder: (context) => const MonthlyContractsScreen(),
        );
      case Routes.mediationContractsRoute:
        return MaterialPageRoute(
          builder: (context) => const MediationContractsScreen(),
        );
      case Routes.professionalEmploymentRoute:
        return MaterialPageRoute(
          builder: (context) => const ProfessionalLaborScreen(),
        );
      case Routes.transferServiceRoute:
        return MaterialPageRoute(
          builder: (context) => const TransferServiceScreen(),
        );
      case Routes.enterDataProfessionalEmploymentRoute:
        final occId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => EnterDataProfessionalEmploymentScreen(
            accId: occId,
          ),
        );
      case Routes.insertServiceMoveRoute:
        final clientId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => InsertTransferServiceScreen(
            clientId: clientId,
          ),
        );
      case Routes.mediationRoute:
        return MaterialPageRoute(
          builder: (context) => const InsertMediationScreen(),
        );
      case Routes.choosePackageFromContractHourRoute:
        final args = settings.arguments as Map<String, dynamic>;
        final Package package = args['package'];
        final InsertContractHourCubit cubit = args['cubit'];
        return MaterialPageRoute(
          builder: (context) => ChoosePackageFromContractHourScreen(
            package: package,
            cubit: cubit,
          ),
        );
      case Routes.choosePackageFromContractMonthRoute:
        final args = settings.arguments as Map<String, dynamic>;
        final MonthlyPackage package = args['package'];
        final InsertContractMonthCubit cubit = args['cubit'];
        return MaterialPageRoute(
          builder: (context) => ChoosePackageFromContractMonthScreen(
            package: package,
            cubit: cubit,
          ),
        );
      case Routes.totalDataFromHourContactRoute:
        final insertHourlyDataModel = settings.arguments as InsertHourlyDataModel;
        return MaterialPageRoute(
          builder: (context) => TotalDataFromHourContactScreen(
            insertHourlyDataModel: insertHourlyDataModel,
          ),
        );
      case Routes.totalDataFromMonthContactRoute:
        final insertMonthlyDataModel = settings.arguments as InsertMonthlyDataModel;
        return MaterialPageRoute(
          builder: (context) => TotalDataFromMonthContactScreen(
            insertMonthlyDataModel: insertMonthlyDataModel,
          ),
        );
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}

