import 'package:arabia/core/utils/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/style_text.dart';
import '../../../core/widgets/shared_appbar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      backgroundColor: AppColors.white,
        body: Column(
          children: [
            Padding(
              padding:  EdgeInsets.all(20.0.sp),
              child: SharedAppbar(text: "notification".tr()),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0.w),
                child: ListView.builder(
                  itemCount: 5, // Replace with your actual item count
                  itemBuilder: (context, index) {
                    return _buildCustomListItem(index == 0);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomListItem(bool isHighlighted) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color:  AppColors.blue.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: ListTile(
        leading: Container(
          height: 35.h,
          width: 35.w,
          decoration: BoxDecoration(color: AppColors.white,shape: BoxShape.circle),
          child: Icon(
            Icons.notifications, // Replace with the actual icon or image asset
            color: AppColors.orange,
          ),),
        title: Text(
          'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة. لقد تم توليد هذا النص', // Replace with dynamic text if needed
          style: TextStyles.size13FontWidgetSemiBoldBlackWithOpacity6
        ),

        subtitle: Padding(
          padding:  EdgeInsets.only(top: 5.0.h),
          child: Text(
            '11/4/2024',
            style: TextStyles.size11FontWidgetSemiBoldBlackWithOpacity4
          ),
        ),
      ),
    );
  }
}


