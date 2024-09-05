import 'package:arabia/core/utils/app_colors.dart';
import 'package:arabia/core/utils/assets_manager.dart';
import 'package:arabia/core/widgets/shared_appbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../../core/utils/style_text.dart';

class OfferDetailsScreen extends StatelessWidget {
  const OfferDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.white,
      body: Column(children: [
        Padding(
          padding:  EdgeInsets.all(20.0.sp),
          child: SharedAppbar(text: "offers_details".tr()),
        ),
Expanded(
  child: Column(children: [
    Container(
      height: 55.h,
      margin: EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      decoration: BoxDecoration(
          color: AppColors.baseGrayColor,
        borderRadius: BorderRadius.circular(8.sp),),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,color: AppColors.white),
                child: Center(child: SvgPicture.asset(ImageAssets.offerIcon,width: 20.sp,height: 20.sp,),),),
              SizedBox(width: 10.w,),
              AutoSizeText(
                'عرض 1',
                style: TextStyles.size16FontWidgetBoldBlackWithOpacity6
              ),
            ],
          ),
  
        ],
      ),
    ),
    Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.baseGrayColor,
              borderRadius: BorderRadius.circular(8.sp),),
            child: AutoSizeText(
              'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق. إذا كنت تحتاج إلى عدد أكبر من الفقرات يتيح لك مولد النص العربى زيادة عدد الفقرات كما تريد، النص لن يبدو مقسما ولا يحوي أخطاء لغوية، مولد النص العربى مفيد لمصممي المواقع على وجه الخصوص، حيث يحتاج العميل فى كثير من الأحيان أن يطلع على صورة حقيقية لتصميم الموقع. ومن هنا وجب على المصمم أن يضع نصوصا مؤقتة على التصميم ليظهر للعميل الشكل كاملاً،دور مولد النص العربى أن يوفر على المصمم عناء البحث عن نص بديل لا علاقة له بالموضوع الذى يتحدث عنه التصميم فيظهر بشكل لا يليق. هذا النص يمكن أن يتم تركيبه على أي تصميم دون مشكلة فلن يبدو وكأنه نص منسوخ، غير منظم، غير منسق، أو حتى غير مفهوم. لأنه مازال نصاً بديلاً ومؤقتاً.', style: TextStyles.size16FontWidgetRegularBlackWithOpacity7,

            ),
          ),
        ],
      ),
    ),
  ],),
)
      ],),
    ));
  }
}


