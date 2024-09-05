import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/style_text.dart';

class AppbarHomeScreen extends StatelessWidget {
  const AppbarHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(150),
                  bottomRight: Radius.circular(150))),
          height: 110.h,
          width: double.infinity,
          child: Image.asset(
            "assets/images/home_background_appbar.png",
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
            child: Padding(
          padding: EdgeInsets.only(
              left: 20.0.w, right: 20.w, top: 50.h, bottom: 30.h),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "welcome".tr(),
                        style: TextStyles.size14FontWidgetBoldBlackWithOpacity6),
                      Text(
                        "عبد الرحمن محمد",
                        style: TextStyles.size16FontWidgetRegularGrayLight
                      ),
                    ],
                  )
                ],
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.notificationRoute);
                  },
                  child: SvgPicture.asset(ImageAssets.notificationIcon)),
            ],
          ),
        ))
      ],
    );
  }
}
