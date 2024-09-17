

import 'package:arabia/config/routes/app_routes.dart';
import 'package:arabia/core/models/insert_monthly_data_model.dart';
import 'package:arabia/core/utils/dialogs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/get_monthly_Data.dart';
import '../../../core/models/get_occupations_model.dart';
import '../../../core/remote/service.dart';
import 'state.dart';

class InsertContractMonthCubit extends Cubit<InsertContractMonthState> {
  InsertContractMonthCubit(this.api) : super(MainInitial());

  ServiceApi api;
  GetOccupationsModel?  occupationsModel;
  List<MonthlyPackage>? packagesModel;

  // var ratio = 0.15;
  //
  // double calculateSubTotal() {
  //   try {
  //     // عدد الساعات: حساب الفرق بين وقت البداية ووقت النهاية
  //     final fromHour = TimeOfDay(
  //       hour: int.parse(fromHourController.text.split(':')[0]),
  //       minute: int.parse(fromHourController.text.split(':')[1]),
  //     );
  //     final toHour = TimeOfDay(
  //       hour: int.parse(toHourController.text.split(':')[0]),
  //       minute: int.parse(toHourController.text.split(':')[1]),
  //     );
  //
  //     // حساب عدد الساعات
  //     int fromInMinutes = fromHour.hour * 60 + fromHour.minute;
  //     int toInMinutes = toHour.hour * 60 + toHour.minute;
  //     if (toInMinutes < fromInMinutes) {
  //       toInMinutes += 1440; // إضافة 24 ساعة إذا كانت نهاية اليوم
  //     }
  //     final totalHours = (toInMinutes - fromInMinutes) / 60;
  //
  //     // عدد العمال
  //     final numberOfWorkers = int.tryParse(numberOfWorkersController.text) ?? 0;
  //
  //     // عدد الأيام
  //     final numberOfDays = selectedDatesFromServiceDays.length;
  //
  //     // سعر الساعة (يمكنك استبدال 100 بالسعر الفعلي من `package`)
  //     final hourlyRate = double.tryParse(packagesModel?.first.hourlyRate ?? '100') ?? 0;
  //
  //     // حساب الإجمالي الفرعي
  //     return totalHours * numberOfWorkers * hourlyRate * numberOfDays;
  //   } catch (e) {
  //     print("Error calculating sub total: $e");
  //     return 0.0;
  //   }
  // }
  //
  // // دالة حساب الضريبة
  // double calculateTax() {
  //   final subTotal = calculateSubTotal();
  //   return subTotal * ratio; // حساب الضريبة كنسبة مئوية من الإجمالي الفرعي
  // }
  //
  // // دالة حساب الإجمالي بعد الضريبة
  // double calculateTotalWithTax() {
  //   final subTotal = calculateSubTotal();
  //   final tax = calculateTax();
  //   return subTotal + tax;
  // }
  List<MonthlyPackage> getPackagesForOccupation(String occId) {
    return packagesModel?.where((package) => package.occId == occId).toList() ?? [];
  }
  Future<void> getPackagesData({required String clientId}) async {

    emit(GetPackagesLoadingState());
    final result = await api.getMonthPackageApi(clientId: clientId);
    result.fold(
          (failure) => emit(GetPackagesErrorState('Error loading packages: $failure')),
          (packages) {
        packagesModel = packages.data;
        emit(GetPackagesLoadedState());
      },
    );
  }

  // Future getUserDataWithSession() async {
  //   emit(LoadingGetUserDataWithSession());
  //   print("the client session ${model?.data?.sessionToken}");
  //   Preferences.instance.getUserModelWithSession().then(
  //         (value) {
  //       model = value;
  //       emit(LoadedGetUserDataWithSession());
  //     },
  //   );
  // }
  void getOccupationsData({required String clientId}) async {

    emit(GetOccupationsLoadingState());
    final result = await api.getGetOccupationsApi(clientId: clientId);
    result.fold(
          (failure) {
        emit(GetOccupationsErrorState('Error loading data: $failure'));
      },
          (r) {
        occupationsModel = r;
        emit(GetOccupationsLoadedState());
      },
    );
  }


  GetMonthlyDataModel? getMonthlyDataModel;
  void getMonthlyPackageData({required String clientId}) async {

    emit(GetMonthlyPackageLoadingState());
    final result = await api.getMonthPackageApi(clientId: clientId);
    result.fold(
          (failure) {
        emit(GetMonthlyPackageErrorState('Error loading data: $failure'));
      },
          (r) {
            getMonthlyDataModel = r;

        emit(GetMonthlyPackageLoadedState());
      },
    );
  }
  InsertMonthlyDataModel? insertMonthlyDataModel;
  void insertMonthlyData({
    required BuildContext context,
    required int monthlyRentalMobilePackageId,
    required String totalInvoiceCostIncludeTax,
    required String totalInvoiceCostTax,
    required String totalInvoiceCostTaxRatio,
    required String totalInvoiceCostWithoutTax,
    required int countryId,
    required int occId,
    required String serviceTimeFrom,
    required String serviceTimeTo,
    required int countOfWorkers,
  }) async {
    emit(InsertMonthlyDataLoadingState());
    final result = await api.insertMonthlyDataApi(
      monthlyRentalMobilePackageId: monthlyRentalMobilePackageId,
      totalInvoiceCostIncludeTax: totalInvoiceCostIncludeTax,
      totalInvoiceCostTax: totalInvoiceCostTax,
      totalInvoiceCostTaxRatio: totalInvoiceCostTaxRatio ,
      totalInvoiceCostWithoutTax: totalInvoiceCostWithoutTax,
      countryId: countryId,
      occId: occId,
      serviceTimeFrom: serviceTimeFrom,
      serviceTimeTo: serviceTimeTo,
      countOfWorkers: countOfWorkers,
    );

    result.fold(
          (failure) {
        emit(InsertMonthlyDataErrorState('Error loading data: $failure'));
      },
          (r) {
            insertMonthlyDataModel = r;
        Navigator.pushNamed(
          context,
          Routes.totalDataFromMonthContactRoute,
          arguments: insertMonthlyDataModel,
        );

        emit(InsertMonthlyDataLoadedState());
      },
    );
  }



}
