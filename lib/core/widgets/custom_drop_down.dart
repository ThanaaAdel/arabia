import 'package:arabia/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/style_text.dart';

class CustomDropdownWidget extends StatelessWidget {
  final String label;
  final List<String> items;
  final Function(String?) onChanged;

  const CustomDropdownWidget({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: AppColors.baseGrayColor, // Background color for the dropdown
        borderRadius: BorderRadius.circular(8.0.sp),
      ),
      child: DropdownButtonFormField<String>(

        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.blue.withOpacity(0.33)), // Slightly darker border color when focused
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.blue.withOpacity(0.33)), // Slightly darker border color when focused

          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.blue.withOpacity(0.33)), // Slightly darker border color when focused
          ),
          hintText: label,
          contentPadding: EdgeInsets.only(bottom: 10.h),
          hintStyle: TextStyles.size16FontWidgetRegularGrayLight,

          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              color:AppColors.black.withOpacity(0.5)),
        ),
        icon:  Icon(
          Icons.arrow_drop_down,
          color: AppColors.orange,
          size: 25.sp,
        ),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(fontSize: 14.sp),
            ),
          );
        }).toList(),
        dropdownColor: AppColors.white,
        elevation: 1,
        borderRadius: BorderRadius.circular(8.sp),
        menuMaxHeight: 100.sp,
        autofocus:  true,
        enableFeedback: false,
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select $label';
          }
          return null;
        },
      ),
    );
  }
}
