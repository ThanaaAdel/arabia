import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/font_weight_helper.dart';
import '../utils/style_text.dart';

class SharedTextFiled extends StatelessWidget {
    SharedTextFiled({super.key,this.enableOrNot,this.onChanged, required this.hintText, required this.onSaved,this.maxLines, this.suffixIcon, this.controller,this.inputFormatters});
final String hintText;
final Function(String?) onSaved;
final Widget? suffixIcon;
 final TextEditingController? controller;
  int? maxLines ;
    bool? enableOrNot ;
    Function(String)? onChanged;
    List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: maxLines == null ? 48.h : 240.h,
      width: double.infinity,
      decoration: BoxDecoration(

          color:AppColors.baseGrayColor,
          borderRadius: BorderRadius.circular(7.sp)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),


        child: TextFormField(
          onChanged: onChanged,
          inputFormatters:  inputFormatters,
          enabled: enableOrNot ?? true,
          controller: controller,
          maxLines: maxLines ?? 1,
          style:TextStyles.size14FontWidget400Black,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
            hintStyle: TextStyles.size16FontWidgetRegularGrayLight,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color:AppColors.blue.withOpacity(0.33)), // Lighter border color when not focused
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color:AppColors.blue.withOpacity(0.33)), // Slightly darker border color when focused
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $hintText';
            }
            return null;
          },
          onSaved: onSaved,
        ),

      ),
    );

  }
}
