import 'package:arabia/core/utils/style_text.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/utils/app_colors.dart';

class FollowUpOnOrdersCard extends StatelessWidget {
  const FollowUpOnOrdersCard({
    super.key,
    this.onTap, required this.title,  required this.image,
  });
  final Function()? onTap;
  final String title ;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(8.0.sp),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60.h,
          margin: EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.h),
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          decoration: BoxDecoration(
              color: AppColors.baseGrayColor,
            borderRadius: BorderRadius.circular(8.sp),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 40.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.white),
                    child: Center(
                      child: SvgPicture.asset(
                       image,
                        width: 20.sp,
                        height: 20.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  AutoSizeText(
                    title,
                    style:
                        TextStyles.size16FontWidgetBoldBlackWithOpacity6
                  ),
                ],
              ),

              Row(
                children: [
                  // Container(
                  //   width : 18.w,
                  //   height: 18.h,
                  //   decoration:  const BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       color: Colors.green),
                  //   child: Center(child: Text(number.toString(),
                  //     style: TextStyle(color: AppColors.white,fontSize: 16.sp),)),
                  // ),
                  SizedBox(width: 10.w,),
                  Center(
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.orange,
                      size: 22.sp,
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
