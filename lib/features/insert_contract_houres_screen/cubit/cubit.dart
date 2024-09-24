

import 'package:arabia/config/routes/app_routes.dart';
import 'package:arabia/core/models/get_hourly__package_model.dart';
import 'package:arabia/core/models/insert_hourly_data_model.dart';
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
    required double costWithoutTax,
    required double costTax,
    required double costIncludeTax,
    required double costTaxRatio,
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

        _resetFields(
          countOfWorkers: countOfWorkers,
          serviceTimeFrom: serviceTimeFrom,
          serviceTimeTo: serviceTimeTo,
          formattedDates: formattedDates
        );


        emit(InsertHourlyDataLoadedState());
      },
    );
  }


  void _resetFields({ required String serviceTimeTo,
    required String serviceTimeFrom,required String countOfWorkers, List<String>? formattedDates }) {
    serviceTimeTo = '';
    serviceTimeFrom = '';
    countOfWorkers = '';
    formattedDates =[];
    selectedDatesFromServiceDays.clear();
    numberOfWorkersController.clear();
    fromHourController.clear();
    toHourController.clear();
    selectedDate = null;
  }




}
