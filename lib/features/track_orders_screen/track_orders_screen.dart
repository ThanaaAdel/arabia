import 'package:arabia/core/widgets/shared_appbar.dart';
import 'package:arabia/features/track_orders_screen/widgets/track_orders_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/routes/app_routes.dart';
import '../../core/utils/assets_manager.dart';

class TrackOrdersScreen extends StatefulWidget {
  const TrackOrdersScreen({super.key});

  @override
  State<TrackOrdersScreen> createState() => _TrackOrdersScreenState();
}

class _TrackOrdersScreenState extends State<TrackOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.sp),
              child: SharedAppbar(text: "follow_my_orders".tr()),
            ),
            SizedBox(
              height: 20.h,
            ),
            TrackOrdersCard(
              onTap: () {
                Navigator.pushNamed(context, Routes.hourlyContractsRoute);
              },
              image: ImageAssets.contractHourIcon,
              title: "hourly_contracts".tr(),

            ),
            TrackOrdersCard(
              onTap: () {
                Navigator.pushNamed(context, Routes.monthlyContractsRoute);
              },
              image: ImageAssets.contractMonthIcon,
              title: "monthly_contracts".tr(),

            ),
            TrackOrdersCard(
              onTap: () {
                Navigator.pushNamed(context, Routes.mediationContractsRoute);
              },
              image: ImageAssets.mediationServiceIcon,
              title: "mediation".tr(),
            ),
            TrackOrdersCard(
              onTap: () {
                Navigator.pushNamed(context, Routes.professionalEmploymentRoute);              },
              image: ImageAssets.professionalLaborIcon,
              title: "professional_labor".tr(),
            ),
            TrackOrdersCard(
              onTap: () {
               Navigator.pushNamed(context, Routes.transferServiceRoute);
              },
              image: ImageAssets.followUpOnOrdersIcon,
              title: "transfer_of_services".tr(),
            ),
          ],
        ),
      ),
    );
  }
}
