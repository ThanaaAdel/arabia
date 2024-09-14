import 'package:arabia/core/models/contract_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../cubit/cubit.dart';

class ContractCard extends StatelessWidget {
  final bool status;
  final Item item;

  const ContractCard({
    super.key,
    required this.status,
    required this.item,
    this.onTap,
  });
  final Function()? onTap;

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
                      onTap: () => _downloadFile(context, item.fileUrlPath, item.filename ?? "file"),
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
                        cubit.archiveContract(item);
                      },
                          child: Container(
                                                height: 23.h,
                                                width: 60.w,
                                                decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.sp),
                            color: AppColors.orange),
                                                child: Center(
                          child: AutoSizeText(
                            "archived".tr(),
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
Future<void> _downloadFile(BuildContext context, String? url, String filename) async {
  if (url == null || url.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Invalid file URL')),
    );
    return;
  }

  try {
    var dio = Dio();
    var dir = await getApplicationDocumentsDirectory(); // Get device storage directory
    String savePath = "${dir.path}/$filename"; // Set the save path for the file

    // Show a loading indicator
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Downloading...')),
    );

    // Download the file
    await dio.download(url, savePath);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Download completed: $savePath')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Download failed: $e')),
    );
  }
}
