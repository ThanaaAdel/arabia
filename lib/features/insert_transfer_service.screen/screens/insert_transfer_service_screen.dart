import 'package:arabia/core/utils/app_colors.dart';
import 'package:arabia/core/widgets/button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/widgets/appbar_widget_with_screens.dart';
import '../../../core/widgets/custom_drop_down.dart';
import '../cubit/insert_transfer_service_cubit.dart';
import '../cubit/insert_transfer_service_state.dart';

class InsertTransferServiceScreen extends StatefulWidget {
  const InsertTransferServiceScreen({super.key, required this.clientId});
  final String clientId;

  @override
  State<InsertTransferServiceScreen> createState() => _InsertTransferServiceScreenState();
}

class _InsertTransferServiceScreenState extends State<InsertTransferServiceScreen> {
  String? selectedTransferType = 'recovery'; // Initial selected value
  String? selectedCountryId;
  String? selectedOccupationId;
  String? selectedReligion;
  String? selectedServiceType;

  @override
  void initState() {
    context.read<InsertTransferServiceCubit>().getCountryData();
    context.read<InsertTransferServiceCubit>().getReligionsData();
    context.read<InsertTransferServiceCubit>().getTransferServiceTypeData();
    context.read<InsertTransferServiceCubit>().getOccupationsData(clientId: widget.clientId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<InsertTransferServiceCubit>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Padding(
          padding: EdgeInsets.all(10.0.sp),
          child: BlocBuilder<InsertTransferServiceCubit, InsertTransferServiceState>(
            builder: (context, state) {
              return (cubit.religionsModel == null ||
                  cubit.getCountriesModel == null ||
                  cubit.occupationsModel == null)
                  ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.blue,
                ),
              )
                  : Column(
                children: [
                  AppbarWidgetWithScreens(
                    title: "transfer_of_services".tr(),
                    description: "please_enter_the_following_information".tr(),
                  ),
                  SizedBox(height: 20.h),
                  // Occupation Dropdown
                  CustomDropdownWidget(
                    label: "current_employment_entity".tr(),
                    onChanged: (p0) {
                      var currentSelectedOccupation = cubit.occupationsModel!.data!.firstWhere(
                            (occupation) => occupation.name == p0,
                      );
                      cubit.selectedOccupationId = currentSelectedOccupation.id;
                      cubit.selectedOccupation = currentSelectedOccupation.name;
                      selectedOccupationId = cubit.selectedOccupationId.toString();
                    },
                    items: cubit.occupationsModel!.data!.map((e) => e.name!).toList(),
                  ),
                  SizedBox(height: 20.h),
                  // Country Dropdown
                  CustomDropdownWidget(
                    label: "current_employment_country".tr(),
                    onChanged: (selectedName) {
                      var selectedCountry = cubit.getCountriesModel!.data!.firstWhere(
                            (country) => country.name == selectedName,
                      );
                      cubit.selectedCountryId = selectedCountry.id;
                      selectedCountryId = cubit.selectedCountryId.toString();
                    },
                    items: cubit.getCountriesModel!.data!.map((e) => e.name!).toList(),
                  ),
                  SizedBox(height: 20.h),
                  // Religion Dropdown
                  CustomDropdownWidget(
                    label: "current_employment_nationality".tr(),
                    onChanged: (selectedName) {
                      var selectedReligion = cubit.religionsModel!.data!.firstWhere(
                            (country) => country.name == selectedName,
                      );
                      cubit.religionName = selectedReligion.name;
                      this.selectedReligion = selectedReligion.name;
                    },
                    items: cubit.religionsModel!.data!.map((e) => e.name!).toList(),
                  ),
                  SizedBox(height: 20.h),
                  // Transfer Service Option
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                    decoration: BoxDecoration(
                      color: AppColors.blue.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(8.0.sp),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        Text("transfer_type".tr(), style: TextStyle(fontSize: 16.sp)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: cubit.getTransferServiceTypeModel?.data?.map((serviceType) {
                            return Row(
                              children: [
                                Radio(
                                  value: serviceType.id,
                                  groupValue: cubit.serviceType,
                                  onChanged: (value) {
                                    setState(() {
                                      cubit.serviceType = value.toString();
                                      selectedServiceType = value.toString();
                                    });
                                  },
                                  activeColor: Colors.blue,
                                ),
                                Text(
                                  serviceType.title ?? "",
                                  style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
                                ),
                              ],
                            );
                          }).toList() ?? [],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Expanded(child: Container()),
                  (state is InsertTransferServiceLoadingState)
                      ? Center(
                    child: CircularProgressIndicator(color: AppColors.blue),
                  )
                      : ButtonWidget(
                    onPressed: () {
                      if (_validateInputs(cubit)) {
                        cubit.insertTransferServiceRequestData(context: context);
                      }
                    },
                    textButton: "order_now".tr(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  bool _validateInputs(InsertTransferServiceCubit cubit) {
    if (cubit.selectedOccupationId == null) {
      _showErrorDialog("please_select_employment_entity".tr());
      return false;
    }
    if (cubit.selectedCountryId == null) {
      _showErrorDialog("please_select_country".tr());
      return false;
    }
    if (cubit.religionName == null) {
      _showErrorDialog("please_select_religion".tr());
      return false;
    }
    if (cubit.serviceType == null) {
      _showErrorDialog("please_select_transfer_type".tr());
      return false;
    }
    return true;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("error".tr()),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("ok".tr()),
          ),
        ],
      ),
    );
  }
}
