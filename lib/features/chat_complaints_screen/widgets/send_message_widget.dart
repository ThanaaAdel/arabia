import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';

class SendMessageWidget extends StatelessWidget {
  const SendMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 50.0.h, // Adjust the height as needed
      padding: EdgeInsets.symmetric(horizontal: 8.0.sp),
      decoration: BoxDecoration(
        color: AppColors.blue
            .withOpacity(0.08), // Background color of the bar
        borderRadius: BorderRadius.circular(12.0.sp), // Rounded corners
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextFormField(
              maxLines: 1,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderSide: BorderSide.none),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      ImageAssets.sendChatIcon,
                      width: 20.sp,
                      height: 20.sp,
                      color: const Color(0xffE44200),
                    ),
                  )),
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          SvgPicture.asset(ImageAssets.uploadChatIcon),
        ],
      ),
    );
  }
}
