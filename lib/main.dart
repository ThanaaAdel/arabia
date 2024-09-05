import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:arabia/injector.dart' as injector;
import 'app.dart';
import 'app_bloc_observer.dart';
import 'core/utils/restart_app_class.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await injector.setup();
  Bloc.observer = AppBlocObserver();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar', ''), Locale('en', '')],
      path: 'assets/lang',
      saveLocale: true,
      startLocale: const Locale('ar', ''),
      fallbackLocale: const Locale('ar', ''),
      child: const HotRestartController(child: MyApp()),
    ),
  );
}
