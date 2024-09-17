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
        body: BlocBuilder<ComplaintsCubit, ComplaintsState>(
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
                : Column(
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
                  child: ListView.builder(
                    controller: _scrollController, // استخدام التحكم في التمرير
                    reverse: false, // جعل القائمة تبدأ من الأسفل
                    shrinkWrap: true,
                    itemCount: cubit.replaiesComplainModel?.data
                        ?.complaintReplies?.length,
                    itemBuilder: (context, index) {
                      var reply = cubit.replaiesComplainModel!.data!
                          .complaintReplies![index];

                      // Set imageUrl if there are attachments and the fileUrlPath is not empty
                      String? imageUrl;
                      if (reply.attachments != null &&
                          reply.attachments!.isNotEmpty &&
                          reply.attachments![0].fileUrlPath != null &&
                          reply.attachments![0].fileUrlPath!.isNotEmpty) {
                        imageUrl = reply.attachments![0]
                            .fileUrlPath; // Correctly assign the file URL
                      }
                      return Column(
                        crossAxisAlignment: reply.byComplainant == "1"
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.end,
                        children: [
                          if (imageUrl != null)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment:
                                reply.byComplainant == "1"
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    child: Image.network(
                                      imageUrl,
                                      width: 150.w,
                                      height: 150.h,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent?
                                          loadingProgress) {
                                        if (loadingProgress == null)
                                          return child; // Display the image once loaded
                                        return Container(
                                          width: 150.w,
                                          height: 150.h,
                                          color: Colors.grey[300], // اللون البديل أثناء التحميل
                                          child: Center(
                                            child:
                                            CircularProgressIndicator(
                                              value: loadingProgress
                                                  .expectedTotalBytes !=
                                                  null
                                                  ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                                  (loadingProgress
                                                      .expectedTotalBytes ??
                                                      1)
                                                  : null,
                                              color: AppColors.blue,
                                            ),
                                          ),
                                        );
                                      },
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return Container(
                                          width: 150.w,
                                          height: 150.h,
                                          color: Colors.grey[300],
                                          child: Center(
                                            child: Icon(Icons.error,
                                                color: Colors.red), // عرض رمز خطأ عند الفشل
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 5.sp),
                                ],
                              ),
                            ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 8.0),
                            decoration: BoxDecoration(
                              color: reply.byComplainant == "1"
                                  ? Colors.grey[300]
                                  : Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  reply.content ?? '',
                                  style: TextStyle(
                                    color: reply.byComplainant == "1"
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                                SizedBox(height: 5.sp),
                                Text(
                                  reply.dateOfReply ?? '',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10.sp),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Container(
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
                        child: SvgPicture.asset(
                          ImageAssets.uploadChatIcon,
                          width: 24.sp,
                          height: 24.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
