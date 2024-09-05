import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/app_colors.dart';
import '../utils/assets_manager.dart';
import '../utils/style_text.dart';

class SharedAppbar extends StatelessWidget {
  const SharedAppbar({super.key, required this.text});
final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child:Directionality.of(context) == TextDirection.rtl ?
          SvgPicture.asset(
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
        SizedBox(width: 10.w),
        Padding(
          padding:  EdgeInsets.only(bottom: 5.h),
          child: Text(
            text,
            style:TextStyles.size22FontWidgetBoldBlue
          ),
        ),
      ],
    );
  }
}
