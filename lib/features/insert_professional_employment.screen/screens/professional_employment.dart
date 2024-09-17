import 'package:arabia/core/utils/app_colors.dart';
import 'package:arabia/features/insert_professional_employment.screen/screens/widgets/profictionail_employee_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/widgets/appbar_widget_with_screens.dart';
import '../cubit/profissional_emploment_cubit.dart';
import '../cubit/profissional_emploment_state.dart';

class InsertProfessionalEmploymentScreen extends StatefulWidget {
  const InsertProfessionalEmploymentScreen({super.key, required this.clientId});
final String clientId;
  @override
  State<InsertProfessionalEmploymentScreen> createState() => _InsertProfessionalEmploymentScreenState();
}

class _InsertProfessionalEmploymentScreenState extends State<InsertProfessionalEmploymentScreen> {
  @override
  initState() {
    super.initState();
    context.read<InsertProfessionalEmploymentCubit>().getOccupationsData(clientId:widget.clientId);
    context.read<InsertProfessionalEmploymentCubit>().getCountryData();
  }
  Widget build(BuildContext context) {
    var cubit = context.read<InsertProfessionalEmploymentCubit>();
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.all(10.0.sp),
        child: Column(
          children: [
            AppbarWidgetWithScreens(
              title: "professional_employment".tr(),
              description: "please_select_a_profession".tr(),
            ),
            SizedBox(
              height: 20.h,
            ),

            Expanded(
              child: BlocBuilder<InsertProfessionalEmploymentCubit,InsertProfissionalEmplomentState>(
                builder: (context,state) {
                  return (state is GetCountriesLoadingState ||state is GetOccupationsLoadingState || cubit.occupationsData == null || cubit.getCountriesModel == null)?
                  const Center(child: CircularProgressIndicator(),):
                  ListView.builder(
                            itemBuilder: (context, index) =>
                             ProfessionalEmploymentContainer(
                               cubit:cubit.occupationsData!.data![index],
                              onTap: () {
                                Navigator.pushNamed(context, Routes.enterDataProfessionalEmploymentRoute,
                                    arguments: cubit.occupationsData?.data?[index].id ?? '');
                              },
                            ),
                            itemCount: cubit.occupationsData!.data!.length,
                  );
                }
              ),
            )

          ],
        ),
      ),
    ));
  }
}
