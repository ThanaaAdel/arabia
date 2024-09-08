import 'package:arabia/core/utils/app_colors.dart';
import 'package:arabia/core/widgets/button_widget.dart';
import 'package:arabia/core/widgets/shared_text_filed.dart';
import 'package:arabia/features/contract_houres_screen/cubit/cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/models/get_hourly__package_model.dart';
import '../../../core/utils/style_text.dart';
import '../../../core/widgets/appbar_widget_with_screens.dart';
import 'nationality_drop_down.dart';

class ChoosePackageFromContractHourScreen extends StatefulWidget {
  const ChoosePackageFromContractHourScreen(
      {super.key, required this.package, required this.cubit});
  final Package package;
  final ContractHourCubit cubit;

  @override
  State<ChoosePackageFromContractHourScreen> createState() =>
      _ChoosePackageFromContractHourScreenState();
}

class _ChoosePackageFromContractHourScreenState
    extends State<ChoosePackageFromContractHourScreen> {
  String? selectedTransferType = 'recovery';

  int get subTotal {
    final numberOfDays = widget.cubit.selectedDatesFromServiceDays.length;
    final numberOfWorkers = int.tryParse(widget.cubit.numberOfWorkersController.text) ?? 1;
    final costPerHour = int.tryParse(widget.package.costOfWorkerPerHour ?? '0') ?? 1;
    final taxRatio = int.tryParse(widget.package.taxRatio ?? '0') ?? 1;
    return numberOfWorkers * costPerHour * taxRatio * numberOfDays;
  }

  int get ratio {
    return subTotal * (int.tryParse(widget.package.taxRatio ?? '0') ?? 0);
  }

  int get total {
    return subTotal + ratio;
  }
  @override
  void dispose() {
    widget.cubit.selectedDatesFromServiceDays.clear();
    widget.cubit.fromHourController.clear();
    widget.cubit.toHourController.clear();
    widget.cubit.numberOfWorkersController.clear();
    super.dispose();
  }

  String? validateServiceTime(String? fromTime, String? toTime) {
    if (fromTime != null && toTime != null) {
      String cleanedFromTime = fromTime.replaceAll(RegExp(r'[^0-9:]'), '');
      String cleanedToTime = toTime.replaceAll(RegExp(r'[^0-9:]'), '');
      final from = TimeOfDay(
        hour: int.parse(cleanedFromTime.split(':')[0]),
        minute: int.parse(cleanedFromTime.split(':')[1]),
      );
      final to = TimeOfDay(
        hour: int.parse(cleanedToTime.split(':')[0]),
        minute: int.parse(cleanedToTime.split(':')[1]),
      );

      int fromInMinutes = from.hour * 60 + from.minute;
      int toInMinutes = to.hour * 60 + to.minute;

      if (toInMinutes < fromInMinutes) {
        toInMinutes += 1440;
      }
      final duration = toInMinutes - fromInMinutes;
      final maxDurationInMinutes =
          (int.tryParse(widget.package.maxServiceTimeDurationLimit ?? '0') ??
                  0) *
              60;
      if (duration > maxDurationInMinutes) {
        widget.cubit.toHourController.clear();
        return 'exceeded_maximum_service_time_duration'.tr();
      }
    }
    return null;
  }

  void _validateAndShowError(BuildContext context) {
    final error = validateServiceTime(widget.cubit.fromHourController.text,
        widget.cubit.toHourController.text);
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error), backgroundColor: Colors.red));
    }
  }

  Future<void> _pickTime(
      BuildContext context, TextEditingController controller) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        controller.text = pickedTime.format(context);
        _validateAndShowError(context);
      });
    }
  }

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
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10.0.sp),
                child: ListView(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    widget.package.serviceTimeSelectsMethod == 'opened' ||
                            widget.package.serviceTimeSelectsMethod ==
                                'restricted'
                        ? const SizedBox()
                        : Container(
                            height: 80.h,
                            padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                            decoration: BoxDecoration(
                              color: AppColors.blue.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(8.0.sp),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20.h),
                                Text(
                                  "service_time".tr(),
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ...widget.package.availableServicePackage!
                                        .map((servicePackage) {
                                      return Row(
                                        children: [
                                          Radio(
                                            value: servicePackage.id,
                                            groupValue: selectedTransferType,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedTransferType =
                                                    value.toString();
                                                widget.cubit.fromHourController
                                                        .text =
                                                    servicePackage.fromTime!;
                                                widget.cubit.toHourController
                                                        .text =
                                                    servicePackage.toTime!;
                                              });
                                            },
                                            activeColor: Colors.blue,
                                          ),
                                          Text(
                                            servicePackage.title!,
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                color: Colors.grey[700]),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                    SizedBox(
                      height: 10.h,
                    ),
                    if (widget.package.serviceTimeSelectsMethod ==
                        'restricted') ...[
                      SharedTextFiled(
                        hintText: "from_hour".tr(),
                        controller: TextEditingController(
                            text: widget.package.restrictServiceTimeStart),
                        enableOrNot: false,
                        onSaved: (p0) {},
                      ),
                      SizedBox(height: 10.h),
                      SharedTextFiled(
                        hintText: "to_hour".tr(),
                        controller: TextEditingController(
                            text: widget.package.restrictServiceTimeEnd),
                        enableOrNot: false,
                        onSaved: (p0) {},
                      ),
                    ] else ...[
                      SharedTextFiled(
                        hintText: "from_hour".tr(),
                        controller: widget.cubit.fromHourController,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            _pickTime(context, widget.cubit.fromHourController);
                            _validateAndShowError(context);
                          },
                          child: Icon(Icons.access_alarms_sharp,
                              size: 18.sp, color: AppColors.orange),
                        ),
                        enableOrNot: true,
                        onSaved: (p0) {},
                        onChanged: (value) {
                          final error = validateServiceTime(
                              widget.cubit.fromHourController.text,
                              widget.cubit.toHourController.text);
                          if (error != null) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(error)));
                          }
                        },
                      ),
                      SizedBox(height: 10.h),
                      SharedTextFiled(
                        hintText: "to_hour".tr(),
                        controller: widget.cubit.toHourController,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            _pickTime(context, widget.cubit.toHourController);
                            _validateAndShowError(context);
                          },
                          child: Icon(Icons.access_alarms_sharp,
                              size: 18.sp, color: AppColors.orange),
                        ),
                        enableOrNot: true,
                        onSaved: (p0) {},
                        onChanged: (value) {
                          final error = validateServiceTime(
                              widget.cubit.fromHourController.text,
                              widget.cubit.toHourController.text);
                          if (error != null) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(error)));
                          }
                        },
                      ),
                    ],
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0.sp, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: AppColors.blue.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(8.0.sp),
                      ),
                      child: DropdownButton<String>(
                        hint: Text("number_of_workers".tr()),
                        value: widget.package.countOfWorkersSelectsMethod ==
                                'restricted'
                            ? widget.package.restrictCountOfWorkers
                            : (widget.cubit.numberOfWorkersController.text
                                        .isNotEmpty &&
                                    List<int>.generate(
                                        int.parse(widget
                                            .package.maxCountOfWorkersLimit!),
                                        (index) =>
                                            index + 1).contains(int.tryParse(
                                        widget.cubit.numberOfWorkersController
                                            .text)))
                                ? widget.cubit.numberOfWorkersController.text
                                : null, // التأكد من أن القيمة موجودة في القائمة، أو تعيين null
                        isExpanded: true,
                        elevation: 16,
                        dropdownColor: AppColors.white,
                        borderRadius: BorderRadius.circular(8.sp),
                        menuMaxHeight: 100.sp,
                        autofocus: true,
                        enableFeedback: false,
                        style:
                            TextStyle(color: AppColors.black, fontSize: 16.sp),
                        underline: Container(),
                        icon: widget.package.countOfWorkersSelectsMethod ==
                                'restricted'
                            ? const SizedBox()
                            : Icon(Icons.arrow_drop_down,
                                color: AppColors.orange),
                        iconSize: 24.sp,
                        onChanged: widget.package.countOfWorkersSelectsMethod ==
                                'restricted'
                            ? null
                            : (value) {
                                if (value != null) {
                                  setState(() {
                                    widget.cubit.numberOfWorkersController
                                        .text = value; // تحديث القيمة المختارة
                                  });
                                }
                              },
                        items: widget.package.serviceTimeSelectsMethod ==
                                'opened'
                            ? List<int>.generate(
                                    int.parse(
                                        widget.package.maxCountOfWorkersLimit!),
                                    (index) => index + 1)
                                .map((number) => DropdownMenuItem<String>(
                                      value: number.toString(),
                                      child: Text(number.toString()),
                                    ))
                                .toList()
                            : [
                                DropdownMenuItem<String>(
                                  value: widget.package.restrictCountOfWorkers,
                                  child: Text(
                                      widget.package.restrictCountOfWorkers!),
                                ),
                              ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    _buildDateFilter(context),
                    if (widget.cubit.selectedDatesFromServiceDays.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: Wrap(
                          spacing: 8.0,
                          children: widget.cubit.selectedDatesFromServiceDays
                              .map((date) {
                            return Chip(
                              label: Text(
                                "${date.toLocal()}".split(' ')[0],
                                style: TextStyle(fontSize: 14.sp),
                              ),
                              deleteIcon: Icon(Icons.close,
                                  color: Colors.red, size: 18.sp),
                              onDeleted: () {
                                setState(() {
                                  widget.cubit.selectedDatesFromServiceDays
                                      .remove(date);
                                });
                              },
                              backgroundColor: Colors.red.withOpacity(0.08),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.sp),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    SizedBox(
                      height: 20.h,
                    ),
                    NationalityDropdownWidget(
                      countries: widget.package.availableCountries!,
                      onChanged: (selectedNationality) {
                        print('Selected nationality: $selectedNationality');
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("sub_total".tr(),
                              style: TextStyles
                                  .size16FontWidgetBoldBlackWithOpacity6),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            subTotal.toString(),
                            style: TextStyles
                                .size16FontWidgetBoldBlackWithOpacity6,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("ratio".tr(),
                              style: TextStyles
                                  .size16FontWidgetBoldBlackWithOpacity6),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            ratio.toString(),
                            style: TextStyles
                                .size16FontWidgetBoldBlackWithOpacity6,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("total_cost".tr(),
                              style: TextStyles
                                  .size16FontWidgetBoldBlackWithOpacity6),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            total.toString(),
                            style: TextStyles
                                .size16FontWidgetBoldBlackWithOpacity6,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ButtonWidget(
                        textButton: "order_now".tr(),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, Routes.totalDataFromHourContactRoute);
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateFilter(BuildContext context) {
    return SharedTextFiled(
      suffixIcon: GestureDetector(
        onTap: () async {
          if (widget.cubit.selectedDatesFromServiceDays.length >=
              int.tryParse(widget.package.maxServiceDaysLimit ?? '0')!) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                      "you_have_reached_the_maximum_number_of_service_days_allowed"
                          .tr())),
            );
            return;
          }
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDatePickerMode: DatePickerMode.day,
            initialDate: widget.cubit.selectedDate ?? DateTime.now(),
            firstDate: DateTime(2000),
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
              !widget.cubit.selectedDatesFromServiceDays.contains(picked)) {
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
      hintText: "service_days".tr(),
      onSaved: (p0) {},
    );
  }
}
