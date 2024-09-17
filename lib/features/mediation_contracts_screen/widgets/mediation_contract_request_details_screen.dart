import 'package:arabia/core/utils/app_colors.dart';
import 'package:arabia/core/utils/assets_manager.dart';
import 'package:arabia/core/widgets/button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/models/mediation_contract_model.dart';
import '../../../core/widgets/appbar_widget_with_screens.dart';

class MediationContractRequestDetailsScreen extends StatelessWidget {
  const MediationContractRequestDetailsScreen({super.key, required this.item, this.onPressed, required this.isArchive});
 final Item item;
 final Function()? onPressed;
  final bool isArchive;
  @override
  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

    return formattedDate;
  }
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: Column(
            children: [
              AppbarWidgetWithScreens(
                title: "details_order".tr(),
                description: "follow_the_order".tr(),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 55.h,
                      margin: EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.h),
                      padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: AppColors.baseGrayColor,
                        borderRadius: BorderRadius.circular(8.sp),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 40.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: AppColors.white),
                                child: Center(
                                  child: SvgPicture.asset(
                                    ImageAssets.contractMonthIcon,
                                    width: 20.sp,
                                    height: 20.sp,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                item.occupation?.name.toString() ?? '',
                                style: TextStyle(fontSize: 10.sp),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.h),
                      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: AppColors.baseGrayColor,
                        borderRadius: BorderRadius.circular(8.sp),
                      ),
                      child: Column(
                        children: [
                          _buildDetailRow(
                            context,
                            "order_number".tr(),
                            item.id.toString() ?? '',
                          ),
                          _buildDetailRow(
                            context,
                            "date".tr(),
                            formatDate(item.createdAt.toString() ?? ''),
                          ),


                          _buildDetailRow(
                            context,
                            "nationality".tr(),
                            item.country?.name.toString() ?? '',
                          ),
                          _buildDetailRow(
                            context,
                            "occupation".tr(),
                            item.occupation?.name.toString() ??
                                '',
                          ),
                          _buildDetailRow(
                            context,
                            "experience".tr(),
                            item.experience?.title.toString() ??
                                '',
                          ),
                          _buildDetailRow(
                            context,
                            "employment_entity".tr(),
                            item.religion?.title.toString() ??
                                '',
                          ),

                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(

                      ),
                    ),
                    isArchive == true?
                        const SizedBox():
                    ButtonWidget(textButton: "archiving".tr(), onPressed:onPressed),
                  ],
                ),
              )
            ],
          ),
        ));
  }
  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: AppColors.blue, fontSize: 14.sp),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: AppColors.black, fontSize: 14.sp),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
