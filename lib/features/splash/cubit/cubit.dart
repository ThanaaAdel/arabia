import 'package:flutter_bloc/flutter_bloc.dart';

import 'state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());
}