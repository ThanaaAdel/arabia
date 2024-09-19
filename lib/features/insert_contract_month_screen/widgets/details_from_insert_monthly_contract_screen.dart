import 'package:arabia/core/models/insert_monthly_data_model.dart';
import 'package:arabia/core/utils/app_colors.dart';
import 'package:arabia/core/utils/assets_manager.dart';
import 'package:arabia/core/widgets/button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/utils/style_text.dart';

class DetailsFromMonthlyContractScreen extends StatelessWidget {
  const DetailsFromMonthlyContractScreen(
      {super.key, required this.insertMonthlyDataModel});
  final InsertMonthlyDataModel insertMonthlyDataModel;

  @override
  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(20.0.sp),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "contract_month".tr(),
                        style: TextStyles.size22FontWidgetBoldBlue.copyWith(fontSize: 20.sp)
                    ),

                    SizedBox(

                      child: Text(
                        'details'.tr(),
                        style: TextStyles.size13FontWidgetSemiBoldBlackWithOpacity6.copyWith(fontSize: 10.sp),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                // child: AppbarWidgetWithScreens(
                //   title: "contract_hours".tr(),
                //   description: 'details'.tr(),
                // ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 55.h,
                      margin: EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.h),
                      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
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
                                insertMonthlyDataModel
                                    .data?.monthlyRentalMobilePackage?.name
                                    .toString() ??
                                    '',
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
                            insertMonthlyDataModel.data?.id.toString() ?? '',
                          ),
                          // _buildDetailRow(
                          //   context,
                          //   "date".tr(),
                          //   formatDate(insertMonthlyDataModel.data?..toString() ?? ''),
                          // ),
                         
                          _buildDetailRow(
                            context,
                            "from_date".tr(),
                            formatDate(insertMonthlyDataModel.data?.serviceDateFrom.toString() ??
                                ''),
                          ),
                          _buildDetailRow(
                            context,
                            "to_date".tr(),
                            formatDate(insertMonthlyDataModel.data?.serviceDateTo.toString() ?? ''),
                          ),
                          _buildDetailRow(
                            context,
                            "nationality".tr(),
                            insertMonthlyDataModel.data?.country?.name.toString() ?? '',
                          ),
                          _buildDetailRow(
                            context,
                            "occupation".tr(),
                            insertMonthlyDataModel.data?.occupation?.name.toString() ??
                                '',
                          ),
                          _buildDetailRow(
                            context,
                            "total_cost".tr(),
                            insertMonthlyDataModel.data?.costIncludeTax.toString() ??
                                '',
                          ),
                          _buildDetailRow(
                            context,
                            "order_status".tr(),
                            insertMonthlyDataModel.data?.statusDisplay?.title?.toString() ??
                                '',
                          ),
                       
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    ButtonWidget(
                      textButton: "go_to_home_page".tr(),
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.homeRoute);
                      },
                    ),
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
