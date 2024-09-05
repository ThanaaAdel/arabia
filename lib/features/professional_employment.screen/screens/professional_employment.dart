import 'package:arabia/core/utils/app_colors.dart';
import 'package:arabia/features/professional_employment.screen/screens/widgets/profictionail_employee_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/widgets/appbar_widget_with_screens.dart';
import '../../contract_houres_screen/contract_hour_screen.dart';

class ProfessionalEmploymentScreen extends StatelessWidget {
  const ProfessionalEmploymentScreen({super.key});

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
              title: "professional_employment".tr(),
              description: "please_select_a_profession".tr(),
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: ListView.builder(
                        itemBuilder: (context, index) =>
                         ProfessionalEmploymentContainer(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.enterDataProfessionalEmploymentRoute);
                          },
                        ),
                        itemCount: 5,
              ),
            )

          ],
        ),
      ),
    ));
  }


}
