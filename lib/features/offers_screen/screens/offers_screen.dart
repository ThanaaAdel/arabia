import 'package:arabia/core/utils/app_colors.dart';
import 'package:arabia/core/widgets/shared_appbar.dart';
import 'package:arabia/features/offers_screen/cubit/cubit.dart';
import 'package:arabia/features/offers_screen/cubit/state.dart';
import 'package:arabia/features/offers_screen/screens/widget/custom_offer_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/routes/app_routes.dart';

class OfferScreen extends StatefulWidget {
  const OfferScreen({super.key});

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  @override
  void initState() {
    context.read<OffersCubit>().getOffersData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<OffersCubit>();
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: SharedAppbar(text: "offers".tr()),
            ),
            BlocBuilder<OffersCubit, OffersState>(builder: (context, state) {
              return (state is GetOffersLoadingState ||
                      cubit.offersModel == null)
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.blue,
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: cubit.offersModel?.data?.length ?? 0,
                      itemBuilder: (context, index) => CustomOfferContainer(
                        offersData: cubit.offersModel?.data?[index],
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.offerDetailsRoute,
                                  arguments: cubit.offersModel?.data?[index]);
                            },
                          ));
            })
          ],
        ),
      ),
    ));
  }
}
