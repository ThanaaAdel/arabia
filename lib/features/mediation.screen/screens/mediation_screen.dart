import 'package:arabia/core/utils/app_colors.dart';
import 'package:arabia/core/widgets/button_widget.dart';
import 'package:arabia/core/widgets/shared_text_filed.dart';
import 'package:arabia/features/mediation.screen/cubit/cubit.dart';
import 'package:arabia/features/mediation.screen/cubit/state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/widgets/appbar_widget_with_screens.dart';
import '../../../core/widgets/custom_drop_down.dart';

class MediationScreen extends StatefulWidget {
  const MediationScreen({super.key});

  @override
  State<MediationScreen> createState() => _MediationScreenState();
}

class _MediationScreenState extends State<MediationScreen> {
  String? selectedTransferType = 'recovery';

  // متغيرات لحفظ البيانات المدخلة
  String? selectedExperience;
  String? selectedReligion;
  String? visaNo;
  int? selectedOccupationId; // لحفظ قيمة occId
int?selectedNationalityId;
  // Initial selected value
  @override
  initState() {
    super.initState();
    context.read<MediatationCubit>().getReligionsData();
    context.read<MediatationCubit>().getExperiencesData();
    context.read<MediatationCubit>().getOccupationsData(clientId: 19.toString());
    context.read<MediatationCubit>().getCountryData();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<MediatationCubit>();

    return SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: Padding(
            padding: EdgeInsets.all(10.0.sp),
            child: BlocBuilder<MediatationCubit, MediatationState>(
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
                          // إيجاد الـ occId بناءً على الوظيفة المختارة
                          var selectedOccupation = cubit.occupationsModel?.data?.firstWhere(
                                (occupation) => occupation.name == newValue,
                          );
                          setState(() {
                            selectedOccupationId = int.tryParse(selectedOccupation?.id ?? ''); // حفظ occId
                          });
                        },
                        items: cubit.occupationsModel != null && cubit.occupationsModel!.data!.isNotEmpty
                            ? cubit.occupationsModel!.data!.map((e) => e.name!).toList()
                            : [], // عرض قائمة فارغة في حالة عدم توفر البيانات
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
                            : [], // عرض قائمة فارغة في حالة عدم توفر البيانات
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomDropdownWidget(
                        label: "employment_entity".tr(),
                        onChanged: (value) {
                          setState(() {
                            selectedReligion = value; // حفظ القيمة المختارة للدين
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
                            selectedExperience = value; // حفظ القيمة المختارة للخبرة
                          });
                        },
                        items: cubit.experanceModel?.data?.map((e) => e.name!).toList() ?? [],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SharedTextFiled(
                        hintText: "visa_number".tr(),
                        onSaved: (value) {
                          visaNo = value; // حفظ رقم الفيزا
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
                              occId: selectedOccupationId ?? 1, // استخدام الـ occId
                              experince: selectedExperience ?? "",
                              religion: selectedReligion ?? "",
                              visaNo: visaNo ?? "",
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
