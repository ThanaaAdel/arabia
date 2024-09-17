import 'package:arabia/core/utils/style_text.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/models/opening_complain_model.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';

class OpenCard extends StatelessWidget {
  final ComplaintBasicInfo complaintBasicInfo;
  const OpenCard({
    super.key,
    this.onTap,
    required this.complaintBasicInfo,
  });
  final Function()? onTap;
  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                Row(
                  children: [
                    Container(
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
                  ],
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            maxLines: 1,
                            complaintBasicInfo.complaintNumber.toString(),
                            overflow: TextOverflow.ellipsis,
                          ),
                          AutoSizeText(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            complaintBasicInfo.textOfComplaint.toString(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            (complaintBasicInfo.close == false)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        formatDate(
                            complaintBasicInfo.dateOfComplaint.toString()),
                        style: TextStyles
                            .size11FontWidgetSemiBoldBlackWithOpacity4
                            .copyWith(color: const Color(0xff35DE5C)),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xff35DE5C)),
                        height: 10.h,
                        width: 10.w,
                      ),
                    ],
                  )
                : Text(
                    formatDate(complaintBasicInfo.dateOfComplaint.toString()),
                    style: TextStyles.size11FontWidgetSemiBoldBlackWithOpacity4,
                  ),
          ],
        ),
      ),
    );
  }
}
