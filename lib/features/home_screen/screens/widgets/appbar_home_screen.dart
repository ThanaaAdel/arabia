import 'package:arabia/core/models/get_profile_data_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/style_text.dart';

class AppbarHomeScreen extends StatelessWidget {
  const AppbarHomeScreen({
    super.key,
     this.getProfileDataModel,
  });

  final GetProfileDataModel ?getProfileDataModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(150),
              bottomRight: Radius.circular(150),
            ),
          ),
          height: 100.h,
          width: double.infinity,
          child: Image.asset(
            "assets/images/home_background_appbar.png",
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          child: Padding(
            padding: EdgeInsets.only(
              left: 20.0.w,
              right: 20.w,
              top: 50.h,
              bottom: 10.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(ImageAssets.userIcon),
                    SizedBox(
                      width: 10.w,
                    ),
                    SizedBox(  // Add a SizedBox or Container to constrain the Column
                      height: 50.h,  // Provide a height constraint to the Column
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "welcome".tr(),
                            style:
                            TextStyles.size14FontWidgetBoldBlackWithOpacity6,
                          ),
                          AutoSizeText(
                            "${getProfileDataModel?.data?.firstname} ${getProfileDataModel?.data?.lastname}",
                            style: TextStyles.size16FontWidgetRegularGrayLight,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.notificationRoute);
                  },
                  child: SvgPicture.asset(ImageAssets.notificationIcon),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
