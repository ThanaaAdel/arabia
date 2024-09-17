import 'dart:io';

import 'package:arabia/core/utils/app_colors.dart';
import 'package:arabia/core/widgets/button_widget.dart';
import 'package:arabia/core/widgets/shared_text_filed.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../../core/widgets/shared_appbar.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class NewComplaintScreen extends StatelessWidget {
  const NewComplaintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ComplaintsCubit>();

  return SafeArea(
        child: BlocBuilder<ComplaintsCubit,ComplaintsState>(
          builder: (context,state) {
            return Scaffold(
                  backgroundColor: AppColors.white,
                  body: SingleChildScrollView(
                    child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(20.sp),
                                    child: SharedAppbar(text: "new_complaint".tr()),
                                  ),
                    
                                  Padding(
                                    padding:  EdgeInsets.all(10.0.sp),
                                    child: Column(
                    children: [
                      SizedBox(height: 20.h,),
                      SharedTextFiled(
                        controller: cubit.contactController,
                        maxLines: 11,
                        hintText: "contact_complain".tr(),
                        onSaved: (p0) {},
                      ),
                      SizedBox(height: 20.h,),
                                    GestureDetector(
                    onTap: () {
                      cubit.pickLogoImage();
                    },
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(8.sp),
                      color: AppColors.gray2, // Set the color of the dotted border
                      dashPattern: const [8, 8], // Customize the dash pattern
                      strokeWidth: 1, // Set the width of the border
                      child:cubit.selectedImage != null?
                      SizedBox(
                        height: 150.h,
                        child: Image.file(
                          File(cubit.selectedImage!),
                          height: 30.h,
                          fit: BoxFit.cover,
                        ),
                      ):
                      Container(
                        height: 60.h,
                        width: double.infinity,
                        color: AppColors.blue.withOpacity(0.08),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.file_upload_outlined,
                              size: 30.sp,
                              color: AppColors.orange,
                            )
                          ],
                        ),
                      ),
                    ),
                                    ),
                      SizedBox( height: 20.h,),
                      SizedBox(height:cubit.selectedImage != null ? 20.h : 50.h,),
                      (state is AddRepliesComplaintsLoadingState)?
                      Center(child: CircularProgressIndicator(
                          color: AppColors.blue),) :
                      ButtonWidget(textButton: "send".tr(),
                          onPressed: () {
                        cubit.addNewComplaint(context);
                    
                      },),
                    ],
                                    ),
                                  )
                                ],
                    ),
                  ),
                );
          }
        ));
  }
}
