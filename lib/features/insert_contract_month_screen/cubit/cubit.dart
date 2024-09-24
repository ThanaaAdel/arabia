

import 'package:arabia/config/routes/app_routes.dart';
import 'package:arabia/core/models/insert_monthly_data_model.dart';
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
