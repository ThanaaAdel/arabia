import 'package:arabia/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/style_text.dart';

class CustomDropdownWidget extends StatefulWidget {
  final String label;
  final List<dynamic> items; // Ensure this is a list of strings.
  final Function(String?) onChanged;

  const CustomDropdownWidget({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
  });

  @override
  _CustomDropdownWidgetState createState() => _CustomDropdownWidgetState();
}

class _CustomDropdownWidgetState extends State<CustomDropdownWidget> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    // Set the initial selected value to null or the first item in the list.
    selectedValue = null;
  }

  @override
  Widget build(BuildContext context) {
    // Ensure unique items in the dropdown
    List<dynamic> uniqueItems = widget.items.toSet().toList();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: AppColors.baseGrayColor, // Background color for the dropdown
        borderRadius: BorderRadius.circular(8.0.sp),
      ),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.blue.withOpacity(0.33)),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.blue.withOpacity(0.33)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.blue.withOpacity(0.33)),
          ),
          hintText: widget.label,
          contentPadding: EdgeInsets.only(bottom: 10.h),
          hintStyle: TextStyles.size16FontWidgetRegularGrayLight,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
            color: AppColors.black,
          ),
        ),
        icon: Icon(
          Icons.arrow_drop_down,
          color: AppColors.orange,
          size: 25.sp,
        ),
        items: uniqueItems.map((dynamic value) {
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
        autofocus: true,
        enableFeedback: false,
        onChanged: (newValue) {
          setState(() {
            selectedValue = newValue;
          });
          widget.onChanged(newValue);
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select ${widget.label}';
          }
          return null;
        },
      ),
    );
  }
}
