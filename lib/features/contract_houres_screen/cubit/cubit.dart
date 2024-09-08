import 'package:arabia/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/remote/service.dart';
import 'state.dart';

class ComplaintsCubit extends Cubit<ComplaintsState> {
  ComplaintsCubit(this.api) : super(MainInitial());

  ServiceApi api;
  int selectedIndexOrder = 0; // 0 : new
  String statusFromOrder = 'opened';
  onTapChangeCurrentOrder(int index, BuildContext context) {
    selectedIndexOrder = index;
    emit(ChangeStatusOfSelectedIndexOrder());
  }

}
