import 'package:arabia/core/utils/assets_manager.dart';
import 'package:arabia/features/contract_month_screen/widgets/choose_package_from_contract_month.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/style_text.dart';
import '../../core/widgets/appbar_widget_with_screens.dart';

class ContractMonthScreen extends StatelessWidget {
  const ContractMonthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AppbarWidgetWithScreens(
            title: "contract_month".tr(),
            description: "text_contract_month_screen".tr(),
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
        color: AppColors.blue.withOpacity(0.08),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ExpansionTile(
          leading: Container(
              height: 25.h,
              width: 25.w,
              decoration:
                  BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
              child: SvgPicture.asset(
                ImageAssets.settingsIcon,
                height: 15.h,
                width: 15.w,
              )), // Adjust icon as needed
          title: Text(
            'المهمة 1',
            style: TextStyles.size16FontWidgetBoldBlackWithOpacity6
          ),
          trailing: Icon(
            Icons.expand_more,
            color: Colors.orange,
            size: 25.sp,
          ),
          children: <Widget>[
            SizedBox(height: 5.h,),
            Divider(color: AppColors.blue.withOpacity(0.1),
              indent: 20.w,
              endIndent: 20.w,
              thickness: 1,),
            SizedBox(height: 10.h,),
            _buildOptionButton('باقة 1', context),
            _buildOptionButton('باقة 2', context),
            _buildOptionButton('باقة 3', context),
            SizedBox(height: 10.h,),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(String text, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 3.0.h),
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
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const ChoosePackageFromContractMonthScreen(),
                ));
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
