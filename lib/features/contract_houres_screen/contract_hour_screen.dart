import 'package:arabia/core/utils/assets_manager.dart';
import 'package:arabia/features/contract_houres_screen/cubit/cubit.dart';
import 'package:arabia/features/contract_houres_screen/cubit/state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../config/routes/app_routes.dart';
import '../../core/models/get_hourly__package_model.dart';
import '../../core/models/login_with_client_id_model.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/style_text.dart';
import '../../core/widgets/appbar_widget_with_screens.dart';

class ContractHourScreen extends StatelessWidget {
  const ContractHourScreen({super.key, required this.loginWithClientIdModel});
  final LoginWithClientIdModel loginWithClientIdModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            AppbarWidgetWithScreens(
              title: "contract_hours".tr(),
              description: "please_select_a_profession_and_package".tr(),
            ),
            SizedBox(height: 20.h),
             Expanded(child: CustomExpandableWidget(loginWithClientIdModel: loginWithClientIdModel,)),
          ],
        ),
      ),
    );
  }
}

class CustomExpandableWidget extends StatefulWidget {
  const CustomExpandableWidget({super.key, required this.loginWithClientIdModel});
  final LoginWithClientIdModel loginWithClientIdModel;

  @override
  State<CustomExpandableWidget> createState() => _CustomExpandableWidgetState();
}

class _CustomExpandableWidgetState extends State<CustomExpandableWidget> {
  @override
  void initState() {
    super.initState();
    context.read<ContractHourCubit>().getOccupationsData(clientId: widget.loginWithClientIdModel.data!.clientId!);
    context.read<ContractHourCubit>().getPackagesData(clientId: widget.loginWithClientIdModel.data!.clientId!);
    context.read<ContractHourCubit>().getHourlyPackageData(clientId: widget.loginWithClientIdModel.data!.clientId!);
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ContractHourCubit>();
    return BlocBuilder<ContractHourCubit, ContractHourState>(
      builder: (context, state) {
        if (state is LoadingGetUserDataWithSession ||state is GetOccupationsLoadingState || cubit.occupationsModel == null || state is GetPackagesLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (cubit.occupationsModel?.data!.isNotEmpty ?? false) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 4.0.h),
              itemCount: cubit.occupationsModel!.data!.length,
              itemBuilder: (context, index) {
                final occupation = cubit.occupationsModel!.data![index];
                final packages = cubit.getPackagesForOccupation(occupation.id!);

                return _buildOccupationCard(occupation.name ?? '', packages, context);
              },
            );
          } else {
            return const Center(child: Text('No Occupations Available'));
          }
        }
      },
    );
  }

  Widget _buildOccupationCard(String occupationName, List<Package> packages, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0.h),
      child: Card(
        clipBehavior: Clip.antiAlias,
        borderOnForeground: false,
        shadowColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        color: AppColors.blue.withOpacity(0.08),
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.circular(8.0.sp),
        ),
        child: ExpansionTile(
          leading: Container(
            height: 25.h,
            width: 25.w,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              ImageAssets.settingsIcon,
              height: 10.h,
              width: 10.w,
              fit: BoxFit.none,
            ),
          ),
          title: Text(
            occupationName,
            style: TextStyles.size16FontWidgetBoldBlackWithOpacity6,
          ),
          trailing: Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.orange,
            size: 25.sp,
          ),
          children: packages.isNotEmpty
              ? packages.map((pkg) => _buildPackageItem(pkg, context)).toList()
              : [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0.h),
              child: const Center(child: Text('No Packages Available')),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPackageItem(Package package, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 3.0.h),
      child: SizedBox(
        width: double.infinity,
        height: 30.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.blue.withOpacity(0.9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0.sp),
            ),
          ),
          onPressed: () {

            Navigator.pushNamed(context, Routes.choosePackageFromContractHourRoute,arguments:{
              'package': package,
              'cubit': context.read<ContractHourCubit>(),
            } );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                package.name ?? 'No Package Name',
                style: TextStyles.size14FontWidgetRegularWhiteWithOpacity8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
