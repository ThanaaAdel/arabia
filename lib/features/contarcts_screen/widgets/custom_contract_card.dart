import 'package:arabia/core/models/contract_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../cubit/cubit.dart';

import 'package:url_launcher/url_launcher.dart'; // إضافة هذه المكتبة

class ContractCard extends StatelessWidget {
  final bool status;
  final Item item;
  final Function()? onTap;

  const ContractCard({
    super.key,
    required this.status,
    required this.item,
    this.onTap,
  });


  Future<void> _openFileInBrowser(BuildContext context, String? url) async {
    if (url == null || url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('invalid_file_url'.tr())),
      );
      return;
    }

    final Uri uri = Uri.parse(url);

    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('could_not_launch_url'.tr())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ContractsCubit>();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80.h,
        margin: EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.baseGrayColor,
          borderRadius: BorderRadius.circular(8.sp),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 40.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.white),
                  child: Center(
                    child: SvgPicture.asset(
                      ImageAssets.contractsIcon,
                      width: 20.sp,
                      height: 20.sp,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                SizedBox(
                  width: 180.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        item.title ?? "",
                        style: TextStyle(color: AppColors.black.withOpacity(0.6)),
                      ),
                      AutoSizeText(
                        item.containsOn ?? '',
                        maxLines: 2,
                        style: TextStyle(color: AppColors.black.withOpacity(0.5)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => _openFileInBrowser(context, item.fileUrlPath), // فتح الرابط في المتصفح
                    child: Container(
                      height: 23.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.sp),
                          color: AppColors.blue),
                      child: Center(
                        child: Icon(
                          Icons.file_download_outlined,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  status
                      ? Container(
                    child: status
                        ? GestureDetector(
                      onTap: () {
                        cubit.archiveContract(fileId: item.fileId.toString(), context: context);
                      },
                      child: Container(
                        height: 23.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.sp),
                            color: AppColors.orange),
                        child: Center(
                          child: AutoSizeText(
                            "archive".tr(),
                            style: TextStyle(color: AppColors.white),
                          ),
                        ),
                      ),
                    )
                        : Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.red),
                      height: 10,
                      width: 10,
                    ),
                  )
                      : const SizedBox(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

