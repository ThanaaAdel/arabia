import 'package:arabia/core/utils/app_colors.dart';
import 'package:arabia/core/utils/assets_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/models/notification_model.dart';
import '../../../core/utils/style_text.dart';
import '../../../core/widgets/shared_appbar.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}
String formatDate(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

  return formattedDate;
}
class _NotificationScreenState extends State<NotificationScreen> {
@override
  void initState() {
    context.read<NotificationCubit>().getNotificationData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  var cubit = context.read<NotificationCubit>();
    return SafeArea(
      child: Scaffold(
      backgroundColor: AppColors.white,
        body: Column(
          children: [
            Padding(
              padding:  EdgeInsets.all(20.0.sp),
              child: SharedAppbar(text: "notification".tr()),
            ),
            BlocBuilder<NotificationCubit, NotificationState>(
              builder: (context,state) {
                return
                  (state is GetNotificationLoadingState)? Center(child: CircularProgressIndicator(color: AppColors.blue,),):
                  (cubit.notificationModel?.data?.notifications?.length == 0)?
                  Column(
                    mainAxisAlignment:  MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 100.h,),
                    Image.asset(ImageAssets.noData,height: 150.h,width: 150.w,),
                    Text("no_data".tr(),style: TextStyles.size22FontWidgetBoldBlue)
                  ],)
                  :Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0.w),
                    child: ListView.builder(
                      itemCount: cubit.notificationModel?.data?.notifications?.length ?? 0, // Replace with your actual item count
                      itemBuilder: (context, index) {
                        return _buildCustomListItem(isHighlighted: index == 0,
                        notification: cubit.notificationModel!.data!.notifications![index]

                        );
                      },
                    ),
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomListItem(
      {required bool isHighlighted,required  NotificationData notification}) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color:  AppColors.blue.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: ListTile(
        leading: Container(
          height: 35.h,
          width: 35.w,
          decoration: BoxDecoration(color: AppColors.white,shape: BoxShape.circle),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              ImageAssets.notificationIconPage),
          )),
        title: Text(
             notification.description.toString(),
          style: TextStyles.size13FontWidgetSemiBoldBlackWithOpacity6
        ),

        subtitle: Padding(
          padding:  EdgeInsets.only(top: 5.0.h),
          child: Text(
              formatDate( notification.dateOfNotify.toString()),
            style: TextStyles.size11FontWidgetSemiBoldBlackWithOpacity4
          ),
        ),
      ),
    );
  }
}


