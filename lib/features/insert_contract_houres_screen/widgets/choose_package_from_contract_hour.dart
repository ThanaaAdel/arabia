import 'package:arabia/core/utils/app_colors.dart';
import 'package:arabia/core/widgets/button_widget.dart';
import 'package:arabia/core/widgets/shared_text_filed.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/models/get_hourly__package_model.dart';
import '../../../core/utils/style_text.dart';
import '../../../core/widgets/appbar_widget_with_screens.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import 'nationality_drop_down.dart';

class ChoosePackageFromContractHourScreen extends StatefulWidget {
  const ChoosePackageFromContractHourScreen(
      {super.key, required this.package, required this.cubit});
  final Package package;
  final InsertContractHourCubit cubit;

  @override
  State<ChoosePackageFromContractHourScreen> createState() =>
      _ChoosePackageFromContractHourScreenState();
}

class _ChoosePackageFromContractHourScreenState
    extends State<ChoosePackageFromContractHourScreen> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  int? selectedTransferType = 0;
  String? selectedCountryId;

  double get subTotal {
    final numberOfDays = widget.cubit.selectedDatesFromServiceDays.length;
    print("numberOfDays: $numberOfDays");
    final numberOfWorkers = (widget.package.countOfWorkersSelectsMethod == 'restricted')
        ? int.tryParse(widget.package.restrictCountOfWorkers.toString()) // استخدم العدد المحدد في `restrictCountOfWorkers`
        : (widget.cubit.numberOfWorkersController.text.isNotEmpty // إذا كان النص في الحقل غير فارغ
        ? int.tryParse(widget.cubit.numberOfWorkersController.text) // حاول تحويله إلى عدد
        : null); // إذا لم يتم إدخال أي شيء، لا تستخدم قيمة افتراضية print("numberOfWorkers: $numberOfWorkers");
    final costPerHour =
        int.tryParse(widget.package.costOfWorkerPerHour ?? '') ?? 1;
    print("costPerHour: $costPerHour");

    final numberOfHours =
        (widget.package.serviceTimeSelectsMethod == 'restricted')
            ? calculateHoursDifference(widget.package.restrictServiceTimeStart!,
                widget.package.restrictServiceTimeEnd!)
            : calculateHoursDifference(widget.cubit.fromHourController.text,
                widget.cubit.toHourController.text);
    print("workers: $numberOfWorkers");
    print("numberOfHours: $numberOfHours");

    return (numberOfDays.toDouble() ?? 0.0) *
        (numberOfWorkers ?? 1) *
        (costPerHour ?? 0) *
        (numberOfHours ?? 0);  }

  int calculateHoursDifference(String fromTime, String toTime) {
    if (fromTime.isEmpty || toTime.isEmpty) return 0;

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
      toInMinutes += 1440; // Handle case where time crosses to next day
    }

    final durationInMinutes = toInMinutes - fromInMinutes;
    return (durationInMinutes / 60).ceil(); // Convert minutes to hours
  }

  double get ratio {
    // Parse taxRatio to double to handle decimal percentages correctly
    double taxRatio = double.tryParse(widget.package.taxRatio ?? '0') ?? 0;

    // Calculate the tax amount by multiplying subtotal with the tax ratio divided by 100
    return (subTotal * (taxRatio / 100));
  }

  double get total {
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
        return '${'you_cannot_select_a_period_greater_than'.tr()} ${widget.package.maxServiceTimeDurationLimit} ${'hours'.tr()}';
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

  Future<void> _pickTime(BuildContext context, TextEditingController controller,
      {bool isFromTime = false}) async {
    // تعيين الوقت الأدنى المسموح به
    TimeOfDay minTime = const TimeOfDay(hour: 2, minute: 0);

    // تحديد الوقت المختار سابقًا
    TimeOfDay? selectedTime;

    // التحقق من الحقل الذي يتم تحريره حاليًا، إما "من الوقت" أو "إلى الوقت"
    if (controller.text.isNotEmpty) {
      final timeParts = controller.text.split(' ');
      final timeComponents = timeParts[0].split(':');
      int hour = int.parse(timeComponents[0]);
      int minute = int.parse(timeComponents[1]);

      if (timeParts[1].toLowerCase() == 'ص' && hour == 12) {
        hour = 0;
      } else if (timeParts[1].toLowerCase() == 'م' && hour != 12) {
        hour += 12;
      }
      selectedTime = TimeOfDay(hour: hour, minute: minute);
    }

    // فتح نافذة اختيار الوقت
    TimeOfDay? pickedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.inputOnly, // العرض على صيغة الإدخال النصي افتراضياً
      initialTime: selectedTime ?? minTime, // الوقت المبدئي يكون الوقت المختار مسبقاً
      context: context,
    );

    if (pickedTime != null) {
      // تحديد إذا كان يتم اختيار وقت "من" أو "إلى"
      if (isFromTime) {
        // التحقق من أن الوقت المختار بعد الحد الأدنى
        if (pickedTime.hour > minTime.hour ||
            (pickedTime.hour == minTime.hour &&
                pickedTime.minute >= minTime.minute)) {
          setState(() {
            controller.text = pickedTime.format(context); // حفظ الوقت في الحقل
            _validateAndShowError(context);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  "${'please_select_a_time_after'.tr()} ${minTime.format(context)}."),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        // التحقق من أن وقت "إلى" بعد وقت "من"
        if (widget.cubit.fromHourController.text.isNotEmpty) {
          final fromTimeParts = widget.cubit.fromHourController.text.split(' ');
          final fromTimeComponents = fromTimeParts[0].split(':');
          int fromHour = int.parse(fromTimeComponents[0]);
          int fromMinute = int.parse(fromTimeComponents[1]);

          if (fromTimeParts[1].toLowerCase() == 'ص' && fromHour == 12) {
            fromHour = 0;
          } else if (fromTimeParts[1].toLowerCase() == 'م' && fromHour != 12) {
            fromHour += 12;
          }

          TimeOfDay fromTime = TimeOfDay(hour: fromHour, minute: fromMinute);

          if (pickedTime.hour > fromTime.hour ||
              (pickedTime.hour == fromTime.hour &&
                  pickedTime.minute > fromTime.minute)) {
            setState(() {
              controller.text = pickedTime.format(context); // حفظ الوقت المختار
              _validateAndShowError(context);
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    "Please select a time after ${widget.cubit.fromHourController.text}."),
                backgroundColor: Colors.red,
              ),
            );
          }
        } else {
          setState(() {
            controller.text = pickedTime.format(context);
            _validateAndShowError(context);
          });
        }
      }
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
                description: widget.package.name ?? '',
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10.0.sp),
                child: Form(
                  key: _formKey, // Use form key for validation
                  child: ListView(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      widget.package.serviceTimeSelectsMethod == 'opened' ||
                              widget.package.serviceTimeSelectsMethod ==
                                  'restricted'
                          ? const SizedBox()
                          : Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 16.0.sp),
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
                                    "service_days_available".tr(),
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
                                            Radio<int>(
                                              value: int.parse(servicePackage.id
                                                  .toString()), // Ensure this is an int
                                              groupValue: selectedTransferType,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedTransferType =
                                                      value; // Correct type casting
                                                  widget
                                                          .cubit
                                                          .fromHourController
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
                                                fontSize: 14.sp,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                      SizedBox(height: 10.h),
                      if (widget.package.serviceTimeSelectsMethod ==
                          'restricted') ...[
                        SharedTextFiled(
                          readOnly: true,
                          hintText: "from_hour".tr(),
                          controller: TextEditingController(
                              text: widget.package.restrictServiceTimeStart),
                          enableOrNot: true,
                          onSaved: (p0) {},
                        ),
                        SizedBox(height: 10.h),
                        SharedTextFiled(
                          hintText: "to_hour".tr(),
                          controller: TextEditingController(
                              text: widget.package.restrictServiceTimeEnd),
                          enableOrNot: true,
                          onSaved: (p0) {},
                        ),
                      ] else ...[
                        SharedTextFiled(
                          hintText: "from_hour".tr(),
                          controller: widget.cubit.fromHourController,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              _pickTime(
                                  context, widget.cubit.fromHourController);
                              _validateAndShowError(context);
                            },
                            child: Icon(Icons.access_alarms_sharp,
                                size: 18.sp, color: AppColors.orange),
                          ),
                          readOnly: true,
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
                          validator: (value) {
                            // Add validator here
                            if (value == null || value.isEmpty) {
                              return 'please_enter_valid_time'.tr();
                            }
                            return null;
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
                          readOnly: true,
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
                          validator: (value) {
                            // Add validator here
                            if (value == null || value.isEmpty) {
                              return 'please_enter_valid_time'.tr();
                            }
                            return null;
                          },
                        ),
                      ],
                      SizedBox(height: 10.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0.sp,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.blue.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(8.0.sp),
                        ),
                        child:DropdownButtonFormField<int>(
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.blue.withOpacity(0.33)),
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
                              : null, // استخدم القيمة المدخلة فقط إذا كانت موجودة
                          validator: (value) {
                            if (value == null) {
                              return 'please_select_number_of_workers'.tr();
                            }
                            return null;
                          },
                          dropdownColor: AppColors.white,
                          items: List.generate(int.parse(widget.package.maxCountOfWorkersLimit!),
                                  (index) {
                            int workerCount = index + 1;
                            return DropdownMenuItem<int>(
                              value: workerCount,
                              child: Text(workerCount <= 2 ? "$workerCount ${'worker'.tr()}" : "$workerCount ${'workers'.tr()}"),
                            );
                          }),
                          onChanged: (value) {
                            setState(() {
                              widget.cubit.numberOfWorkersController.text = value.toString();
                            });
                          },
                        ),




                      ),

                      SizedBox(height: 20.h),
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
                      SizedBox(height: 20.h),
                      NationalityDropdownWidget(
                        countries: widget.package.availableCountries!,
                        onChanged: (selectedNationality) {
                          setState(() {
                            selectedCountryId = widget
                                .package.availableCountries!
                                .firstWhere((country) =>
                                    country.name == selectedNationality)
                                .id;
                          });
                          print('Selected nationality: $selectedNationality');
                        },
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.all(8.0.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("sub_total".tr(),
                                style: TextStyles
                                    .size16FontWidgetBoldBlackWithOpacity6),
                            SizedBox(width: 10.w),
                            Text(
                              subTotal.toString(),
                              style: TextStyles
                                  .size16FontWidgetBoldBlackWithOpacity6,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.all(8.0.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("ratio".tr(),
                                style: TextStyles
                                    .size16FontWidgetBoldBlackWithOpacity6),
                            SizedBox(width: 10.w),
                            Text(
                              ratio.toString(),
                              style: TextStyles
                                  .size16FontWidgetBoldBlackWithOpacity6,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.all(8.0.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("total_cost".tr(),
                                style: TextStyles
                                    .size16FontWidgetBoldBlackWithOpacity6),
                            SizedBox(width: 10.w),
                            Text(
                              total.toString(),
                              style: TextStyles
                                  .size16FontWidgetBoldBlackWithOpacity6,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      BlocBuilder<InsertContractHourCubit,
                          InsertContractHourState>(
                        builder: (context, state) {
                          return (state is InsertHourlyDataLoadingState)
                              ? Center(
                                  child: CircularProgressIndicator(
                                  color: AppColors.blue,
                                ))
                              : ButtonWidget(
                                  textButton: "order_now".tr(),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate() &&
                                        selectedCountryId != null) {
                                      print(
                                          'From Time: ${widget.cubit.fromHourController.text}');
                                      print(
                                          'To Time: ${widget.cubit.toHourController.text}');

                                      widget.cubit.insertHourlyData(
                                        serviceTimeFrom: widget.package
                                                    .serviceTimeSelectsMethod ==
                                                'restricted'
                                            ? widget.package
                                                .restrictServiceTimeStart
                                                .toString()
                                            : widget
                                                .cubit.fromHourController.text,
                                        serviceTimeTo: widget.package
                                                    .serviceTimeSelectsMethod ==
                                                'restricted'
                                            ? widget
                                                .package.restrictServiceTimeEnd
                                                .toString()
                                            : widget
                                                .cubit.toHourController.text,
                                        countOfWorkers: widget.package
                                                    .countOfWorkersSelectsMethod ==
                                                'restricted'
                                            ? widget
                                                .package.restrictCountOfWorkers
                                                .toString()
                                            : widget.cubit
                                                .numberOfWorkersController.text,
                                        context: context,
                                        countryId: selectedCountryId.toString(),
                                        occId: int.parse(widget.package.occId!),
                                        hourlyRentalMobilePackageId:
                                            int.parse(widget.package.id!),
                                        costWithoutTax: subTotal,
                                        costTax: ratio,
                                        costIncludeTax: total,
                                        costTaxRatio: ratio,
                                        visitPackageId: int.parse(
                                            selectedTransferType.toString()),
                                      );
                                    } else {
                                      // Show error message if nationality is not selected
                                      if (selectedCountryId == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                "please_select_a_nationality"
                                                    .tr()),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    }
                                  },
                                );
                        },
                      )
                    ],
                  ),
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
          // تحقق من عدد الأيام لا يتجاوز الحد الأقصى
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
            firstDate: DateTime.now(), // تعديل لتكون أول تاريخ هو اليوم الحالي
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


          // تحقق من أن التاريخ المختار ليس موجودًا بالفعل في القائمة (حسب اليوم فقط)
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
