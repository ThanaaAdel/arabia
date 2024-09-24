import 'package:arabia/features/insert_contract_houres_screen/cubit/cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/models/get_hourly__package_model.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/style_text.dart';

class BuildWorkerSelectionDropdown extends StatefulWidget {
  const BuildWorkerSelectionDropdown({super.key, required this.package, required this.cubit});
  final Package package;
  final InsertContractHourCubit cubit;
  @override
  State<BuildWorkerSelectionDropdown> createState() => _BuildWorkerSelectionDropdownState();
}

class _BuildWorkerSelectionDropdownState extends State<BuildWorkerSelectionDropdown> {
  @override
  Widget build(BuildContext context) {
    final isWorkerCountRestricted =
        widget.package.countOfWorkersSelectsMethod == 'restricted';


    return isWorkerCountRestricted
        ? Text(
      '${"number_of_workers".tr()}: ${widget.package.restrictCountOfWorkers}',
      style: TextStyle(fontSize: 16.sp),
    )
        : DropdownButtonFormField<int>(
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: AppColors.blue.withOpacity(0.33)),
        ),
        hintText: "number_of_workers".tr(),
        contentPadding: EdgeInsets.only(bottom: 10.h),
        hintStyle: TextStyles.size16FontWidgetRegularGrayLight,
        labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
            color: AppColors.black.withOpacity(0.5)),
      ),
      value: widget.cubit.numberOfWorkersController.text.isNotEmpty
          ? int.tryParse(widget.cubit.numberOfWorkersController.text)
          : null,
      validator: (value) {
        if (value == null) {
          return 'please_select_number_of_workers'.tr();
        }
        return null;
      },
      dropdownColor: AppColors.white,
      items: List.generate(
          int.parse(widget.package.maxCountOfWorkersLimit ?? '5'),
              (index) {
            int workerCount = index + 1;
            return DropdownMenuItem<int>(
              value: workerCount,
              child: Text(workerCount <= 2
                  ? "$workerCount ${'worker'.tr()}"
                  : "$workerCount ${'workers'.tr()}"),
            );
          }),
      onChanged: (value) {
        setState(() {
          widget.cubit.numberOfWorkersController.text = value.toString();
        });
      },
    );
  }
}
