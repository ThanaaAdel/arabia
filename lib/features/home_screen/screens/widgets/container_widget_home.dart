
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/style_text.dart';

class ContainerWidgetHome extends StatelessWidget {
  const ContainerWidgetHome({
    super.key, required this.text, required this.image, this.onPressed,
  });
  final String text,image;

final  Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Padding(
            padding:  EdgeInsets.only(top: 5.h,left: 10.w,right: 10.w,bottom: 5.h),
            child: Container(
              width: 140.w,height: 84.h,
              decoration: BoxDecoration(
                  color: AppColors.baseGrayColor,
                  borderRadius: BorderRadius.circular(8.sp)),
              child: Center(child: SvgPicture.asset(image,height: 42.h,width: 40.w,),),
            ),
          ),
            AutoSizeText(
            maxLines: 1,
            text,style:TextStyles.size14FontWidgetBoldBlackWithOpacity6)
        ],),
      ),
    );
  }
}