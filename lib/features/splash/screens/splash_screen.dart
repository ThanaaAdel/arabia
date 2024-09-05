import 'dart:async';
import 'package:flutter/material.dart';
import 'package:arabia/core/utils/assets_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../core/models/login_with_client_id_model.dart';
import '../../../core/preferences/preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  void _startDelay() {
    _timer = Timer(
      const Duration(seconds: 5, milliseconds: 200),
      _goNext,
    );
  }

  Future<void> _goNext() async {
    await _getStoreUserWithSession();
  }

  Future<void> _getStoreUserWithSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userWithSession = prefs.getString('userWithSession');
    print("Stored session data: $userWithSession"); // Debugging: Check stored session data

    if (userWithSession != null) {
      // Fetch the user model correctly
      LoginWithClientIdModel? user = await Preferences.instance.getUserModelWithSession();
      if (user != null) {
        print("Session found, navigating to Home."); // Debugging: Print if session is valid
        Navigator.pushReplacementNamed(context, Routes.homeRoute);
      } else {
        print("Session data is invalid, navigating to Login."); // Debugging: Print if session is invalid
        Navigator.pushReplacementNamed(context, Routes.loginRoute);
      }
    } else {
      print("No session found, navigating to Login."); // Debugging: Print when no session is found
      Navigator.pushReplacementNamed(context, Routes.loginRoute);
    }
  }


  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SvgPicture.asset(
              ImageAssets.splashBackgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 250.h,
            width: 350.w,
            child: SvgPicture.asset(ImageAssets.splashTextImage),
          ),
        ],
      ),
    );
  }
}
