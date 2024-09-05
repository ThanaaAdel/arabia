import 'package:arabia/core/utils/app_colors.dart';
import 'package:arabia/core/widgets/button_widget.dart';
import 'package:arabia/core/widgets/shared_text_filed.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/widgets/appbar_widget_with_screens.dart';
import '../../../core/widgets/custom_drop_down.dart';

class ChoosePackageFromContractMonthScreen extends StatefulWidget {
  const ChoosePackageFromContractMonthScreen({super.key});

  @override
  State<ChoosePackageFromContractMonthScreen> createState() => _ChoosePackageFromContractMonthScreenState();
}

class _ChoosePackageFromContractMonthScreenState extends State<ChoosePackageFromContractMonthScreen> {
  String? selectedTransferType = 'recovery';
  DateTime? selectedDate;
  List<DateTime> selectedDates = []; // List to hold multiple selected dates
  TextEditingController fromHourController = TextEditingController();
  TextEditingController toHourController = TextEditingController();

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
                title: "contract_month".tr(),
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

                    _buildDateFilter(context,"from_hour".tr(),fromHourController), // Date filter widget with calendar icon
                    SizedBox(height: 20.h,),
                    _buildDateFilter(context,"to_hour".tr(),toHourController), // Date filter widget with calendar icon
                    SizedBox(height: 20.h,),
                    SharedTextFiled(hintText: "number_of_workers".tr(), onSaved: (p0) {},),
                    SizedBox(height: 20.h,),

                    CustomDropdownWidget(
                      label: "nationality".tr(),
                      onChanged: (p0) {},
                      items: const ["عربي", "مصري", "سعودي"],
                    ),
                    SizedBox(height: 20.h,),
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
                          SizedBox(height: 20.h,),
                          Text("add_service_transfer".tr(), style: TextStyle(fontSize: 16.sp),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Radio(
                                    value: 'yes',
                                    groupValue: selectedTransferType,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTransferType = value.toString();
                                      });
                                    },
                                    activeColor: Colors.blue,
                                  ),
                                  Text(
                                    'yes'.tr(),
                                    style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: 'no',
                                    groupValue: selectedTransferType,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTransferType = value.toString();
                                      });
                                    },
                                    activeColor: Colors.blue,
                                  ),
                                  Text(
                                    'no'.tr(),
                                    style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("total_cost".tr(), style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.black.withOpacity(0.6)),),
                        SizedBox(width: 10.w,),
                        Text("100 ${"currency".tr()}", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.black.withOpacity(0.6)),),
                      ],
                    ),
                    SizedBox(height: 20.h,),
                    ButtonWidget(textButton: "order_now".tr(), onPressed: () {
                   //   Navigator.pushNamed(context, Routes.totalDataFromHourContactRoute);
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

  Widget _buildDateFilter(BuildContext context, String hintText,TextEditingController controller) {
    return SharedTextFiled(
      controller: controller, // Assign the controller to manage the text field
      suffixIcon: GestureDetector(
        onTap: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: selectedDate ?? DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2025),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme:  ColorScheme.light(
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
              selectedDate = picked;
              selectedDates.add(picked);
              controller.text = "${picked.toLocal()}".split(' ')[0]; // Update controller with the selected date
            });
          }
        },
        child: Icon(Icons.calendar_month, color: AppColors.orange),
      ),
      hintText: hintText, // Use the hint text provided
      onSaved: (p0) {},
    );
  }
}
