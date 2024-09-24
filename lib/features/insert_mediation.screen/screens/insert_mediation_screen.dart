import 'package:arabia/core/utils/app_colors.dart';
import 'package:arabia/core/widgets/button_widget.dart';
import 'package:arabia/core/widgets/shared_text_filed.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/widgets/appbar_widget_with_screens.dart';
import '../../../core/widgets/custom_drop_down.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class InsertMediationScreen extends StatefulWidget {
  const InsertMediationScreen({super.key});

  @override
  State<InsertMediationScreen> createState() => _InsertMediationScreenState();
}

class _InsertMediationScreenState extends State<InsertMediationScreen> {
  String? selectedTransferType = 'recovery';
  int? selectedOccupationId; // لحفظ قيمة occId
int?selectedNationalityId;
  // Initial selected value
  @override
  initState() {
    super.initState();
    context.read<InsertMediationCubit>().getReligionsData();
    context.read<InsertMediationCubit>().getExperiencesData();
    context.read<InsertMediationCubit>().getOccupationsData(clientId: 19.toString());
    context.read<InsertMediationCubit>().getCountryData();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<InsertMediationCubit>();

    return SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: Padding(
            padding: EdgeInsets.all(10.0.sp),
            child: BlocBuilder<InsertMediationCubit, InsertMediationState>(
              builder: (context, state) {
                return (cubit.experanceModel == null || cubit.getCountriesModel == null || cubit.occupationsModel == null || cubit.religionsModel == null)? const Center(child: CircularProgressIndicator(),):
                 Form(
                  key: cubit.formKey,
                  child: ListView(
                    children: [
                      AppbarWidgetWithScreens(
                        title: "mediation".tr(),
                        description: "please_enter_the_following_information".tr(),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomDropdownWidget(
                        label: "jop".tr(),
                        onChanged: (String? newValue) {
                          var selectedOccupation = cubit.occupationsModel?.data?.firstWhere(
                                (occupation) => occupation.name == newValue,
                          );
                          setState(() {
                            selectedOccupationId = int.tryParse(selectedOccupation?.id ?? ''); // حفظ occId
                          });
                        },
                        items: cubit.occupationsModel != null && cubit.occupationsModel!.data!.isNotEmpty
                            ? cubit.occupationsModel!.data!.map((e) => e.name!).toList()
                            : [],
                      ),

                      SizedBox(
                        height: 20.h,
                      ),
                      CustomDropdownWidget(
                        label: "nationality".tr(),

                        onChanged: (String? newValue) {

                          var selectedNationality = cubit.getCountriesModel?.data?.firstWhere(
                                (occupation) => occupation.name == newValue,
                          );
                          setState(() {
                            selectedNationalityId = int.tryParse(selectedNationality?.id ?? ''); // حفظ occId
                          });
                        },
                        items: cubit.getCountriesModel != null && cubit.getCountriesModel!.data!.isNotEmpty
                            ? cubit.getCountriesModel!.data!.map((e) => e.name!).toList()
                            : [],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomDropdownWidget(
                        label: "employment_entity".tr(),
                        onChanged: (value) {
                          setState(() {
                            cubit.selectedReligion = value;
                          });
                        },
                        items: cubit.religionsModel?.data?.map((e) => e.name!).toList() ?? [],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomDropdownWidget(
                        label: "experience".tr(),
                        onChanged: (value) {
                          setState(() {
                            cubit.selectedExperience = value;
                          });
                        },
                        items: cubit.experanceModel?.data?.map((e) => e.name!).toList() ?? [],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SharedTextFiled(
                        keyboardType: TextInputType.number,
                        hintText: "visa_number".tr(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please_enter_visa_number'.tr();
                          }
                          if (value.length != 10) {
                            return 'visa_number_must_be_10_digits'.tr(); // رسالة الخطأ إذا لم يكن الطول 10 أرقام
                          }
                          return null;
                        },
                        onSaved: (value) {
                          cubit.visaNo = value;
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      (state is GetMediatationLoadingState)
                          ? Center(child: CircularProgressIndicator(color: AppColors.blue))
                          : ButtonWidget(
                        onPressed: () {
                          if (cubit.formKey.currentState!.validate()) {
                            cubit.formKey.currentState!.save();
                            cubit.insertMediationRequestData(
                              context: context,
                              countryId:selectedNationalityId.toString(),
                              occId: selectedOccupationId ?? 1,
                            );
                          }
                        },
                        textButton: "order_now".tr(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }
}
