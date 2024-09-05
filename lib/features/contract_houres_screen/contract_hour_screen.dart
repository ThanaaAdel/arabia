import 'package:arabia/core/utils/assets_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../config/routes/app_routes.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/style_text.dart';
import '../../core/widgets/appbar_widget_with_screens.dart';

class ContractHourScreen extends StatelessWidget {
  const ContractHourScreen({super.key});

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
          SizedBox(
            height: 20.h,
          ),
          const CustomExpandableWidget()
        ],
      ),
    ));
  }
}

class CustomExpandableWidget extends StatelessWidget {
  const CustomExpandableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 4.0.h),
      child: Card(
        clipBehavior: Clip.antiAlias,
        borderOnForeground: false,
        shadowColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        semanticContainer: true,
        color: AppColors.blue.withOpacity(0.08),
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.circular(8.0.sp),
        ),
        child: ExpansionTile(

          leading: Container(
              height: 25.h,
              width: 25.w,
              decoration:
                  BoxDecoration(

                      color: AppColors.white,
                      shape: BoxShape.circle),
              child: SvgPicture.asset(
                ImageAssets.settingsIcon,
                height: 10.h,
                width: 10.w,
                fit: BoxFit.none,
              )), // Adjust icon as needed
          title: Text(
            'المهمة 1',
            style: TextStyles.size16FontWidgetBoldBlackWithOpacity6
          ),
          trailing: Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.orange,
            size: 25.sp,
          ),
          children: <Widget>[
            Divider(color: AppColors.blue.withOpacity(0.1),endIndent: 20.w,indent: 20.w,),
            SizedBox(height: 5.h,),
            _buildOptionButton('باقة 1',context),
            _buildOptionButton('باقة 2',context),
            _buildOptionButton('باقة 3',context),
            SizedBox(height: 15.h,),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(String text,BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 3.0.h),
      child: SizedBox(
        width: double.infinity,
        height: 30.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:AppColors.blue.withOpacity(0.9), // Button background color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0.sp), // Rounded corners
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, Routes.choosePackageFromContractHourRoute);

          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyles.size14FontWidgetRegularWhiteWithOpacity8
              ),
            ],
          ),
        ),
      ),
    );
  }
}
