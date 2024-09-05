import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';

class ContractCard extends StatelessWidget {
  final bool status;

  const ContractCard({
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
        height: 80.h,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 40.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.white),
                  child: Center(
                    child: SvgPicture.asset(
                      ImageAssets.contractsIcon,
                      width: 20.sp,
                      height: 20.sp,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                SizedBox(
                  width: 180.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        'عقد 1',
                        style:
                            TextStyle(color: AppColors.black.withOpacity(0.6)),
                      ),
                      AutoSizeText(
                        'هذا النص هو مثال لنص يمكن أن يستبدل في في نفس المساحة',
                        maxLines: 2,
                        style:
                            TextStyle(color: AppColors.black.withOpacity(0.5)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 23.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.sp),
                        color: AppColors.blue),
                    child: Center(
                      child: Icon(
                        Icons.file_upload_outlined,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  status
                      ? Container(
                          child: status
                              ? Container(
                                  height: 23.h,
                                  width: 60.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.sp),
                                      color: AppColors.orange),
                                  child: Center(
                                    child: Text(
                                      "ارشيف",
                                      style: TextStyle(color: AppColors.white),
                                    ),
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.red),
                                  height: 10,
                                  width: 10,
                                ),
                        )
                      : const SizedBox(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
