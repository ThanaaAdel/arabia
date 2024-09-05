import 'package:arabia/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/remote/service.dart';
import 'state.dart';

class FollowUpOnOrdersCubit extends Cubit<FollowUpOnOrdersState> {
  FollowUpOnOrdersCubit(this.api) : super(MainInitial());

  ServiceApi api;


}
