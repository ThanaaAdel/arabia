import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';

class HourlyContractsCard extends StatelessWidget {
  const HourlyContractsCard({
    super.key,
    this.onTap,
  });
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                      ImageAssets.contractMonthIcon,
                      width: 20.sp,
                      height: 20.sp,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  'طلب 1',
                  style: TextStyle(fontSize: 18.sp),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.orange,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
