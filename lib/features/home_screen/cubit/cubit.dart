import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/remote/service.dart';
import 'state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.api) : super(HomeInitial());
  ServiceApi api;}