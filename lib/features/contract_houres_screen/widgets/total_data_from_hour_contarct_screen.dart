import 'package:arabia/core/utils/app_colors.dart';
import 'package:arabia/core/widgets/button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/widgets/appbar_widget_with_screens.dart';

class TotalDataFromHourContactScreen extends StatefulWidget {
  const TotalDataFromHourContactScreen({super.key});

  @override
  State<TotalDataFromHourContactScreen> createState() =>
      _TotalDataFromHourContactScreenState();
}

class _TotalDataFromHourContactScreenState
    extends State<TotalDataFromHourContactScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0.sp),
              child: AppbarWidgetWithScreens(
                title: "contract_hours".tr(),
                description: 'details'.tr(),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0.sp),
              child: const ServiceSummaryWidget(
                serviceTime: 'خدمة مسائية',
                fromHour: '3 م',
                toHour: '10 م',
                numberOfWorkers: '5',
                serviceDays: '2',
                nationality: 'باكستاني',
                totalCost: '100 رس',
              ),
            ),
            Expanded(child: Container()),
            ButtonWidget(textButton: "order_now".tr(), onPressed: () {}),
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
  final String serviceDays;
  final String nationality;
  final String totalCost;

  const ServiceSummaryWidget({
    super.key,
    required this.serviceTime,
    required this.fromHour,
    required this.toHour,
    required this.numberOfWorkers,
    required this.serviceDays,
    required this.nationality,
    required this.totalCost,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0.sp),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.05), // Light blue background color
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryRow('service_time'.tr(), serviceTime, isHighlighted: true),
          _buildSummaryRow('from_hour'.tr(), fromHour,isHighlighted: true),
          _buildSummaryRow('to_hour'.tr(), toHour,isHighlighted: true),
          _buildSummaryRow('number_of_workers'.tr(), numberOfWorkers,isHighlighted: true),
          _buildSummaryRow('service_days'.tr(), serviceDays),
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
