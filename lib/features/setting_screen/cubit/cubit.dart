import 'package:flutter_bloc/flutter_bloc.dart';

import 'state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());
}