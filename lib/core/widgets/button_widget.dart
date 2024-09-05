import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_colors.dart';
import '../utils/style_text.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget(
      {super.key, required this.textButton, this.isLoading, this.onPressed});
  final String textButton;
  final Function()? onPressed;

  bool? isLoading;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: AppColors.blue,
            borderRadius: BorderRadius.circular(16.0.sp),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Center(
              child: (isLoading == true)
                  ? const CircularProgressIndicator()
                  : Text(
                textButton,
                style: TextStyles.size22FontWidgetBoldWhite,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
