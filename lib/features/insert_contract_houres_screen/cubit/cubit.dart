

import 'package:arabia/config/routes/app_routes.dart';
import 'package:arabia/core/models/get_hourly__package_model.dart';
import 'package:arabia/core/models/insert_hourly_data_model.dart';
import 'package:arabia/core/utils/dialogs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/get_occupations_model.dart';
import '../../../core/remote/service.dart';
import 'state.dart';

class InsertContractHourCubit extends Cubit<InsertContractHourState> {
  InsertContractHourCubit(this.api) : super(MainInitial());

  ServiceApi api;
  GetOccupationsModel?  occupationsModel;
  TextEditingController numberOfWorkersController = TextEditingController();
  TextEditingController fromHourController = TextEditingController();
  TextEditingController toHourController = TextEditingController();
  List<Package>? packagesModel;
  List<DateTime> selectedDatesFromServiceDays = [];
  DateTime? selectedDate;
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
  List<Package> getPackagesForOccupation(String occId) {
    return packagesModel?.where((package) => package.occId == occId).toList() ?? [];
  }
  Future<void> getPackagesData({required String clientId}) async {

    emit(GetPackagesLoadingState());
    final result = await api.getHourlyPackageApi(clientId: clientId);
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


  GetHourlyPackageModel? getHourlyPackageModel;
  void getHourlyPackageData({required String clientId}) async {

    emit(GetHourlyPackageLoadingState());
    final result = await api.getHourlyPackageApi(clientId: clientId);
    result.fold(
          (failure) {
        emit(GetHourlyPackageErrorState('Error loading data: $failure'));
      },
          (r) {
        getHourlyPackageModel = r;

        emit(GetHourlyPackageLoadedState());
      },
    );
  }
  InsertHourlyDataModel? insertHourlyDataModel;
  void insertHourlyData({
    required BuildContext context,
    required String countryId,
    required int occId,
    required int hourlyRentalMobilePackageId,
    required int costWithoutTax,
    required int costTax,
    required int costIncludeTax,
    required int costTaxRatio,
    required int visitPackageId,
    required String serviceTimeTo,
    required String serviceTimeFrom,

    required String countOfWorkers,
  }) async {
    emit(InsertHourlyDataLoadingState());

    // تحويل قائمة التواريخ إلى تنسيق اليوم فقط (yyyy-MM-dd)
    List<String> formattedDates = selectedDatesFromServiceDays.map((date) {
      return DateFormat('yyyy-MM-dd').format(date);
    }).toList();

    final result = await api.insertHourlyDataApi(

      countryId: countryId,
      occId: occId,
      hourlyRentalMobilePackageId: hourlyRentalMobilePackageId,
      serviceTimeFrom: serviceTimeFrom,
      serviceTimeTo: serviceTimeTo,
      daysToServe: formattedDates,
      costWithoutTax: costWithoutTax,
      costTax: costTax,
      costIncludeTax: costIncludeTax,
      costTaxRatio: costTaxRatio,
      countOfWorkers: countOfWorkers,
      visitPackageId: visitPackageId,
    );

    result.fold(
          (failure) {
        emit(InsertHourlyDataErrorState('Error loading data: $failure'));
      },
          (r) {
        insertHourlyDataModel = r;
        Navigator.pushNamed(
          context,
          Routes.totalDataFromHourContactRoute,
          arguments: insertHourlyDataModel,
        );
        successGetBar("insert_hourly_data_success".tr());
        emit(InsertHourlyDataLoadedState());
      },
    );
  }



}
