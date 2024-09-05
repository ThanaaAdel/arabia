import 'package:arabia/core/widgets/shared_appbar.dart';
import 'package:arabia/features/contarcts_screen/widgets/contacts_container_widget.dart';
import 'package:arabia/features/contarcts_screen/widgets/custom_contract_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/routes/app_routes.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class ContractsScreen extends StatefulWidget {
  const ContractsScreen({super.key});

  @override
  State<ContractsScreen> createState() => _ContractsScreenState();
}

class _ContractsScreenState extends State<ContractsScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ContractsCubit>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.sp),
              child: SharedAppbar(text: "contracts".tr()),
            ),
            SizedBox(
              height: 20.h,
            ),
            BlocBuilder<ContractsCubit, ContractsState>(
              builder: (context, state) {
                return Expanded(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ContractsContainerWidget(
                            selectedIndexOrder: 0,
                            text: "new".tr(),
                            cubit: cubit,
                          ),
                          SizedBox(width: 10.w),
                          ContractsContainerWidget(
                            cubit: cubit,
                            selectedIndexOrder: 1,
                            text: "archiving".tr(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      cubit.selectedIndexOrder == 0
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: 5,
                              itemBuilder: (context, index) => ContractCard(
                                    status: true,
                                    onTap: () => Navigator.pushNamed(
                                        context, Routes.chatComplaintsRoute),
                                  ))
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: 5,
                              itemBuilder: (context, index) => ContractCard(
                                    status: false,
                                    onTap: () => Navigator.pushNamed(
                                        context, Routes.chatComplaintsRoute),
                                  )),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
