import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/models/insert_hourly_data_model.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/appbar_widget_with_screens.dart';
import '../../../core/widgets/button_widget.dart';

class TotalDataFromHourContactScreen extends StatefulWidget {
  const TotalDataFromHourContactScreen({super.key, required this.insertHourlyDataModel});
  final InsertHourlyDataModel insertHourlyDataModel;

  @override
  State<TotalDataFromHourContactScreen> createState() =>
      _TotalDataFromHourContactScreenState();
}

String formatTime(String time) {
  try {
    // تحقق مما إذا كان الوقت يتضمن أصفار زائدة في البداية
    List<String> parts = time.split(':');
    int hour = int.parse(parts[0]);
    String minute = parts[1];

    // تحديد ما إذا كان الوقت صباحًا أم مساءً
    String period = hour >= 12 ? 'م' : 'ص';

    // تحويل الساعة إلى تنسيق 12 ساعة وإزالة الأصفار الزائدة
    hour = hour % 12;
    hour = hour == 0 ? 12 : hour; // إذا كانت الساعة 0، يتم تحويلها إلى 12

    // إرجاع الوقت بالتنسيق المطلوب
    return '$hour:$minute $period';
  } catch (e) {
    print("Error formatting time: $e");
    return time; // إرجاع الوقت الأصلي في حالة وجود خطأ
  }
}


class _TotalDataFromHourContactScreenState extends State<TotalDataFromHourContactScreen> {
  @override
  Widget build(BuildContext context) {
    final daysList = widget.insertHourlyDataModel.data?.daysToServe ?? [];
    final serviceDaysCount = daysList.length; // حساب عدد أيام الخدمة

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
              child: ServiceSummaryWidget(
                insertHourlyDataModel: widget.insertHourlyDataModel, // Pass the insertHourlyDataModel object
                serviceTime: widget.insertHourlyDataModel.data?.visitPackage?.title ?? '',
                fromHour: formatTime(widget.insertHourlyDataModel.data?.serviceTimeFrom ?? ''),
                toHour: formatTime(widget.insertHourlyDataModel.data?.serviceTimeTo ?? ''),
                numberOfWorkers: widget.insertHourlyDataModel.data?.countOfWorkers.toString() ?? '',
                serviceDays: "$serviceDaysCount",
                nationality: widget.insertHourlyDataModel.data?.country?.name ?? '',
                totalCost: "${widget.insertHourlyDataModel.data?.costIncludeTax.toString() ?? ''} ر.س",
              ),
            ),
            Expanded(child: Container()),
            ButtonWidget(textButton: "order_now".tr(), onPressed: () {
              Navigator.pushNamed(context, Routes.hourlyContractsDetailsRoute,arguments: widget.insertHourlyDataModel);
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
  final String serviceDays;
  final String nationality;
  final String totalCost;
  final InsertHourlyDataModel? insertHourlyDataModel; // Properly define this field

  ServiceSummaryWidget({
    super.key,
    required this.serviceTime,
    required this.insertHourlyDataModel, // Require the insertHourlyDataModel object
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
        color: Colors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Properly check the condition and display the content
          if (insertHourlyDataModel?.data?.visitPackage?.id != null)
            _buildSummaryRow('service_time'.tr(), serviceTime, isHighlighted: true),
          _buildSummaryRow('from_hour'.tr(), fromHour, isHighlighted: true),
          _buildSummaryRow('to_hour'.tr(), toHour, isHighlighted: true),
          _buildSummaryRow('number_of_workers'.tr(), numberOfWorkers, isHighlighted: true),
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
