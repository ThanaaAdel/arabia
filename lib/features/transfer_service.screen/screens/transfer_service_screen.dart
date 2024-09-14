import 'package:arabia/core/utils/app_colors.dart';
import 'package:arabia/core/widgets/button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/widgets/appbar_widget_with_screens.dart';
import '../../../core/widgets/custom_drop_down.dart';
import '../cubit/transfer_service_cubit.dart';
import '../cubit/transfer_service_state.dart';

class TransferServiceScreen extends StatefulWidget {
  const TransferServiceScreen({super.key, required this.clientId});
 final String clientId;
  @override
  State<TransferServiceScreen> createState() => _TransferServiceScreenState();
}

class _TransferServiceScreenState extends State<TransferServiceScreen> {
  String? selectedTransferType = 'recovery';
 // Initial selected value
  @override
  void initState() {
    context.read<TransferServiceCubit>().getCountryData();
    context.read<TransferServiceCubit>().getReligionsData();
    context.read<TransferServiceCubit>().getTransferServiceTypeData();
    context.read<TransferServiceCubit>().getOccupationsData(clientId:widget.clientId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<TransferServiceCubit>();
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.all(10.0.sp),
        child: BlocBuilder<TransferServiceCubit, TransferServiceState>(
          builder: (context,state) {
            return ( cubit.religionsModel == null || cubit.getCountriesModel == null || cubit.occupationsModel == null) ?
            Center(child: CircularProgressIndicator( color: AppColors.blue,),):
            Column(
              children: [
                AppbarWidgetWithScreens(
                  title: "transfer_of_services".tr(),
                  description: "please_enter_the_following_information".tr(),
                ),
                SizedBox(
                  height: 20.h,
                ),
                //المهنة
                CustomDropdownWidget(
                  label: "current_employment_entity".tr(),
                  onChanged: (p0) {
                    var currentSelectedOccupation = cubit.occupationsModel!.data!.firstWhere(
                          (occupation) => occupation.name == p0,
                    );
                    cubit.selectedOccupationId = currentSelectedOccupation.id;
                    cubit.selectedOccupation = currentSelectedOccupation.name;
                    print("Selected Country ID: ${cubit.selectedOccupationId}");
                  },
                  items: cubit.occupationsModel!.data!.map((e) => e.name!).toList(),
                ),
                SizedBox(
                  height: 20.h,
                ),
                //الدولة
                CustomDropdownWidget(
                  label: "current_employment_country".tr(),
                  onChanged: (selectedName) {
                    var selectedCountry = cubit.getCountriesModel!.data!.firstWhere(
                          (country) => country.name == selectedName,
                    );
                    cubit.selectedCountryId = selectedCountry.id;
                    print("Selected Country ID: ${cubit.selectedCountryId}");
                  },
                  items:cubit.getCountriesModel!.data!.map((e) => e.name!).toList(),

                ),


                SizedBox(
                  height: 20.h,
                ),
                // الديانة
                CustomDropdownWidget(
                  label: "current_employment_nationality".tr(),
                  onChanged: (selectedName) {
                    var selectedReligion = cubit.religionsModel!.data!.firstWhere(
                          (country) => country.name == selectedName,
                    );
                    cubit.religionName = selectedReligion.name;
                  },
                  items: cubit.religionsModel!.data!.map((e) => e.name!).toList(),
                ),

                SizedBox(height: 20.h,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                  decoration: BoxDecoration(
                    color: AppColors.blue.withOpacity(0.08), // Light blue background color
                    borderRadius: BorderRadius.circular(8.0.sp), // Rounded corners
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h,),
                      Text("transfer_type".tr(),style: TextStyle(fontSize: 16.sp),),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: cubit.getTransferServiceTypeModel?.data?.map((serviceType) {
                          return Row(
                            children: [
                              Radio(
                                value: serviceType.id,
                                groupValue:  cubit.serviceType,
                                onChanged: (value) {
                                  setState(() {
                                    cubit.serviceType = value.toString();
                                    print("serviceType: ${cubit.serviceType}");
                                  });
                                },
                                activeColor: Colors.blue,
                              ),
                              Text(
                                serviceType.title ?? "",
                                style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
                              ),
                            ],
                          );
                        }).toList() ?? [],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h,),


                Expanded(
                  child: Container(),
                ),
                (state is InsertTransferServiceLoadingState)?
                    Center(child: CircularProgressIndicator( color: AppColors.blue,),)
                :ButtonWidget(
                  onPressed: () {
                cubit.insertTransferServiceRequestData(context: context);
                  },
                  textButton: "order_now".tr(),
                ),
              ],
            );
          }
        ),
      ),
    ));
  }
}
