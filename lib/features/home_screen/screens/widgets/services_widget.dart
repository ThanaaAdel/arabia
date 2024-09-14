import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/style_text.dart';
import 'container_widget_home.dart';

class ServicesWidget extends StatelessWidget {
  const ServicesWidget({
    super.key, required this.clientId,
  });
final String clientId;
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:  EdgeInsets.only(left: 20.w,right: 20.w),
          child: Text("services".tr(),style: TextStyles.size20FontWidgetBoldOrange),
        ),
         Row(
          children: [
            ContainerWidgetHome(
              onPressed: () {
                Navigator.pushNamed(context, Routes.mediationRoute);
              },
              text: "mediation_service".tr(),image: ImageAssets.mediationServiceIcon,),
            ContainerWidgetHome(
              onPressed: () {
                Navigator.pushNamed(context, Routes.professionalEmploymentRoute,arguments: clientId);
              },
              text: "professional_employment".tr(),image: ImageAssets.professionalLaborIcon,),
            ContainerWidgetHome(
              onPressed: () {
                Navigator.pushNamed(context, Routes.serviceMoveRoute,arguments: clientId);
              },
              text: "move_service".tr(),image: ImageAssets.requestForServiceTransferIcon,),

          ],
        )

      ],);
  }
}