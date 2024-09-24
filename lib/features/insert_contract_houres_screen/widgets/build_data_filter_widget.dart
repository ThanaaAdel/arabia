import 'package:arabia/core/widgets/shared_text_filed.dart';
import 'package:arabia/features/insert_contract_houres_screen/cubit/cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../core/models/get_hourly__package_model.dart';
import '../../../core/utils/app_colors.dart';
class BuildDataFilterWidget extends StatefulWidget {
  const BuildDataFilterWidget({super.key,required this.package,required this.cubit});
  final Package package;
  final InsertContractHourCubit cubit;
  @override
  State<BuildDataFilterWidget> createState() => _BuildDataFilterWidgetState();
}

class _BuildDataFilterWidgetState extends State<BuildDataFilterWidget> {
  @override
  Widget build(BuildContext context) {
    return SharedTextFiled(
      suffixIcon: GestureDetector(
        onTap: () async {
          if (widget.cubit.selectedDatesFromServiceDays.length >=
              int.tryParse(widget.package.maxServiceDaysLimit ?? '0')!) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    "you_have_reached_the_maximum_number_of_service_days_allowed"
                        .tr()),
              ),
            );
            return;
          }

          final DateTime? picked = await showDatePicker(
            context: context,
            initialDatePickerMode: DatePickerMode.day,
            initialDate: widget.cubit.selectedDate ?? DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2025),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    secondary: AppColors.primary,
                    background: AppColors.blue,
                    primary: AppColors.blue,
                    onPrimary: AppColors.white,
                    onSurface: AppColors.black,
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.blue,
                    ),
                  ),
                ),
                child: child!,
              );
            },
          );

          if (picked != null &&
              !widget.cubit.selectedDatesFromServiceDays.any((date) =>
              date.year == picked.year &&
                  date.month == picked.month &&
                  date.day == picked.day)) {
            setState(() {
              widget.cubit.selectedDatesFromServiceDays.add(picked);
            });
          }
        },
        child: Icon(
          Icons.calendar_month,
          color: AppColors.orange,
        ),
      ),
      readOnly: true,
      enableOrNot: true,
      hintText:
      "service_days_available".tr() + widget.package.maxServiceDaysLimit.toString(),
      onSaved: (p0) {},
    );
  }
}
