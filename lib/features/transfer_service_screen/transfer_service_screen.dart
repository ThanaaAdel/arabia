import 'package:arabia/core/utils/app_colors.dart';
import 'package:arabia/core/widgets/shared_appbar.dart';
import 'package:arabia/features/transfer_service_screen/cubit/cubit.dart';
import 'package:arabia/features/transfer_service_screen/cubit/state.dart';
import 'package:arabia/features/transfer_service_screen/widgets/transfer_service-widget.dart';
import 'package:arabia/features/transfer_service_screen/widgets/transfer_service_card.dart';
import 'package:arabia/features/transfer_service_screen/widgets/transfer_service_request_details_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/assets_manager.dart';
import '../hourly_contracts_screen/widgets/pagination_widget.dart';

class TransferServiceScreen extends StatefulWidget {
  const TransferServiceScreen({super.key});

  @override
  State<TransferServiceScreen> createState() => _TransferServiceScreenState();
}

class _TransferServiceScreenState extends State<TransferServiceScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch data for the initial state
    context.read<TransferServiceCubit>().getTransferService();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<TransferServiceCubit>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.sp),
              child: SharedAppbar(text: "transfer_of_services".tr()),
            ),
            SizedBox(height: 20.h),
            BlocBuilder<TransferServiceCubit, TransferServiceCubitState>(
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
                            TransferServiceWidget(
                              selectedIndexOrder: 0,
                              text: "pending".tr(),
                              cubit: cubit,
                            ),
                            SizedBox(width: 10.w),
                            TransferServiceWidget(
                              selectedIndexOrder: 1,
                              text: "in_progress".tr(),
                              cubit: cubit,
                            ),
                            SizedBox(width: 10.w),
                            TransferServiceWidget(
                              selectedIndexOrder: 2,
                              text: "archived".tr(),
                              cubit: cubit,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.sp),
                      if (state is GetTransferServiceLoadingState)
                        Center(child: CircularProgressIndicator(color: AppColors.blue,))
                      else if (state is GetTransferServiceSuccessState) ...[
                        if (cubit.transferServiceModel?.data?.items?.isEmpty ?? true)
                          _buildNoDataWidget()
                        else
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: cubit.transferServiceModel?.data?.items?.length ?? 0,
                              itemBuilder: (context, index) {
                                var item = cubit.transferServiceModel!.data!.items![index];
                                return TransferServiceCard(
                                  item: item,
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => TransferServiceRequestDetailsScreen(
                                      inProgress: item.statusClient == "in_progress" ? true : false,
                                      isArchive: item.statusClient == "archived" ? true : false,
                                      item:
                                    cubit.transferServiceModel!.data!.items![index],
                                      onPressed: () {
                                        cubit.archiveTransferService(itemId: item.id.toString(),context: context);
                                      }
                                      ,),));
                                  },
                                );
                              },
                            ),
                          ),
                        // Pagination controls
                        SizedBox(height: 10.h),
                        if (cubit.transferServiceModel?.data?.items?.isNotEmpty ?? false)
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
