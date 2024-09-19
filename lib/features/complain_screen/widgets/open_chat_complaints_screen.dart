import 'package:url_launcher/url_launcher.dart';
import 'package:arabia/core/models/opening_complain_model.dart';
import 'package:arabia/core/utils/app_colors.dart';
import 'package:arabia/core/widgets/shared_appbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/utils/assets_manager.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class OpenChatComplainScreen extends StatefulWidget {
  const OpenChatComplainScreen({super.key, required this.replyOpenComplian});
  final Reply replyOpenComplian;

  @override
  State<OpenChatComplainScreen> createState() => _OpenChatComplainScreenState();
}

class _OpenChatComplainScreenState extends State<OpenChatComplainScreen> {
  final ScrollController _scrollController = ScrollController(); // للتحكم في التمرير

  @override
  void initState() {
    super.initState();
    context.read<ComplaintsCubit>().getRepliesComplaints(
        complainId: widget.replyOpenComplian.complaintBasicInfo!.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ComplaintsCubit>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: SharedAppbar(
                text: widget.replyOpenComplian.complaintBasicInfo!
                    .complaintNumber
                    .toString(),
              ),
            ),
            Expanded(
              child: BlocBuilder<ComplaintsCubit, ComplaintsState>(
                builder: (context, state) {
                  if (state is GetRepliesComplaintsLoadedState) {
                    // التمرير إلى الأسفل عند تحميل الرسائل
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    });
                  }

                  return (state is GetRepliesComplaintsLoadingState ||
                      cubit.replaiesComplainModel == null)
                      ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.blue,
                    ),
                  )
                      : ListView.builder(
                    controller: _scrollController,
                    itemCount: cubit.replaiesComplainModel?.data
                        ?.complaintReplies?.length ??
                        0,
                    itemBuilder: (context, index) {
                      var reply = cubit.replaiesComplainModel!.data!
                          .complaintReplies![index];

                      String? imageUrl;
                      if (reply.attachments != null &&
                          reply.attachments!.isNotEmpty &&
                          reply.attachments![0].fileUrlPath != null &&
                          reply.attachments![0].fileUrlPath!.isNotEmpty) {
                        imageUrl = reply.attachments![0].fileUrlPath;
                      }

                      bool isImage = imageUrl != null &&
                          (imageUrl.toLowerCase().endsWith('.png') ||
                              imageUrl.toLowerCase().endsWith('.jpg') ||
                              imageUrl.toLowerCase().endsWith('.jpeg') ||
                              imageUrl.toLowerCase().endsWith('.gif'));


                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                        child: Align(
                          alignment: reply.byComplainant == "1"
                              ? Alignment.centerRight // Align everything to the right if by_complainant is 1
                              : Alignment.centerLeft, // Otherwise, align to the left
                          child: Column(
                            crossAxisAlignment: reply.byComplainant == "1"
                                ? CrossAxisAlignment.end // Align content to the right
                                : CrossAxisAlignment.start, // Align content to the left
                            children: [
                              // إذا كان هناك ملف أو صورة، قم بعرضها هنا
                              if (imageUrl != null)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () async {
                                      final Uri uri = Uri.parse(imageUrl!);

                                      // Using the launchUrl method directly
                                      if (!await launchUrl(
                                        uri,
                                        mode: LaunchMode.externalApplication,
                                      )) {
                                        throw 'Could not launch $imageUrl';
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12.w),
                                        color: AppColors.baseGrayColor,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(12.w),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.file_download, color: AppColors.blue, size: 24.w),
                                            SizedBox(width: 5.w),
                                            Text(
                                              "upload".tr(), // Display "upload"
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: AppColors.blue,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                              // عرض النص، إذا وجد
                              if (reply.content != null && reply.content!.isNotEmpty)
                                Container(
                                  padding: EdgeInsets.all(12.w),
                                  decoration: BoxDecoration(
                                    color: reply.byComplainant == "1"
                                        ? AppColors.blue // Blue background for user messages
                                        : Colors.grey[300], // Grey background for others
                                    borderRadius: BorderRadius.circular(12.w),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: reply.byComplainant == "1"
                                        ? CrossAxisAlignment.end // Align text to the right
                                        : CrossAxisAlignment.start, // Align text to the left for others
                                    children: [
                                      Text(
                                        reply.content ?? '',
                                        style: TextStyle(
                                          color: reply.byComplainant == "1"
                                              ? Colors.white // White text for user messages
                                              : Colors.black, // Black text for other messages
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        reply.dateOfReply ?? '',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 10.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );


                    },
                  );
                },
              ),
            ),
            // Add the message input field container here inside BlocBuilder
            BlocBuilder<ComplaintsCubit, ComplaintsState>(
              builder: (context, state) {
                return Container(
                  height: 50.0.h,
                  padding: EdgeInsets.symmetric(horizontal: 8.0.sp),
                  decoration: BoxDecoration(
                    color: AppColors.blue.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12.0.sp),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (cubit.contactReplyController.text
                              .trim()
                              .isNotEmpty) {
                            cubit.replyFromComplaintData(
                              context: context,
                              complainId: widget.replyOpenComplian
                                  .complaintBasicInfo!.id
                                  .toString(),
                            );
                            cubit.contactReplyController.clear();
                          }
                        },
                        child: (state is ReplyFromComplaintLoadingState)
                            ? const SizedBox()
                            : SvgPicture.asset(
                          ImageAssets.sendChatIcon,
                          width: 24.sp,
                          height: 24.sp,
                          color: const Color(0xffE44200),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: TextFormField(
                          controller: cubit.contactReplyController,
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: "type_your_message".tr(),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onFieldSubmitted: (value) {
                            if (value.trim().isNotEmpty) {
                              cubit.replyFromComplaintData(
                                context: context,
                                complainId: widget.replyOpenComplian
                                    .complaintBasicInfo!.id
                                    .toString(),
                              );
                              cubit.contactReplyController.clear();
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 8.w),
                      GestureDetector(
                        onTap: () {
                          cubit.pickLogoImage();
                        },
                        child: Icon(
                          Icons.photo,
                          color: AppColors.gray,
                          size: 24.sp,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      GestureDetector(
                        onTap: () {
                          cubit.pickFile();
                        },
                        child: SvgPicture.asset(
                          ImageAssets.uploadChatIcon,
                          width: 24.sp,
                          height: 24.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
