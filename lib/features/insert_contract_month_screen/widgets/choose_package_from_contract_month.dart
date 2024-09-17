import 'package:arabia/core/utils/app_colors.dart';
import 'package:arabia/core/widgets/button_widget.dart';
import 'package:arabia/core/widgets/shared_text_filed.dart';
import 'package:arabia/features/insert_contract_month_screen/cubit/cubit.dart';
import 'package:arabia/features/insert_contract_month_screen/cubit/state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/models/get_monthly_Data.dart';
import '../../../core/utils/style_text.dart';
import '../../../core/widgets/appbar_widget_with_screens.dart';
import 'nationality_monthly_drop_down.dart';

class ChoosePackageFromContractMonthScreen extends StatefulWidget {
  const ChoosePackageFromContractMonthScreen(
      {super.key, required this.package, required this.cubit});
  final MonthlyPackage package;
  final InsertContractMonthCubit cubit;

  @override
  State<ChoosePackageFromContractMonthScreen> createState() =>
      _ChoosePackageFromContractMonthScreenState();
}

class _ChoosePackageFromContractMonthScreenState
    extends State<ChoosePackageFromContractMonthScreen> {
  final _formKey = GlobalKey<FormState>();
  double laborCost = 0.0;
  double transferCost = 0.0;
  double totalCostWithTransfer = 0.0;
  double taxWithTransfer = 0.0;
  double taxOnLabor = 0.0;
  String? selectedTransferType = 'recovery';
  double totalCost = 0.0;
  int? selectedCountryId;
  int? numberOfWorkers;
  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  DateTime? selectedFromDate;
  DateTime? selectedToDate;
  int minRentalDuration = 1; // Default minimum rental duration

  @override
  void initState() {
    super.initState();
    minRentalDuration = int.parse(widget.package.minRentalDurationPerMonth ?? '1'); // Set the minimum duration
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Form(
          key: _formKey, // Assign the form key
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20.0.sp),
                child: AppbarWidgetWithScreens(
                  title: "contract_month".tr(),
                  description: widget.package.name.toString() ?? '',
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10.0.sp),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      _buildDateFilter(
                          context, "from_date".tr(), fromDate, isFromDate: true),
                      SizedBox(height: 20.h),
                      _buildDateFilter(context, "to_date".tr(), toDate, isFromDate: false),
                      SizedBox(height: 20.h),
                      _buildWorkersDropdown(), // Add dropdown for the number of workers
                      SizedBox(height: 20.h),
                      NationalityMonthlyDropdown(
                        countries: widget.package.availableCountries!,
                        onChanged: (selectedNationality) {
                          setState(() {
                            selectedCountryId = int.parse(widget.package.availableCountries!.firstWhere((country) => country.name == selectedNationality).id.toString());
                          });
                          print('Selected nationality: $selectedNationality');
                        },
                      ),
                      SizedBox(height: 20.h),
                      if (widget.package.giveTransferServiceOption == true)
                        _buildTransferServiceOption(),
                      SizedBox(height: 20.h),
                      _buildTotalCost(),
                      SizedBox(height: 20.h),
                      BlocBuilder<InsertContractMonthCubit, InsertContractMonthState>(builder: (context, state) {
                        return (state is InsertMonthlyDataLoadingState)
                            ? Center(
                            child: CircularProgressIndicator(color: AppColors.blue))
                            : ButtonWidget(
                          textButton: "order_now".tr(),
                          onPressed: () {
                            if (_validateInputs()) { // Check if all inputs are valid
                              widget.cubit.insertMonthlyData(
                                context: context,
                                monthlyRentalMobilePackageId: int.parse(widget.package.id.toString()),
                                totalInvoiceCostIncludeTax: totalCost.toString(),
                                totalInvoiceCostTax: (totalCost * (double.parse(widget.package.taxRatio.toString()) / 100)).toString(),
                                totalInvoiceCostTaxRatio: widget.package.taxRatio.toString(),
                                totalInvoiceCostWithoutTax: (totalCost / (1 + double.parse(widget.package.taxRatio.toString()) / 100)).toString(),
                                countryId: selectedCountryId!,
                                occId: int.parse(widget.package.occId.toString()),
                                serviceTimeFrom: fromDate.text,
                                serviceTimeTo: toDate.text,
                                countOfWorkers: numberOfWorkers ?? 1,
                              );
                            }
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _validateInputs() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      return true;
    } else {
      return false;
    }
  }

  Widget _buildWorkersDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0.sp, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.blue.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8.0.sp),
      ),
      child: DropdownButtonFormField<int>(
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
        value: numberOfWorkers,
        validator: (value) {
          if (value == null) {
            return 'please_select_number_of_workers'.tr();
          }
          return null;
        },
        dropdownColor: AppColors.white,
        items: List.generate(int.parse(widget.package.maxWorkersCount!), (index) {
          int workerCount = index + 1;
          return DropdownMenuItem<int>(
            value: workerCount,
            child: Text(workerCount.toString()),
          );
        }),
        onChanged: (value) {
          setState(() {
            numberOfWorkers = value;
          });
        },
      ),
    );
  }

  Widget _buildDateFilter(BuildContext context, String hintText, TextEditingController controller,
      {required bool isFromDate}) {
    return SharedTextFiled(
      readOnly: true,
      controller: controller,
      suffixIcon: GestureDetector(
        onTap: () async {
          // تحديد التاريخ الأول بناءً على منطق التاريخ المحدد مسبقًا
          DateTime firstDate = isFromDate
              ? DateTime.now()
              : selectedFromDate?.add(Duration(days: (30 * minRentalDuration) - 1)) ?? DateTime.now();

          // تحديد التاريخ الابتدائي بناءً على التاريخ الأول
          DateTime initialDate = isFromDate
              ? DateTime.now()
              : (firstDate.isAfter(DateTime.now()) ? firstDate : DateTime.now());

          // تحديد التاريخ الأخير للسماح بفترة أطول من 6 أشهر
          DateTime lastDate = DateTime(2030); // تحديد تاريخ بعيد في المستقبل للسماح بفترة أطول

          // فتح نافذة اختيار التاريخ
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: firstDate,
            lastDate: lastDate,
          );

          if (picked != null) {
            setState(() {
              if (isFromDate) {
                selectedFromDate = picked;
                fromDate.text = "${picked.toLocal()}".split(' ')[0];
                if (selectedToDate != null &&
                    selectedToDate!.isBefore(selectedFromDate!.add(Duration(days: (30 * minRentalDuration) - 1)))) {
                  selectedToDate = selectedFromDate!.add(Duration(days: (30 * minRentalDuration) - 1));
                  toDate.text = "${selectedToDate!.toLocal()}".split(' ')[0];
                }
              } else {
                selectedToDate = picked;
                toDate.text = "${picked.toLocal()}".split(' ')[0];
              }
            });
          }
        },
        child: Icon(Icons.calendar_month, color: AppColors.orange),
      ),
      hintText: hintText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return isFromDate ? 'please_select_from_date'.tr() : 'please_select_to_date'.tr();
        }
        return null;
      },
      onSaved: (value) {},
    );
  }



  Widget _buildTransferServiceOption() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0.sp, vertical: 16.sp),
      decoration: BoxDecoration(
        color: AppColors.blue.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8.0.sp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("add_service_transfer".tr(), style: TextStyle(fontSize: 16.sp)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Radio(
                    value: 'yes',
                    groupValue: selectedTransferType,
                    onChanged: (value) {
                      setState(() {
                        selectedTransferType = value.toString();
                        print("selectedTransferType: $selectedTransferType");
                      });
                    },
                  ),
                  Text('yes'.tr()),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 'no',
                    groupValue: selectedTransferType,
                    onChanged: (value) {
                      setState(() {
                        selectedTransferType = value.toString();
                        print("selectedTransferType: $selectedTransferType");
                      });
                    },
                  ),
                  Text('no'.tr()),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTotalCost() {
    // تحويل تكلفة العامل الواحد وتكلفة نقل الخدمة من النص إلى قيمة عددية
    double costPerWorker = double.parse(widget.package.costOneWorkerPerMonth.toString());
    double costTransferService = double.parse(widget.package.costTransferServicePerOneWorker.toString());

    // التأكد من أن التواريخ محددة لحساب التكاليف
    if (selectedFromDate != null && selectedToDate != null) {
      // حساب عدد الأيام بين التواريخ المحددة
      int daysBetween = (selectedToDate?.difference(selectedFromDate!).inDays ?? 0) + 1;
      int daysInMonth = int.parse(widget.package.countOfDaysInOneMonth.toString());

      // حساب تكلفة العمالة
      laborCost = (daysBetween / daysInMonth) * costPerWorker * (numberOfWorkers ?? 1);

      // حساب الضريبة بناءً على تكلفة العمالة فقط
      taxOnLabor = laborCost * (double.parse(widget.package.taxRatio.toString()) / 100);

      // إذا كانت خدمة نقل الكفالة مفعلة
      if (widget.package.giveTransferServiceOption!) {
        // حساب تكلفة نقل الخدمة
        transferCost = costTransferService * (numberOfWorkers ?? 1);

        // حساب الإجمالي الفرعي مع تكلفة نقل الخدمة
        totalCostWithTransfer = laborCost + transferCost;

        // حساب الضريبة على الإجمالي الفرعي مع نقل الخدمة
        taxWithTransfer = totalCostWithTransfer * (double.parse(widget.package.taxRatio.toString()) / 100);
      }

      // الحساب النهائي للتكلفة الإجمالية
      totalCost = widget.package.giveTransferServiceOption! ? totalCostWithTransfer + taxWithTransfer : laborCost + taxOnLabor;
    } else {
      // إذا لم يتم تحديد التواريخ، تأكد أن جميع القيم تساوي 0
      laborCost = 0.0;
      transferCost = 0.0;
      totalCostWithTransfer = 0.0;
      taxWithTransfer = 0.0;
      taxOnLabor = 0.0;
      totalCost = 0.0;
    }

    return Column(
      children: [
        if (widget.package.giveTransferServiceOption!) ...[
          // عرض تكلفة العمالة وتكلفة نقل الخدمة
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("labor_cost".tr(), style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
              Text("${laborCost.toStringAsFixed(2)} ${"currency".tr()}", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 10.sp),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("transfer_cost".tr(), style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
              Text("${transferCost.toStringAsFixed(2)} ${"currency".tr()}", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 10.sp),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("sub_total".tr(), style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
              Text("${totalCostWithTransfer.toStringAsFixed(2)} ${"currency".tr()}", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 10.sp),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("ratio".tr(), style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
              Text("${taxWithTransfer.toStringAsFixed(2)} ${"currency".tr()}", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
            ],
          ),
        ] else ...[
          // عرض الضريبة الإجمالية والتكلفة الإجمالية فقط عند عدم تفعيل نقل الخدمة
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("sub_total".tr(), style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
              Text("${laborCost.toStringAsFixed(2)} ${"currency".tr()}", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 10.sp),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("ratio".tr(), style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
              Text("${taxOnLabor.toStringAsFixed(2)} ${"currency".tr()}", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
        SizedBox(height: 10.sp),
        // عرض التكلفة الإجمالية النهائية
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("total_cost".tr(), style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
            Text("${totalCost.toStringAsFixed(2)} ${"currency".tr()}", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}
