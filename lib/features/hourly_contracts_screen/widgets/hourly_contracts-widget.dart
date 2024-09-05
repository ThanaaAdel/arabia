import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/app_colors.dart';
import '../cubit/cubit.dart';

class HourlyContractsWidget extends StatelessWidget {
  final String text;
  int selectedIndexOrder;
  HourlyContractsCubit cubit;
  HourlyContractsWidget(
      {super.key,
      required this.text,
      required this.selectedIndexOrder,
      required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          cubit.onTapChangeCurrentOrder(selectedIndexOrder, context);
        },
        child: Container(
          height: MediaQuery.of(context).size.height / 20,
          width: MediaQuery.of(context).size.width / 3,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  width: 3,
                  color: cubit.selectedIndexOrder == selectedIndexOrder
                      ? AppColors.blue1
                      : AppColors.white),
            ),
          ),
          child: Center(
              child: AutoSizeText(
            text,
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: cubit.selectedIndexOrder == selectedIndexOrder
                    ? AppColors.blue1
                    : AppColors.black.withOpacity(0.7)),
          )),
        ),
      ),
    );
  }
}
