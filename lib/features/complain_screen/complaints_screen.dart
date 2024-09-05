import 'package:arabia/core/utils/app_colors.dart';
import 'package:arabia/core/widgets/shared_appbar.dart';
import 'package:arabia/features/complain_screen/widgets/complaints-widget.dart';
import 'package:arabia/features/complain_screen/widgets/custom_complaint_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/routes/app_routes.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class ComplaintsScreen extends StatefulWidget {
  const ComplaintsScreen({super.key});

  @override
  State<ComplaintsScreen> createState() => _ComplaintsScreenState();
}

class _ComplaintsScreenState extends State<ComplaintsScreen> {
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
              SizedBox(height: 20.h,),
              BlocBuilder<ComplaintsCubit, ComplaintsState>(
                builder: (context, state) {
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
                            SizedBox(width:10.w),
                            ComplaintsContainerWidget(
                              cubit: cubit,
                              selectedIndexOrder: 1,
                              text: "closed".tr(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.sp,
                        ),
                        cubit.selectedIndexOrder == 0
                            ?    ListView.builder(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: 5,
                          itemBuilder: (context, index) =>
                              ComplaintCard(
                                status: true,
                                onTap: () => Navigator.pushNamed(
                                    context, Routes.chatComplaintsRoute),
                              )

                        )
                            :   ListView.builder(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: 5,
                          itemBuilder: (context, index) =>
                              ComplaintCard(
                                status: false,
                                onTap: () => Navigator.pushNamed(
                                    context, Routes.chatComplaintsRoute),
                              )

                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
          floatingActionButton: GestureDetector(
            onTap: () => Navigator.pushNamed(context, Routes.newComplaintRoute),
            child: Container(
              decoration:
                  BoxDecoration(color: AppColors.blue, shape: BoxShape.circle),
              width: 50.w,
              height: 50.h,
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 25.sp,
              ),
            ),
          )),
    );
  }
}


