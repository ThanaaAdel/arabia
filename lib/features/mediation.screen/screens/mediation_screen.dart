import 'package:arabia/core/utils/app_colors.dart';
import 'package:arabia/core/widgets/button_widget.dart';
import 'package:arabia/core/widgets/shared_text_filed.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/widgets/appbar_widget_with_screens.dart';
import '../../../core/widgets/custom_drop_down.dart';

class MediationScreen extends StatefulWidget {
  const MediationScreen({super.key});

  @override
  State<MediationScreen> createState() => _MediationScreenState();
}

class _MediationScreenState extends State<MediationScreen> {
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
              title: "mediation".tr(),
              description: "please_enter_the_following_information".tr(),
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomDropdownWidget(
              label:  "jop".tr(),
              onChanged: (p0) {},
              items: const ["سباك", "حلاق"],
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomDropdownWidget(
              label: "nationality".tr(),
              onChanged: (p0) {},
              items: const ["السعودية", "  مصر", "  البحرين"],
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomDropdownWidget(
              label: "employment_entity".tr(),
              onChanged: (p0) {},
              items: const ["مسلم", "  مسيحي"],
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomDropdownWidget(
              label: "experience".tr(),
              onChanged: (p0) {},
              items: const ["1", "  2"],
            ),
            SizedBox(
              height: 20.h,
            ),
            SharedTextFiled(
              hintText: "visa_number".tr(),
              onSaved: (p0) {},
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
