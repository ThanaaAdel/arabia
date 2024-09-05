import 'package:arabia/core/utils/style_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';

class ComplaintCard extends StatelessWidget {
  final bool status;

  const ComplaintCard({
    super.key,
    required this.status,
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
                      ImageAssets.complaintIcon,
                      width: 20.sp,
                      height: 20.sp,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  'شكوي 1',
                  style: TextStyles.size16FontWidgetBoldBlackWithOpacity6
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "11/4/2024",
                  style: TextStyles.size11FontWidgetSemiBoldBlackWithOpacity4
                ),
                status
                    ? Container(
                  child: status
                      ? Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.green),
                    height: 10.h,
                    width: 10.w,
                  )
                      : Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.red),
                    height: 10,
                    width: 10,
                  ),
                )
                    : const SizedBox(),
              ],
            )
          ],
        ),
      ),
    );
  }
}