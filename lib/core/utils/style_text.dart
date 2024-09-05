import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';
import 'package:flutter/material.dart';

import 'font_weight_helper.dart';
class TextStyles {
  static TextStyle size14FontWidget400Black = TextStyle(
      color: AppColors.black,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400);

  static TextStyle size40FontWidgetBoldBlack =
    TextStyle(
      fontSize: 40.sp,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  static TextStyle size16FontWidgetBoldBlackWithOpacity7 = TextStyle(
      color: AppColors.black.withOpacity(0.7),
      fontSize: 16.sp,
      fontFamily: "NotoSanasArabic",
      fontWeight: FontWeightHelper.bold);
  static TextStyle size16FontWidgetBoldBlackWithOpacity6 = TextStyle(
      color: AppColors.black.withOpacity(0.6),
      fontSize: 16.sp,
      fontFamily: "NotoSanasArabic",
      fontWeight: FontWeightHelper.bold);
  static TextStyle size14FontWidgetBoldBlackWithOpacity6 = TextStyle(
       color: AppColors.black.withOpacity(0.6),
      fontSize: 14.sp,
      fontFamily: "NotoSanasArabic",
      fontWeight: FontWeightHelper.bold);
  static TextStyle size16FontWidgetBoldBlack = TextStyle(
      color: AppColors.black,
      fontSize: 14.sp,
      fontFamily: "NotoSanasArabic",
      fontWeight: FontWeightHelper.bold);
  static TextStyle size13FontWidgetSemiBoldBlackWithOpacity6 = TextStyle(
      color: AppColors.black.withOpacity(0.6),
      fontSize: 13.sp,
      fontFamily: "NotoSanasArabic",
      fontWeight: FontWeightHelper.semiBold);
  static TextStyle size11FontWidgetSemiBoldBlackWithOpacity4 = TextStyle(
      color: AppColors.black.withOpacity(0.4),
      fontSize: 11.sp,
      fontFamily: "NotoSanasArabic",
      fontWeight: FontWeightHelper.regular);
  static TextStyle size16FontWidgetRegularBlackWithOpacity7 = TextStyle(
      color: AppColors.black.withOpacity(0.7),
      fontSize: 16.sp,
      fontFamily: "NotoSanasArabic",
      fontWeight: FontWeightHelper.regular);
  ////////// textFromDescriptionPage / ////////////////////////
  static TextStyle size16FontWidgetRegularBlack = TextStyle(
      color: AppColors.black,
      fontSize: 16.sp,
      fontFamily: "NotoSanasArabic",
      fontWeight: FontWeightHelper.regular);
  ////////// homeBaseText / ////////////////////////
  static TextStyle size20FontWidgetBoldOrange = TextStyle(
    color: AppColors.orange,
    fontSize: 20.sp,
    fontFamily: "Lalezar-Regular",
  );
  /////////////// Appbar ///////////////////
  static TextStyle size22FontWidgetBoldBlue =
  TextStyle(
    fontSize: 22.sp,
    color: AppColors.blue,
    fontFamily: "Lalezar-Regular",
  );
  ////////////// textField text ///////////////////
  static TextStyle size16FontWidgetRegularGrayLight =
  TextStyle(fontSize: 16.sp,
      fontWeight:FontWeightHelper.regular,
      fontFamily: "NotoSanasArabic",
      color: AppColors.black.withOpacity(0.5));
  //////// text Button ////////////////////
  static TextStyle size22FontWidgetBoldWhite =
  TextStyle(
      color: AppColors.white,
      fontSize: 22.sp,
    fontWeight: FontWeightHelper.bold,
    fontFamily: "NotoSanasArabic",
  ); static TextStyle size14FontWidgetRegularWhiteWithOpacity8 =
  TextStyle(
      color: AppColors.white.withOpacity(0.8),
      fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    fontFamily: "NotoSanasArabic",
  );
}
