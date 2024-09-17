import 'package:arabia/core/utils/app_colors.dart';
import 'package:arabia/core/utils/assets_manager.dart';
import 'package:arabia/core/widgets/shared_appbar.dart';
import 'package:arabia/features/complain_screen/widgets/close_card.dart';
import 'package:arabia/features/complain_screen/widgets/complaints-widget.dart';
import 'package:arabia/features/complain_screen/widgets/open_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/routes/app_routes.dart';
import '../hourly_contracts_screen/widgets/pagination_widget.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class ComplaintsScreen extends StatefulWidget {
  const ComplaintsScreen({super.key});

  @override
  State<ComplaintsScreen> createState() => _ComplaintsScreenState();
}

class _ComplaintsScreenState extends State<ComplaintsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ComplaintsCubit>().getOpenedComplaints();
    context.read<ComplaintsCubit>().getClosedComplaints();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ComplaintsCubit>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: SharedAppbar(text: "complaints".tr()),
            ),
            SizedBox(height: 20.h),
            BlocBuilder<ComplaintsCubit, ComplaintsState>(
              builder: (context, state) {
                if (state is GetOpeningComplaintsLoadingState && cubit.selectedIndexOrder == 0) {
                  return Center(child: CircularProgressIndicator(color: AppColors.blue));
                } else if (state is GetClosedComplaintsLoadingState && cubit.selectedIndexOrder == 1) {
                  return Center(child: CircularProgressIndicator(color: AppColors.blue));
                } else {
                  return Expanded(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ComplaintsContainerWidget(
                              selectedIndexOrder: 0,
                              text: "opened".tr(),
                              cubit: cubit,
                            ),
                            SizedBox(width: 10.w),
                            ComplaintsContainerWidget(
                              cubit: cubit,
                              selectedIndexOrder: 1,
                              text: "closed".tr(),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.sp),
                        if (cubit.selectedIndexOrder == 0)
                          Expanded(
                            child: state is GetOpeningComplaintsErrorState
                                ? _buildNoDataWidget()
                                : cubit.openedComplaintsModel?.data?.replies?.isEmpty ?? true
                                ? _buildNoDataWidget()
                                : Column(
                              children: [
                                Expanded(
                                  child: RefreshIndicator(
                                    onRefresh: () async =>
                                    await context.read<ComplaintsCubit>().getOpenedComplaints(),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const AlwaysScrollableScrollPhysics(),
                                      itemCount: cubit.openedComplaintsModel?.data?.replies?.length ?? 0,
                                      itemBuilder: (context, index) => OpenCard(
                                        complaintBasicInfo: cubit.openedComplaintsModel!.data!.replies![index].complaintBasicInfo!,
                                        onTap: () => Navigator.pushNamed(context, Routes.openChatComplaintsRoute, arguments: cubit.openedComplaintsModel!.data!.replies![index]),
                                      ),
                                    ),
                                  ),
                                ),
                                PaginationWidget(
                                  currentPage: cubit.openCurrentPage,
                                  totalPages: cubit.openTotalPages,
                                  onPageChanged: (page) => cubit.changeOpenPage(page),
                                ),
                              ],
                            ),
                          )
                        else if (cubit.selectedIndexOrder == 1)
                          Expanded(
                            child: state is GetClosedComplaintsErrorState
                                ? _buildNoDataWidget()
                                : cubit.closedComplainModel?.data?.replies?.isEmpty ?? true
                                ? _buildNoDataWidget()
                                : Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    itemCount: cubit.closedComplainModel?.data?.replies?.length ?? 0,
                                    itemBuilder: (context, index) => CloseCard(
                                      complaintBasicInfo: cubit.closedComplainModel!.data!.replies![index].complaintBasicInfo!,

                                    ),
                                  ),
                                ),
                                PaginationWidget(
                                  currentPage: cubit.closedCurrentPage,
                                  totalPages: cubit.closedTotalPages,
                                  onPageChanged: (page) => cubit.changeClosedPage(page),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  );
                }
              },
            ),


          ],
        ),
        floatingActionButton: GestureDetector(
          onTap: () => Navigator.pushNamed(context, Routes.newComplaintRoute),
          child: Container(
            decoration: BoxDecoration(color: AppColors.blue, shape: BoxShape.circle),
            width: 50.w,
            height: 50.h,
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 25.sp,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNoDataWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(ImageAssets.noData, height: 150.h, width: 150.w),
        SizedBox(height: 10.h),
        Center(child: Text("no_data".tr())),
      ],
    );
  }
}
