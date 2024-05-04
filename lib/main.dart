import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mine_profile/src/app.dart';
import 'package:talker_flutter/talker_flutter.dart';

GetIt getIt = GetIt.instance;

Future<void> main() async {
  final talker = Talker(logger: TalkerLogger(output: log));
  FlutterError.onError = (FlutterErrorDetails details) {
    talker.handle(details.exception, details.stack);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    talker.handle(error, stack);
    return true;
  };

  await runZonedGuarded(
    () async {
      final widgetsBinding = WidgetsFlutterBinding.ensureInitialized()
        ..deferFirstFrame();

      widgetsBinding.allowFirstFrame();
      runApp(const MyApp());
    },
    talker.handle,
  );
}
