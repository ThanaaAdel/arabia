import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/app_colors.dart';
import '../cubit/cubit.dart';

class ContractsContainerWidget extends StatelessWidget {
  final ContractsCubit cubit;
  final int selectedIndexOrder;
  final String text;

  const ContractsContainerWidget({
    super.key,
    required this.cubit,
    required this.selectedIndexOrder,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        cubit.onTapChangeCurrentOrder(selectedIndexOrder, context);
      },
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 16.sp,
              color: cubit.selectedIndexOrder == selectedIndexOrder
                  ? AppColors.blue
                  : Colors.grey,
              fontWeight: cubit.selectedIndexOrder == selectedIndexOrder
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
          if (cubit.selectedIndexOrder == selectedIndexOrder)
            Container(
              height: 2.h,
              width: 60.w,
              color: AppColors.blue,
            ),
        ],
      ),
    );
  }
}
