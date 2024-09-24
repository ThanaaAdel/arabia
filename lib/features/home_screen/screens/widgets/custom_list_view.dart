import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/style_text.dart';
import '../../../track_orders_screen/track_orders_screen.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        _buildListTile(
          "follow_my_orders".tr(),
          ImageAssets.followUpOnOrdersIcon,
          () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => const TrackOrdersScreen(),));
          },
        ),
        _buildListTile(
          "contracts".tr(),
          ImageAssets.contractsIcon,
          () {
            Navigator.pushNamed(context, Routes.contractsRoute);
          },
        ),
        _buildListTile(
          "offers".tr(),
          ImageAssets.offerIcon,
          () {
            Navigator.pushNamed(context, Routes.offersRoute);
          },
        ),
        _buildListTile(
          "complaints".tr(),
          ImageAssets.complaintIcon,
          () {
            Navigator.pushNamed(context, Routes.complaintsRoute);
          },
        ),
        _buildListTile(
          "list".tr(),
          ImageAssets.listIcon,
          () {
            Navigator.pushNamed(context, Routes.settingRoute);
          },
        ),
      ],
    );
  }

  Widget _buildListTile(String title, String image, Function()? onTab) {
    return GestureDetector(
      onTap: onTab,
      child: Padding(
        padding: EdgeInsets.only(top:0,left: 10.w, right: 10.w, bottom: 5.h),
        child: Row(
          children: [
            SizedBox(
              width: 35.w,
              height: 35.h,
              child: SvgPicture.asset(
                image,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.sp),
                  color: AppColors.blue.withOpacity(0.08)),
              height: 45.h,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      title,
                      style: TextStyles.size16FontWidgetBoldBlackWithOpacity6
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: AppColors.orange,
                      size: 25.sp,
                    ),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
