import 'package:arabia/core/utils/style_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/models/closed_complain_model.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../notification_screen/screens/notification_screen.dart';

class CloseCard extends StatelessWidget {

 final  ComplaintBasicInfo complaintBasicInfo;
  const CloseCard({
    super.key,

    this.onTap, required this.complaintBasicInfo,
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
                    complaintBasicInfo.complainantName.toString() ,
                  style: TextStyles.size16FontWidgetBoldBlackWithOpacity6
                ),
              ],
            ),
            (complaintBasicInfo.close == false)?
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(formatDate(complaintBasicInfo.dateOfComplaint.toString())
                  ,style: TextStyles.size11FontWidgetSemiBoldBlackWithOpacity4.copyWith( color: const Color(0xff35DE5C)),)
                ,Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xff35DE5C)),
                  height: 10.h,
                  width: 10.w,
                ),
              ],
            ):
            Text(formatDate(complaintBasicInfo.dateOfComplaint.toString())
              ,style: TextStyles.size11FontWidgetSemiBoldBlackWithOpacity4,)
            ,
          ],
        ),
      ),
    );
  }
}