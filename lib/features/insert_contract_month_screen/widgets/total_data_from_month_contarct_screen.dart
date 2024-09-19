import 'package:arabia/core/models/insert_monthly_data_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/dialogs.dart';
import '../../../core/utils/style_text.dart';
import '../../../core/widgets/appbar_widget_with_screens.dart';
import '../../../core/widgets/button_widget.dart';
import 'details_from_insert_monthly_contract_screen.dart';

class TotalDataFromMonthContactScreen extends StatefulWidget {
  const TotalDataFromMonthContactScreen(
      {super.key, required this.insertMonthlyDataModel});
  final InsertMonthlyDataModel insertMonthlyDataModel;

  @override
  State<TotalDataFromMonthContactScreen> createState() =>
      _TotalDataFromMonthContactScreenState();
}

class _TotalDataFromMonthContactScreenState
    extends State<TotalDataFromMonthContactScreen> {
  @override
  Widget build(BuildContext context) {
    // Function to parse the date string and format it
    String formatDate(String dateString) {
      try {
        DateTime date = DateTime.parse(dateString);
        return DateFormat('yyyy-MM-dd').format(date);
      } catch (e) {
        print("Error formatting date: $e");
        return dateString; // Return the original string if parsing fails
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(20.0.sp),
              child:
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "contract_month".tr(),
                      style: TextStyles.size22FontWidgetBoldBlue.copyWith(fontSize: 20.sp)
                  ),

                  SizedBox(

                    child: Text(
                      widget.insertMonthlyDataModel.data
                          ?.monthlyRentalMobilePackage?.name
                          .toString() ??
                          '',
                      style: TextStyles.size13FontWidgetSemiBoldBlackWithOpacity6.copyWith(fontSize: 10.sp),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              // AppbarWidgetWithScreens(
              //   title: "contract_month".tr(),
              //   description: widget.insertMonthlyDataModel.data
              //           ?.monthlyRentalMobilePackage?.name
              //           .toString() ??
              //       '',
              // ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0.sp),
              child: ServiceSummaryWidget(
                orderNumber: widget.insertMonthlyDataModel.data?.id.toString() ??'',
                occupation: widget.insertMonthlyDataModel.data?.occupation?.name.toString() ??'',
                statusOrder: widget.insertMonthlyDataModel.data?.statusClient.toString() ??'',

                fromHour: formatDate(widget
                        .insertMonthlyDataModel.data?.serviceDateFrom
                        .toString() ??
                    ''),
                toHour: formatDate(widget
                        .insertMonthlyDataModel.data?.serviceDateTo
                        .toString() ??
                    ''),
                numberOfWorkers: widget
                        .insertMonthlyDataModel.data?.countOfWorkers
                        .toString() ??
                    '',
                nationality:
                    widget.insertMonthlyDataModel.data?.country?.name ?? '',
                totalCost:
                    "${double.parse(widget.insertMonthlyDataModel.data?.costIncludeTax.toString() ?? '0').toStringAsFixed(2)} ر.س",
              ),
            ),
            Expanded(child: Container()),
            ButtonWidget(textButton: "order_now".tr(), onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsFromMonthlyContractScreen(insertMonthlyDataModel: widget.insertMonthlyDataModel,),));
              successGetBar("insert_monthly_data_success".tr());
            }),
          ],
        ),
      ),
    );
  }
}

class ServiceSummaryWidget extends StatelessWidget {
  final String fromHour;
  final String toHour;
  final String numberOfWorkers;
  final String nationality;
  final String totalCost;
  final String orderNumber;
  final String occupation;
  final String statusOrder;
  ServiceSummaryWidget({
    super.key,
    required this.fromHour,
    required this.toHour,
    required this.numberOfWorkers,
    required this.nationality,
    required this.totalCost, required this.orderNumber, required this.occupation, required this.statusOrder,
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
          _buildSummaryRow('order_number'.tr(), orderNumber, isHighlighted: true),
          _buildSummaryRow('from_date'.tr(), fromHour, isHighlighted: true),
          _buildSummaryRow('to_date'.tr(), toHour, isHighlighted: true),
          _buildSummaryRow('number_of_workers'.tr(), numberOfWorkers,
              isHighlighted: true),
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
