import 'package:arabia/core/widgets/button_widget.dart';
import 'package:arabia/features/login/cubit/cubit.dart';
import 'package:arabia/features/login/cubit/state.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:arabia/core/utils/app_colors.dart';
import 'package:arabia/core/utils/assets_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/utils/dialogs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController countryCodeController;
  late TextEditingController phoneNumberController;
  GlobalKey<FormState> formKeyOtp = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    countryCodeController = TextEditingController(text: '+966');
    phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    // countryCodeController.dispose();
    // phoneNumberController.dispose();
    // formKeyOtp.();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<LoginCubit>();
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(ImageAssets.loginBackgroundImage))),
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 200.h),
                SvgPicture.asset(
                  ImageAssets.splashTextImage,
                  width: 200.w,
                ),
                SizedBox(height: 50.h),
                Form(
                  key: formKeyOtp,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        // Country Code Field
                        Container(
                          height: 60.h,
                          decoration: BoxDecoration(
                            color: AppColors.baseGrayColor,
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          child: CountryCodePicker(
                            onChanged: (value) {
                              cubit.countryCode = value.toString();
                              print("country code: ${cubit.countryCode}");
                            },
                            initialSelection: 'SA',
                            showFlag: false,
                          ),
                        ),

                        // Spacer between fields
                        SizedBox(width: 10.sp),

                        // Phone Number Field
                        Expanded(
                          child: Container(
                            height: 60.h,
                            decoration: BoxDecoration(
                              color: AppColors.baseGrayColor,
                              borderRadius: BorderRadius.circular(8.sp),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0.sp),
                              child: TextFormField(
                                controller: phoneNumberController,
                                keyboardType: TextInputType.number,
                                cursorRadius: Radius.circular(8.sp),
                                autofocus: true,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: AppColors.grayLite),
                                  ),
                                  hintText: "5xxxxxxxxx",
                                ),
                                onChanged: (phone) {
                                  cubit.phoneEditingController.text = phone;
                                  print(
                                      "Phone Number: ${cubit.phoneEditingController.text}");
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
                (state is LoadingState)
                    ? CircularProgressIndicator(
                    backgroundColor: AppColors.blue,
                    color: AppColors.white)
                    : ButtonWidget(
                  onPressed: () {
                    if (formKeyOtp.currentState!.validate()) {
                      if (cubit.phoneEditingController.text.isEmpty) {
                        errorGetBar("please_enter_your_phone_number".tr());
                      } else {
                        cubit.loginData(context);
                      }
                    }
                  },
                  textButton: "login".tr(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
