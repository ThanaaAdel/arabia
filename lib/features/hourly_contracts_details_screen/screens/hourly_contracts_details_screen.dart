import 'package:arabia/core/utils/app_colors.dart';
import 'package:arabia/core/utils/assets_manager.dart';
import 'package:arabia/core/widgets/button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../core/widgets/appbar_widget_with_screens.dart';

class HourlyContractsDetailsScreen extends StatelessWidget {
  const HourlyContractsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          AppbarWidgetWithScreens(
            title: "details_order".tr(),
            description: "follow_the_order".tr(),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 55.h,
                  margin: EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                  decoration: BoxDecoration(
                      color: AppColors.baseGrayColor,
                    borderRadius: BorderRadius.circular(8.sp),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 40.h,
                            width: 40.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: AppColors.white),
                            child: Center(
                              child: SvgPicture.asset(
                                ImageAssets.contractMonthIcon,
                                width: 20.sp,
                                height: 20.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          AutoSizeText(
                            'طلب 1',
                            style: TextStyle(fontSize: 18.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                    decoration: BoxDecoration(
                        color: AppColors.baseGrayColor,
                      borderRadius: BorderRadius.circular(8.sp),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "order_number".tr(),
                                  style: TextStyle(color: AppColors.blue),
                                ),
                                Text(
                                  "date".tr(),
                                  style: TextStyle(color: AppColors.blue),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "553212",
                                  style: TextStyle(color: AppColors.black),
                                ),
                                Text(
                                  "23/11/2024",
                                  style: TextStyle(color: AppColors.black),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        const AutoSizeText(
                          'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق. إذا كنت تحتاج إلى عدد أكبر من الفقرات يتيح لك مولد النص العربى زيادة عدد الفقرات كما تريد، النص لن يبدو مقسما ولا يحوي أخطاء لغوية، مولد النص العربى مفيد لمصممي المواقع على وجه الخصوص، حيث يحتاج العميل فى كثير من الأحيان أن يطلع على صورة حقيقية لتصميم الموقع. ومن هنا وجب على المصمم أن يضع نصوصا مؤقتة على التصميم ليظهر للعميل الشكل كاملاً،دور مولد النص العربى أن يوفر على المصمم عناء البحث عن نص بديل لا علاقة له بالموضوع الذى يتحدث عنه التصميم فيظهر بشكل لا يليق. هذا النص يمكن أن يتم تركيبه على أي تصميم دون مشكلة فلن يبدو وكأنه نص منسوخ، غير منظم، غير منسق، أو حتى غير مفهوم. لأنه مازال نصاً بديلاً ومؤقتاً.',
                          maxLines: 18,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                ButtonWidget(textButton: "archiving".tr(), onPressed: () {}),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
