import 'package:arabia/core/widgets/shared_appbar.dart';
import 'package:arabia/features/follow_up_on_orders_screen/widgets/follow_up_on_orders_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/routes/app_routes.dart';
import '../../core/utils/assets_manager.dart';
import 'cubit/cubit.dart';

class FollowUpOnOrdersScreen extends StatefulWidget {
  const FollowUpOnOrdersScreen({super.key});

  @override
  State<FollowUpOnOrdersScreen> createState() => _FollowUpOnOrdersScreenState();
}

class _FollowUpOnOrdersScreenState extends State<FollowUpOnOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<FollowUpOnOrdersCubit>();
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
            FollowUpOnOrdersCard(
              onTap: () {
                Navigator.pushNamed(context, Routes.hourlyContractsRoute);
              },
              image: ImageAssets.contractHourIcon,
              title: "hourly_contracts".tr(),
              number: 1,
            ),
            FollowUpOnOrdersCard(
              onTap: () {
                Navigator.pushNamed(context, Routes.contractMonthRoute);
              },
              image: ImageAssets.contractMonthIcon,
              title: "monthly_contracts".tr(),
              number: 6,
            ),
            FollowUpOnOrdersCard(
              onTap: () {
                Navigator.pushNamed(context, Routes.mediationRoute);
              },
              image: ImageAssets.mediationServiceIcon,
              title: "mediation".tr(),
              number: 5,
            ),
            FollowUpOnOrdersCard(
              onTap: () {
                Navigator.pushNamed(context, Routes.professionalEmploymentRoute);              },
              image: ImageAssets.professionalLaborIcon,
              title: "professional_labor".tr(),
              number: 4,
            ),
            FollowUpOnOrdersCard(
              onTap: () {
                Navigator.pushNamed(context, Routes.serviceMoveRoute);
              },
              image: ImageAssets.followUpOnOrdersIcon,
              title: "transfer_of_services".tr(),
              number: 2,
            ),
          ],
        ),
      ),
    );
  }
}
