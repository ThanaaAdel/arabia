import 'package:arabia/features/chat_complaints_screen/chat_complaints_screen.dart';
import 'package:arabia/features/login/screens/complete_the_registration_data_screen.dart';
import 'package:arabia/features/contarcts_screen/contarcts_screen.dart';
import 'package:arabia/features/contract_houres_screen/contract_hour_screen.dart';
import 'package:arabia/features/contract_houres_screen/widgets/choose_package_from_contract_hour.dart';
import 'package:arabia/features/enter_data_professional_employment.screen/screens/enter_data_professional_employment.screen.dart';
import 'package:arabia/features/follow_up_on_orders_screen/follow_up_on_orders_screen.dart';
import 'package:arabia/features/home_screen/screens/home_Screen.dart';
import 'package:arabia/features/new_compliants_screen/screens/new_complaint_screen.dart';
import 'package:arabia/features/notification_screen/screens/notification_screen.dart';
import 'package:arabia/features/offers_details_screen/screens/offers_details_screen.dart';
import 'package:arabia/features/offers_screen/screens/offers_screen.dart';
import 'package:arabia/features/setting_screen/screens/setting_screen.dart';
import 'package:arabia/features/login/screens/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:arabia/features/splash/screens/splash_screen.dart';
import '../../core/utils/app_strings.dart';
import 'package:page_transition/page_transition.dart';
import '../../features/complain_screen/complaints_screen.dart';
import '../../features/contract_houres_screen/widgets/total_data_from_hour_contarct_screen.dart';
import '../../features/contract_month_screen/contract_month_screen.dart';
import '../../features/hourly_contracts_details_screen/screens/hourly_contracts_details_screen.dart';
import '../../features/hourly_contracts_screen/hourly_contracts_screen.dart';
import '../../features/login/screens/login_screen.dart';
import '../../features/mediation.screen/screens/mediation_screen.dart';
import '../../features/professional_employment.screen/screens/professional_employment.dart';
import '../../features/service_move.screen/screens/service_move_screen.dart';

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
  static const String chatComplaintsRoute = '/chatComplaintsRoute';
  static const String newComplaintRoute = '/newComplaintRoute';
  static const String contractsRoute = '/contractsRoute';
  static const String followUpOnOrdersRoute = '/followUpOnOrdersRoute';
  static const String hourlyContractsRoute = '/hourlyContractsRoute';
  static const String hourlyContractsDetailsRoute = '/hourlyContractsDetailsRoute';
  static const String enterDataProfessionalEmploymentRoute = '/enterDataProfessionalEmploymentRoute';
  static const String serviceMoveRoute = '/serviceMoveRoute';
  static const String mediationRoute = '/mediationRoute';
  static const String choosePackageFromContractHourRoute = '/choosePackageFromContractHourRoute';
  static const String totalDataFromHourContactRoute = '/totalDataFromHourContactRoute';
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
        return PageTransition(
          child: const ContractHourScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.contractMonthRoute:
        return PageTransition(
          child: const ContractMonthScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.professionalEmploymentRoute:
        return PageTransition(
          child: const ProfessionalEmploymentScreen(),
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
        return PageTransition(
          child: const OfferDetailsScreen(),
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
      case Routes.chatComplaintsRoute:
        return PageTransition(
          child: const ChatComplaintsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );  case Routes.newComplaintRoute:
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
        );case Routes.hourlyContractsDetailsRoute:
        return PageTransition(
          child: const HourlyContractsDetailsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
        case Routes.enterDataProfessionalEmploymentRoute:
        return PageTransition(
          child: const EnterDataProfessionalEmploymentScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );case Routes.serviceMoveRoute:
        return PageTransition(
          child: const ServiceMoveScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );case Routes.mediationRoute:
        return PageTransition(
          child: const MediationScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );case Routes.choosePackageFromContractHourRoute:
        return PageTransition(
          child: const ChoosePackageFromContractHourScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );case Routes.totalDataFromHourContactRoute:
        return PageTransition(
          child: const TotalDataFromHourContactScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      //
      // case Routes.resultOfLessonExam:
      //   ResponseOfApplyLessonExmamData model =
      //       settings.arguments as ResponseOfApplyLessonExmamData;
      //   return PageTransition(
      //     child: ResultExamLessonScreen(model: model),
      //     type: PageTransitionType.fade,
      //     alignment: Alignment.center,
      //     duration: const Duration(milliseconds: 800),
      //   );

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
