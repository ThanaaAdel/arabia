import 'package:arabia/core/utils/app_colors.dart';
import 'package:arabia/features/home_screen/screens/widgets/custom_list_view.dart';
import 'package:arabia/features/home_screen/screens/widgets/appbar_home_screen.dart';
import 'package:arabia/features/home_screen/screens/widgets/services_widget.dart';
import 'package:arabia/features/home_screen/screens/widgets/visit_offer_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/style_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const AppbarHomeScreen(),
          const VisitsOffersWidget(),
          SizedBox(
            height: 5.h,
          ),
          const ServicesWidget(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
                child: AutoSizeText("administrative_services".tr(),
                    style: TextStyles.size20FontWidgetBoldOrange),
              ),
            ],
          ),
          const Flexible(child: CustomListView())
        ],
      ),
    );
  }
}
