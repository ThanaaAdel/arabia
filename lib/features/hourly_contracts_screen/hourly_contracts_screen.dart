import 'package:arabia/core/utils/app_colors.dart';
import 'package:arabia/core/widgets/shared_appbar.dart';
import 'package:arabia/features/hourly_contracts_screen/widgets/hourly_contract_request_details_screen.dart';
import 'package:arabia/features/hourly_contracts_screen/widgets/hourly_contracts-widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/assets_manager.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'widgets/hourly_contracts_card.dart';
import 'widgets/pagination_widget.dart'; // Import your pagination widget

class HourlyContractsScreen extends StatefulWidget {
  const HourlyContractsScreen({super.key});

  @override
  State<HourlyContractsScreen> createState() => _HourlyContractsScreenState();
}

class _HourlyContractsScreenState extends State<HourlyContractsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch data for the initial state
    context.read<HourlyContractsCubit>().getHourlyContract();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<HourlyContractsCubit>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.sp),
              child: SharedAppbar(text: "hourly_contracts".tr()),
            ),
            SizedBox(height: 20.h),
            BlocBuilder<HourlyContractsCubit, HourlyContractsState>(
              builder: (context, state) {
                return Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            HourlyContractsWidget(
                              selectedIndexOrder: 0,
                              text: "pending".tr(),
                              cubit: cubit,
                            ),
                            SizedBox(width: 10.w),
                            HourlyContractsWidget(
                              selectedIndexOrder: 1,
                              text: "in_progress".tr(),
                              cubit: cubit,
                            ),
                            SizedBox(width: 10.w),
                            HourlyContractsWidget(
                              selectedIndexOrder: 2,
                              text: "archived".tr(),
                              cubit: cubit,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.sp),
                      if (state is GetHourlyContractLoadingState)
                        Center(child: CircularProgressIndicator(color: AppColors.blue,))
                      else if (state is GetHourlyContractSuccessState) ...[
                        if (cubit.hourlyContractModel?.data?.items?.isEmpty ?? true)
                          _buildNoDataWidget()
                        else
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: cubit.hourlyContractModel?.data?.items?.length ?? 0,
                              itemBuilder: (context, index) {
                                var item = cubit.hourlyContractModel!.data!.items![index];
                                return HourlyContractsCard(
                                  item: item,
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => HourlyContractRequestDetailsScreen(
                                      isArchive: item.statusClient == "archived" ? true : false,
                                      item:
                                    cubit.hourlyContractModel!.data!.items![index],
                                      onPressed: () {
                                        cubit.archiveHourlyContract(itemId: item.id.toString(),context: context);
                                      }
                                      ,),));
                                  },
                                );
                              },
                            ),
                          ),
                        // Pagination controls
                        SizedBox(height: 10.h),
                        if (cubit.hourlyContractModel?.data?.items?.isNotEmpty ?? false)
                        PaginationWidget(
                          currentPage: cubit.pageNo,
                          totalPages: cubit.totalPages,
                          onPageChanged: (page) {
                            cubit.changePage(page); // This will call the function to change pages
                          },
                        ),
                      ] else
                        Center(child: Text("no_data".tr())),
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

  // No data widget
  Widget _buildNoDataWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 100.h),
        Image.asset(ImageAssets.noData, width: 200.w, height: 200.h),
        SizedBox(height: 20.h),
        Text(
          "no_data".tr(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22.sp,
            color: AppColors.blue,
          ),
        ),
      ],
    );
  }
}
