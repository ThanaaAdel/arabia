import 'package:arabia/config/routes/app_routes.dart';
import 'package:arabia/features/setting_screen/cubit/cubit.dart';
import 'package:arabia/features/setting_screen/cubit/state.dart';
import 'package:arabia/features/setting_screen/screens/widgets/contact_us.dart';
import 'package:arabia/features/setting_screen/screens/widgets/our_info.dart';
import 'package:arabia/features/setting_screen/screens/widgets/our_services.dart';
import 'package:arabia/features/setting_screen/screens/widgets/privacy_policy_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:arabia/core/utils/assets_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/restart_app_class.dart';
import '../../../core/utils/style_text.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {





  @override
  Widget build(BuildContext context) {
    var cubit = context.read<SettingCubit>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: SvgPicture.asset(
                ImageAssets.backgroundSettingsIcon,
                fit: BoxFit.cover,
              ),
            ),

            Positioned(

                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20.0.w,
                    right: 20.0.w,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child:Directionality.of(context) == TextDirection.RTL ?  SvgPicture.asset(
                                ImageAssets.arrowVerificationImage,
                                width: 30.w,
                                height: 30.h,
                              ):
                              Container(
                                width: 30.w,
                                height: 30.h,
                                decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.orange),
                                child: Icon(Icons.arrow_back, color: AppColors.white),
                              )
                          ),
                        ],
                      ),
                      SizedBox(height: 100.h,),
                      CustomRowSetting(
                        onTap: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) => const OurServiceScreen(),));
                        },
                        title: "our_services".tr(),
                        icon: ImageAssets.myDataIcon,
                      ),
                      // CustomRowSetting(
                      //   onTap: () {
                      //     Navigator.push(context,MaterialPageRoute(builder: (context) => const AboutUsScreen(),));
                      //   },
                      //   title: "about_us".tr(),
                      //   icon: ImageAssets.aboutUsIcon,
                      // ),
                      CustomRowSetting(
                        onTap: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) => const OurInfoScreen(),));
                        },
                        title: "our_info".tr(),
                        icon: ImageAssets.ourInfoIcon,
                      ),
                      CustomRowSetting(
                        onTap: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen(),));

                        },
                        title: "privacy_policy".tr(),
                        icon: ImageAssets.termsOfUseIcon,
                      ),
                      CustomRowSetting(
                        onTap: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) => const ContactUsScreen(),));
                        },
                        title: "contact_us".tr(),
                        icon: ImageAssets.contactUsIcon,
                      ),
                      CustomRowSetting(
                        onTap: () {
                          _showLanguageDialog(context);
                        },
                        title: "language".tr(),
                        icon: ImageAssets.langaugeIcon,
                      ),
                      BlocBuilder<SettingCubit,SettingState>(

                        builder: (context,state) {
                          return CustomRowSetting(
                            title: "delete_account".tr(),
                            onTap: () {
                            cubit.deleteAccount(context);
                            },
                            icon: ImageAssets.deleteIcon,
                          );
                        }
                      ),  CustomRowSetting(
                        title: "logout".tr(),
                        onTap: () {
                          Preferences.instance.clearShared().then((value) =>
                              Navigator.pushNamedAndRemoveUntil(context,
                                  Routes.initialRoute, (route) => false));
                        },
                        icon: ImageAssets.logoutIcon,
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
    //   },
    // );
  }
  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Padding(
            padding:  EdgeInsets.all(20.0.sp),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    _changeLanguage(context, 'ar');
                  },
                  child: Container(
                    height: 55.h,
                    width: 220.w,
                    decoration: BoxDecoration(
                      color: AppColors.blue.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8.sp,)),
                    child: Center(child: Text("العربية",style: TextStyle(fontSize: 20.sp,color: AppColors.white),),),),
                ),
                SizedBox(height: 10.h,),
                GestureDetector(
                  onTap: () {
                    _changeLanguage(context, 'en');
                  },
                  child: Container(
                    height: 55.h,
                    width: 220.w,
                    decoration: BoxDecoration(
                        color: AppColors.blue,
                        borderRadius: BorderRadius.circular(8.sp,)),
                    child: Center(child: Text("English",style: TextStyle(fontSize: 20.sp,color: AppColors.white),),),),
                )

              ],
            ),
          ),
        );
      },
    );
  }

  void _changeLanguage(BuildContext context, String languageCode) {
    if (EasyLocalization.of(context)!.locale.languageCode != languageCode) {
      EasyLocalization.of(context)!.setLocale(Locale(languageCode));
      Preferences.instance.savedLang(languageCode == 'ar' ? AppStrings.arabicCode : AppStrings.englishCode);
      Preferences.instance.getSavedLang();
      HotRestartController.performHotRestart(context);
    }
    Navigator.of(context).pop();  // Close the dialog
  }
}


class CustomRowSetting extends StatelessWidget {
  const CustomRowSetting({
    super.key,
    required this.title,
    required this.icon, this.onTap,
  });
  final String title;
  final String icon;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
        child: Row(
          children: [
            Container(
              height: 35.h,
              width: 35.w,
              decoration: BoxDecoration(
                  color: AppColors.blue,
                  borderRadius: BorderRadius.circular(50.sp)),
              child: Center(
                  child: SvgPicture.asset(
                icon,
                color: AppColors.white,
                height: 20.sp,
              )),
            ),
            SizedBox(
              width: 20.w,
            ),
            Text(
              title,
              style: TextStyles.size16FontWidgetBoldBlackWithOpacity7
            )
          ],
        ),
      ),
    );
  }
}
