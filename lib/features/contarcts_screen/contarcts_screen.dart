import 'package:arabia/core/widgets/shared_appbar.dart';
import 'package:arabia/features/contarcts_screen/widgets/contacts_container_widget.dart';
import 'package:arabia/features/contarcts_screen/widgets/custom_contract_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/assets_manager.dart';
import '../../core/utils/style_text.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class ContractsScreen extends StatefulWidget {
  const ContractsScreen({super.key});

  @override
  State<ContractsScreen> createState() => _ContractsScreenState();
}

class _ContractsScreenState extends State<ContractsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch contract data when the screen is initialized
    context.read<ContractsCubit>().getContractData();
  }


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
              return  Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 80.sp),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      text: "archive".tr(),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.sp,
                              ),
                              (state is GetContractsLoadingState)
                                  ? Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.blue,
                                ),
                              )
                                  : (cubit.contractModel?.data?.items?.length == 0)
                                  ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 100.h,
                                  ),
                                  Image.asset(
                                    ImageAssets.noData,
                                    height: 150.h,
                                    width: 150.w,
                                  ),
                                  Text("no_data".tr(),
                                      style: TextStyles.size22FontWidgetBoldBlue)
                                ],
                              )
                                  :
                              Expanded(
                                child: ListView.builder(
                                  itemCount:
                                      cubit.contractModel!.data!.items!.length,
                                  itemBuilder: (context, index) {
                                    var contract = cubit
                                        .contractModel!.data!.items![index];
                                    return ContractCard(
                                      item: contract,
                                      status: cubit.selectedIndexOrder == 0,
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        );
            }),
          ],
        ),
      ),
    );
  }
}
