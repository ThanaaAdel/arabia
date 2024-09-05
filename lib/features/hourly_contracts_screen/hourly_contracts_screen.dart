import 'package:arabia/core/widgets/shared_appbar.dart';
import 'package:arabia/features/hourly_contracts_screen/widgets/hourly_contracts-widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/routes/app_routes.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'widgets/hourly_contracts_card.dart';

class HourlyContractsScreen extends StatefulWidget {
  const HourlyContractsScreen({super.key});

  @override
  State<HourlyContractsScreen> createState() => _HourlyContractsScreenState();
}

class _HourlyContractsScreenState extends State<HourlyContractsScreen> {
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
              SizedBox(height: 20.h,),
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
                                cubit: cubit,
                                selectedIndexOrder: 1,
                                text: "in_progress".tr(),
                              ),
                              SizedBox(width: 10.w),
                              HourlyContractsWidget(
                                cubit: cubit,
                                selectedIndexOrder: 2,
                                text: "archived".tr(),
                              ),
                            ],
                          ),
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
                               HourlyContractsCard(
                                 onTap: (){
                                   Navigator.pushNamed(context, Routes.hourlyContractsDetailsRoute);
                                 },
                               )

                        ):
                        cubit.selectedIndexOrder == 1?
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: 5,
                            itemBuilder: (context, index) =>
                                 HourlyContractsCard(
                                  onTap: (){
                                    Navigator.pushNamed(context, Routes.hourlyContractsDetailsRoute);
                                  },
                                )

                        )
                            :   ListView.builder(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: 5,
                          itemBuilder: (context, index) =>
                               HourlyContractsCard(
                                 onTap: (){
                                   Navigator.pushNamed(context, Routes.hourlyContractsDetailsRoute);
                                 },
                              )

                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
      )
    );
  }
}


