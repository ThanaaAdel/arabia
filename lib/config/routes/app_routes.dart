import 'package:arabia/core/models/insert_monthly_data_model.dart';
import 'package:arabia/features/complain_screen/widgets/open_chat_complaints_screen.dart';
import 'package:arabia/features/insert_contract_month_screen/cubit/cubit.dart';
import 'package:arabia/features/insert_contract_month_screen/widgets/choose_package_from_contract_month.dart';
import 'package:arabia/features/insert_mediation.screen/screens/insert_mediation_screen.dart';
import 'package:arabia/features/insert_professional_employment.screen/screens/professional_employment.dart';
import 'package:arabia/features/login/screens/complete_the_registration_data_screen.dart';
import 'package:arabia/features/contarcts_screen/contarcts_screen.dart';
import 'package:arabia/features/insert_contract_houres_screen/widgets/choose_package_from_contract_hour.dart';
import 'package:arabia/features/enter_data_professional_employment.screen/screens/enter_data_professional_employment.screen.dart';
import 'package:arabia/features/follow_up_on_orders_screen/follow_up_on_orders_screen.dart';
import 'package:arabia/features/home_screen/screens/home_Screen.dart';
import 'package:arabia/features/complain_screen/widgets/new_complaint_screen.dart';
import 'package:arabia/features/mediation_contracts_screen/mediation_contracts_screen.dart';
import 'package:arabia/features/monthly_contracts_screen/monthly_contracts_screen.dart';
import 'package:arabia/features/notification_screen/screens/notification_screen.dart';
import 'package:arabia/features/offers_screen/screens/widget/offers_details_screen.dart';
import 'package:arabia/features/offers_screen/screens/offers_screen.dart';
import 'package:arabia/features/professional_employment_screen/professional_employment_screen.dart';
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
import 'package:page_transition/page_transition.dart';
import '../../features/complain_screen/complaints_screen.dart';
import '../../features/insert_contract_houres_screen/cubit/cubit.dart';
import '../../features/insert_contract_houres_screen/insert_contract_hour_screen.dart';
import '../../features/insert_contract_houres_screen/widgets/total_data_from_hour_contarct_screen.dart';
import '../../features/hourly_contracts_screen/hourly_contracts_screen.dart';
import '../../features/insert_contract_month_screen/insert_contract_month_screen.dart';
import '../../features/insert_contract_month_screen/widgets/total_data_from_month_contarct_screen.dart';
import '../../features/insert_transfer_service.screen/screens/insert_transfer_service_screen.dart';
import '../../features/login/screens/login_screen.dart';
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
  static const String followUpOnOrdersRoute = '/followUpOnOrdersRoute';
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
        return PageTransition(
          child: const LoginScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );

      case Routes.verificationRoute:
        return PageTransition(
          child: const VerificationScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.completeTheRegistrationDataRoute:
        return PageTransition(
          child: const CompleteTheRegistrationDataScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.homeRoute:
        return PageTransition(
          child: const HomeScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.contractHoursRoute:
        final loginWithClientIdModel = settings.arguments as LoginWithClientIdModel;
        return PageTransition(
          child:  InsertContractHourScreen(loginWithClientIdModel: loginWithClientIdModel,),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.contractMonthRoute:
        final loginWithClientIdModel = settings.arguments as LoginWithClientIdModel;

        return PageTransition(
          child:  InsertContractMonthScreen(loginWithClientIdModel: loginWithClientIdModel,),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.insertProfessionalEmploymentRoute:
        final clientId = settings.arguments as String;
        return PageTransition(
          child:  InsertProfessionalEmploymentScreen(
            clientId: clientId,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.notificationRoute:
        return PageTransition(
          child: const NotificationScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.settingRoute:
        return PageTransition(
          child: const SettingScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.offersRoute:
        return PageTransition(
          child: const OfferScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.offerDetailsRoute:
        final offersData = settings.arguments as OffersData;
        return PageTransition(
          child:  OfferDetailsScreen(offersData: offersData,),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.complaintsRoute:
        return PageTransition(
          child: const ComplaintsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.openChatComplaintsRoute:
        final replyOpenComplian = settings.arguments as Reply;
        return PageTransition(
          child:  OpenChatComplainScreen(replyOpenComplian: replyOpenComplian),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
       case Routes.newComplaintRoute:
        return PageTransition(
          child: const NewComplaintScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
        case Routes.contractsRoute:
        return PageTransition(
          child: const ContractsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );  case Routes.followUpOnOrdersRoute:
        return PageTransition(
          child: const FollowUpOnOrdersScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );case Routes.hourlyContractsRoute:
        return PageTransition(
          child: const HourlyContractsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );case Routes.monthlyContractsRoute:
        return PageTransition(
          child: const MonthlyContractsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );case Routes.mediationContractsRoute:
        return PageTransition(
          child: const MediationContractsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
        case Routes.professionalEmploymentRoute:
        return PageTransition(
          child:  const ProfessionalEmploymentScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );case Routes.transferServiceRoute:
        return PageTransition(
          child:  const TransferServiceScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
        case Routes.enterDataProfessionalEmploymentRoute:
          final occId = settings.arguments as String;

          return PageTransition(
          child:  EnterDataProfessionalEmploymentScreen(
            accId: occId,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );case Routes.insertServiceMoveRoute:
      final clientId = settings.arguments as String;
        return PageTransition(
          child:  InsertTransferServiceScreen(clientId: clientId,),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );case Routes.mediationRoute:
        return PageTransition(
          child: const InsertMediationScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.choosePackageFromContractHourRoute:
        final args = settings.arguments as Map<String, dynamic>;
        final Package package = args['package'];
        final InsertContractHourCubit cubit = args['cubit'];
        return PageTransition(
          child:  ChoosePackageFromContractHourScreen(package: package,cubit: cubit,),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.choosePackageFromContractMonthRoute:
        final args = settings.arguments as Map<String, dynamic>;
        final MonthlyPackage package = args['package'];
        final InsertContractMonthCubit cubit = args['cubit'];
        return PageTransition(
          child:   ChoosePackageFromContractMonthScreen(package: package,cubit: cubit,),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
        case Routes.totalDataFromHourContactRoute:
        final insertHourlyDataModel = settings.arguments as InsertHourlyDataModel;
        return PageTransition(
          child:  TotalDataFromHourContactScreen(insertHourlyDataModel: insertHourlyDataModel,),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.totalDataFromMonthContactRoute:
        final insertMonthlyDataModel = settings.arguments as InsertMonthlyDataModel;
        return PageTransition(
          child:  TotalDataFromMonthContactScreen(insertMonthlyDataModel: insertMonthlyDataModel,),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
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
