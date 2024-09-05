import 'package:arabia/core/utils/app_colors.dart';
import 'package:arabia/core/widgets/button_widget.dart';
import 'package:arabia/core/widgets/shared_text_filed.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/style_text.dart';
import '../../../core/widgets/appbar_widget_with_screens.dart';
import '../../../core/widgets/custom_drop_down.dart';

class ChoosePackageFromContractHourScreen extends StatefulWidget {
  const ChoosePackageFromContractHourScreen({super.key});

  @override
  State<ChoosePackageFromContractHourScreen> createState() =>
      _ChoosePackageFromContractHourScreenState();
}

class _ChoosePackageFromContractHourScreenState
    extends State<ChoosePackageFromContractHourScreen> {
  String? selectedTransferType = 'recovery';
  DateTime? selectedDate;
  List<DateTime> selectedDates = []; // List to hold multiple selected dates

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0.sp),
              child: AppbarWidgetWithScreens(
                title: "contract_hours".tr(),
                description: 'details'.tr(),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10.0.sp),
                child: ListView(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    Container(
                      height: 80.h,
                      padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                      decoration: BoxDecoration(
                        color: AppColors.blue.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(8.0.sp),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            "service_time".tr(),
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Radio(
                                    value: 'خدمة صباحية',
                                    groupValue: selectedTransferType,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTransferType = value.toString();
                                      });
                                    },
                                    activeColor: Colors.blue,
                                  ),
                                  Text(
                                   "morning_service".tr(),
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: 'خدمة مسائية',
                                    groupValue: selectedTransferType,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTransferType = value.toString();
                                      });
                                    },
                                    activeColor: Colors.blue,
                                  ),
                                  Text(
                                    "night_service".tr(),
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SharedTextFiled(
                        hintText: "from_hour".tr(), onSaved: (p0) {}),
                    SizedBox(
                      height: 10.h,
                    ),
                    SharedTextFiled(hintText: "to_hour".tr(), onSaved: (p0) {}),
                    SizedBox(
                      height: 10.h,
                    ),
                    SharedTextFiled(
                      hintText: "number_of_workers".tr(),
                      onSaved: (p0) {},
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    _buildDateFilter(
                        context), // Date filter widget with calendar icon
                    if (selectedDates
                        .isNotEmpty) // Show selected dates if there are any
                      Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: Wrap(
                          spacing: 8.0, // Spacing between the chips
                          children: selectedDates.map((date) {
                            return Chip(
                              label: Text(
                                "${date.toLocal()}"
                                    .split(' ')[0], // Display date without time
                                style: TextStyle(fontSize: 14.sp),
                              ),
                              deleteIcon: Icon(Icons.close,
                                  color: Colors.red, size: 18.sp),
                              onDeleted: () {
                                setState(() {
                                  selectedDates.remove(
                                      date); // Remove the date on chip deletion
                                });
                              },
                              backgroundColor: Colors.red
                                  .withOpacity(0.08), // Chip background color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.sp),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomDropdownWidget(
                      label: "nationality".tr(),
                      onChanged: (p0) {},
                      items: const ["عربي", "مصري", "سعودي"],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding:  EdgeInsets.all(8.0.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "total_cost".tr(),
                            style: TextStyles.size16FontWidgetBoldBlackWithOpacity6
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "100 ${"currency".tr()}",
                              style: TextStyles.size16FontWidgetBoldBlackWithOpacity6
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ButtonWidget(
                        textButton: "order_now".tr(),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, Routes.totalDataFromHourContactRoute);
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateFilter(BuildContext context) {
    return SharedTextFiled(
      suffixIcon: GestureDetector(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDatePickerMode: DatePickerMode.day,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2025),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      secondary: AppColors.primary,

                      background: AppColors.blue,
                      primary: AppColors.blue, // header background color
                      onPrimary: AppColors.white, // header text color
                      onSurface: AppColors.black, // body text color
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.blue, // button text color
                      ),
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (picked != null && !selectedDates.contains(picked)) {
              setState(() {
                selectedDates.add(picked); // Add selected date to the list
              });
            }
          },
          child: Icon(
            Icons.calendar_month,
            color: AppColors.orange,
          )),
      hintText: "service_days".tr(),
      onSaved: (p0) {},
    );
  }
}
