import 'package:arabia/core/models/get_hourly__package_model.dart';
import 'package:arabia/core/models/occupation_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';

class NationalityDropdownWidget extends StatefulWidget {
  final List<AvailableCountry> countries;
  final Function(String?) onChanged;

  const NationalityDropdownWidget({required this.countries, required this.onChanged});

  @override
  _NationalityDropdownWidgetState createState() => _NationalityDropdownWidgetState();
}

class _NationalityDropdownWidgetState extends State<NationalityDropdownWidget> {
  String? selectedNationality;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0.sp,vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.blue.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8.0.sp),
      ),
      child: DropdownButton<String>(
        value: selectedNationality ,
        isExpanded: true,
        icon: Icon(Icons.arrow_drop_down, color: AppColors.orange),
        iconSize: 24.sp,
        hint: Text( "nationality".tr()),
        elevation: 16,
        style: TextStyle(color: AppColors.black, fontSize: 16.sp),
        underline: Container(),
        onChanged: (String? newValue) {
          setState(() {
            selectedNationality = newValue;
          });
          widget.onChanged(newValue);
        },
        items: widget.countries.map<DropdownMenuItem<String>>((AvailableCountry country) {
          return DropdownMenuItem<String>(
            value: country.name,
            child: Text(country.name ?? 'Unknown Country'),
          );
        }).toList(),
      ),
    );
  }
}
