import 'package:arabia/core/utils/app_colors.dart';
import 'package:arabia/core/utils/assets_manager.dart';
import 'package:arabia/core/widgets/shared_appbar.dart';
import 'package:arabia/features/setting_screen/cubit/cubit.dart';
import 'package:arabia/features/setting_screen/cubit/state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../../core/utils/style_text.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  void initState() {
    context.read<SettingCubit>().getSettingsData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<SettingCubit>();
    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.white,
      body: Column(children: [
        Padding(
          padding:  EdgeInsets.all(20.0.sp),
          child: SharedAppbar(text: "contact_us".tr()),
        ),
        BlocBuilder<SettingCubit,SettingState>(
          builder: (context,state) {
            return Expanded(
              child: Column(children: [
                Container(
                  height: 55.h,
                  margin: EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.h),
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: AppColors.baseGrayColor,
                    borderRadius: BorderRadius.circular(8.sp),),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 40.h,
                            width: 40.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,color: AppColors.white),
                            child: Center(child: SvgPicture.asset(ImageAssets.offerIcon,width: 20.sp,height: 20.sp,),),),
                          SizedBox(width: 10.w,),
                          AutoSizeText(
                              cubit.settingModel?.data![2].title ?? '',
                              style: TextStyles.size16FontWidgetBoldBlackWithOpacity6
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.h),
                        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          color: AppColors.baseGrayColor,
                          borderRadius: BorderRadius.circular(8.sp),),
                        child: AutoSizeText(
                          cubit.settingModel?.data![2].content ?? '',
                        ),
                      ),
                    ],
                  ),
                ),
              ],),
            );
          }
        )
      ],),
    ));
  }
}


