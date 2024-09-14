import 'package:arabia/core/utils/app_colors.dart';
import 'package:arabia/features/home_screen/cubit/cubit.dart';
import 'package:arabia/features/home_screen/screens/widgets/custom_list_view.dart';
import 'package:arabia/features/home_screen/screens/widgets/appbar_home_screen.dart';
import 'package:arabia/features/home_screen/screens/widgets/services_widget.dart';
import 'package:arabia/features/home_screen/screens/widgets/visit_offer_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/style_text.dart';
import '../cubit/state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeCubit>().getUserDataWithSession();
    context.read<HomeCubit>().getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<HomeCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        return (state is LoadingGetUserDataWithSession ||
                state is GetProfileLoadingState ||
                cubit.model == null ||
                cubit.getProfileDataModel == null)
            ?  Center(
                child: CircularProgressIndicator(color: AppColors.blue,),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    AppbarHomeScreen(
                      getProfileDataModel: cubit.getProfileDataModel,
                    ),
                    VisitsOffersWidget(
                      loginWithClientIdModel: cubit.model!,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                     ServicesWidget(
                      clientId: cubit.model?.data?.clientId ?? '',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10.h, left: 10.w, right: 10.w),
                          child: AutoSizeText("administrative_services".tr(),
                              style: TextStyles.size20FontWidgetBoldOrange),
                        ),
                      ],
                    ),
                    const CustomListView()
                  ],
                ),
              );
      }),
    );
  }
}
