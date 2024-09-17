import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/models/insert_hourly_data_model.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/dialogs.dart';
import '../../../core/utils/style_text.dart';
import '../../../core/widgets/button_widget.dart';
import 'details_from_insert_hourly_contract_screen.dart';

class TotalDataFromHourContactScreen extends StatefulWidget {
  const TotalDataFromHourContactScreen({super.key, required this.insertHourlyDataModel});
  final InsertHourlyDataModel insertHourlyDataModel;

  @override
  State<TotalDataFromHourContactScreen> createState() =>
      _TotalDataFromHourContactScreenState();
}

String formatTime(String time) {
  try {
    List<String> parts = time.split(':');
    int hour = int.parse(parts[0]);
    String minute = parts[1];
    String period = hour >= 12 ? 'م' : 'ص';
    hour = hour % 12;
    hour = hour == 0 ? 12 : hour;
    return '$hour:$minute $period';
  } catch (e) {
    return time;
  }
}

class _TotalDataFromHourContactScreenState extends State<TotalDataFromHourContactScreen> {
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(20.0.sp),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "contract_hours".tr(),
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
            Padding(
              padding: EdgeInsets.all(10.0.sp),
              child: ServiceSummaryWidget(
                orderNumber: widget.insertHourlyDataModel.data?.id.toString() ?? '',
                orderStatus: widget.insertHourlyDataModel.data?.statusDisplay?.title ?? '',
                chosenPackage: widget.insertHourlyDataModel.data?.hourlyRentalMobilePackage?.name ?? '',
                insertHourlyDataModel: widget.insertHourlyDataModel,
                serviceTime: widget.insertHourlyDataModel.data?.visitPackage?.title ?? '',
                fromHour: formatTime(widget.insertHourlyDataModel.data?.serviceTimeFrom ?? ''),
                toHour: formatTime(widget.insertHourlyDataModel.data?.serviceTimeTo ?? ''),
                numberOfWorkers: widget.insertHourlyDataModel.data?.countOfWorkers.toString() ?? '',
                serviceDays: widget.insertHourlyDataModel.data?.daysToServe
                    ?.map((date) => "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}")
                    .toList() ?? [],
                occupation: widget.insertHourlyDataModel.data?.occupation?.name ?? '',
                nationality: widget.insertHourlyDataModel.data?.country?.name ?? '',
                totalCost: "${widget.insertHourlyDataModel.data?.costIncludeTax.toString() ?? ''} ر.س",
              ),

            ),
            Expanded(child: Container()),
            ButtonWidget(textButton: "order_now".tr(), onPressed: () {

              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsFromHourlyContractScreen(insertHourlyDataModel: widget.insertHourlyDataModel,),));
              successGetBar("insert_hourly_data_success".tr());
            }),
          ],
        ),
      ),
    );
  }
}

class ServiceSummaryWidget extends StatelessWidget {
  final String serviceTime;
  final String fromHour;
  final String toHour;
  final String numberOfWorkers;
  final List<String> serviceDays;
  final String nationality;
  final String totalCost;
  final String orderNumber;
  final String chosenPackage;
  final InsertHourlyDataModel? insertHourlyDataModel;
  final String occupation;
  final String orderStatus;

  const ServiceSummaryWidget({
    super.key,
    required this.serviceTime,
    required this.insertHourlyDataModel,
    required this.fromHour,
    required this.toHour,
    required this.numberOfWorkers,
    required this.serviceDays,
    required this.nationality,
    required this.totalCost,
    required this.orderNumber,
    required this.chosenPackage,
    required this.occupation, required this.orderStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0.sp),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text(
                  'chosen_package'.tr(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(width: 20.w),
                SizedBox(
                  width: 150.w,
                  child: AutoSizeText(
                    chosenPackage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
          _buildSummaryRow('order_number'.tr(), orderNumber, isHighlighted: true),
          _buildSummaryRow('order_status'.tr(), orderStatus,isHighlighted: true),
          if (insertHourlyDataModel?.data?.visitPackage?.id != null)
            _buildSummaryRow('service_time'.tr(), serviceTime, isHighlighted: true),
          _buildSummaryRow('from_hour'.tr(), fromHour, isHighlighted: true),
          _buildSummaryRow('to_hour'.tr(), toHour, isHighlighted: true),
          _buildSummaryRow('number_of_workers'.tr(), numberOfWorkers, isHighlighted: true),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Expanded(
                  flex: 1,
                  child: Text(
                    'service_days'.tr(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: serviceDays.map((day) => Text(
                    day,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[800],
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),

          _buildSummaryRow('occupation'.tr(), occupation),

          _buildSummaryRow('nationality'.tr(), nationality),
          _buildSummaryRow('total_cost'.tr(), totalCost, isCost: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value,
      {bool isHighlighted = false, bool isCost = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: isHighlighted ? Colors.blue : Colors.grey[800],
              fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              color: isCost ? Colors.red : Colors.grey[800],
              fontWeight: isCost ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}



