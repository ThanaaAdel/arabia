import 'package:arabia/core/utils/app_colors.dart';
import 'package:arabia/core/widgets/button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/style_text.dart';
import '../../../core/widgets/appbar_widget_with_screens.dart';
import '../../../core/widgets/custom_drop_down.dart';

class ServiceMoveScreen extends StatefulWidget {
  const ServiceMoveScreen({super.key});

  @override
  State<ServiceMoveScreen> createState() => _ServiceMoveScreenState();
}

class _ServiceMoveScreenState extends State<ServiceMoveScreen> {
  String? selectedTransferType = 'recovery';
 // Initial selected value
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.all(10.0.sp),
        child: Column(
          children: [
            AppbarWidgetWithScreens(
              title: "transfer_of_services".tr(),
              description: "please_enter_the_following_information".tr(),
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomDropdownWidget(
              label: "current_employment_entity".tr(),
              onChanged: (p0) {},
              items: const ["سباك", "حلاق"],
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomDropdownWidget(
              label: "current_employment_country".tr(),
              onChanged: (p0) {},
              items: const ["السعودية", "  مصر", "  البحرين"],
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomDropdownWidget(
              label: "current_employment_nationality".tr(),
              onChanged: (p0) {},
              items: const ["مسلم", "  مسيحي"],
            ),
            SizedBox(height: 20.h,),
            Container(
              height: 80.h,
              padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
              decoration: BoxDecoration(
                color: AppColors.blue.withOpacity(0.08), // Light blue background color
                borderRadius: BorderRadius.circular(8.0.sp), // Rounded corners
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h,),
                  Text("transfer_type".tr(),style: TextStyle(fontSize: 16.sp),),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 'recovery',
                            groupValue: selectedTransferType,
                            onChanged: (value) {
                              setState(() {
                                selectedTransferType = value.toString();
                              });
                            },
                            activeColor: Colors.blue, // Active color for the radio button
                          ),
                          Text(
                            'recovery'.tr(), // 'Recovery' in Arabic
                            style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'replacement_worker',
                            groupValue: selectedTransferType,
                            onChanged: (value) {
                              setState(() {
                                selectedTransferType = value.toString();
                              });
                            },
                            activeColor: Colors.blue, // Active color for the radio button
                          ),
                          Text(
                            'replacement_worker'.tr(), // 'Replacement Worker' in Arabic
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

            Padding(
              padding:  EdgeInsets.all(8.0.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("total_cost".tr(),
                  style: TextStyles.size16FontWidgetRegularBlackWithOpacity7),
                  SizedBox(width: 10.w,),
                  Text(" 100 ${"currency".tr()}",
                    style:  TextStyles.size16FontWidgetRegularBlackWithOpacity7),

              ],),
            ),
            Expanded(
              child: Container(),
            ),
            ButtonWidget(
              textButton: "order_now".tr(),
            ),
          ],
        ),
      ),
    ));
  }
}
