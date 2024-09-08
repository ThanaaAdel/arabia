import 'package:arabia/core/utils/app_colors.dart';
import 'package:arabia/core/widgets/button_widget.dart';
import 'package:arabia/core/widgets/shared_appbar.dart';
import 'package:arabia/core/widgets/shared_text_filed.dart';
import 'package:arabia/features/login/cubit/cubit.dart';
import 'package:arabia/features/login/cubit/state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/style_text.dart';
import '../../../core/widgets/custom_drop_down.dart';

class CompleteTheRegistrationDataScreen extends StatefulWidget {
  const CompleteTheRegistrationDataScreen({super.key});

  @override
  State<CompleteTheRegistrationDataScreen> createState() => _CompleteTheRegistrationDataScreenState();
}

class _CompleteTheRegistrationDataScreenState extends State<CompleteTheRegistrationDataScreen> {
  @override
  void initState() {
    context.read<LoginCubit>().getHouseAccommodationTypeData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<LoginCubit>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Padding(
          padding: EdgeInsets.all(10.0.sp),
          child: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return Form(
                key: cubit.formKeyCompleteRegister,
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      children: [
                        SharedAppbar(
                          text: "complete_the_registration_data".tr(),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 280.w,
                              child: Text(
                                "complete_the_registration_data_text".tr(),
                                style: TextStyles.size16FontWidgetRegularBlack,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SharedTextFiled(
                          controller: cubit.firstNameController,
                          onSaved: (value) {},
                          hintText: "first_name".tr(),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SharedTextFiled(
                          controller: cubit.lastNameController,
                          onSaved: (value) {},
                          hintText: "last_name".tr(),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomDropdownWidget(
                          label: "type_of_stay".tr(),
                          onChanged: (p0) {
                            setState(() {
                              cubit.selectTypeOfStayValue(p0.toString());
                            });
                          },
                          items: cubit.houseAccommondationTypeModel?.data
                              ?.map((e) => e.title ?? '')
                              .toList() ??
                              [],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomDropdownWidget(
                          label: "number_of_children".tr(),
                          onChanged: (number) {
                            cubit.selectChildrenNumber(number.toString());
                          },
                          items: const ["5", "4", "3", "2", "1"],
                        ),
                         SizedBox(
                          height: 120.h,
                        ),
                        (state is CompleteRegisterLoadingState)
                            ? Container(
                                padding: EdgeInsets.all(20.sp),
                                height: 40.h,
                                width: 120.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.sp),
                                    color: AppColors.blue),
                                child: Center(
                                  child: CircularProgressIndicator(
                                      color: AppColors.white),
                                ))
                            : ButtonWidget(
                          textButton: "save".tr(),
                          onPressed: () {
                            if (cubit.formKeyCompleteRegister.currentState!
                                .validate()) {
                              cubit.completeRegisterData(context);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
