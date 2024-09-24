
import 'package:arabia/features/insert_contract_houres_screen/widgets/custom_expanded_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/models/login_with_client_id_model.dart';
import '../../core/widgets/appbar_widget_with_screens.dart';

class InsertContractHourScreen extends StatelessWidget {
  const InsertContractHourScreen({super.key, required this.loginWithClientIdModel});
  final LoginWithClientIdModel loginWithClientIdModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            AppbarWidgetWithScreens(
              title: "contract_hours".tr(),
              description: "please_select_a_profession_and_package".tr(),
            ),
            SizedBox(height: 20.h),
             Expanded(child: CustomExpandableWidget(
               loginWithClientIdModel: loginWithClientIdModel,)),
          ],
        ),
      ),
    );
  }
}


