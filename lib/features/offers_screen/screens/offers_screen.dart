import 'package:arabia/core/utils/app_colors.dart';
import 'package:arabia/core/widgets/shared_appbar.dart';
import 'package:arabia/features/offers_screen/screens/widget/custom_offer_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/routes/app_routes.dart';

class OfferScreen extends StatelessWidget {
  const OfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.white,
      body: Column(children: [
        Padding(
          padding:  EdgeInsets.all(8.0.sp),
          child: SharedAppbar(text: "offers".tr()),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) => CustomOfferContainer(
            onTap: () {
              Navigator.pushNamed(context, Routes.offerDetailsRoute);
            },
          ))
      ],),
    ));
  }
}

