import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funda/common/di.dart';
import 'package:funda/home/home_screen.dart';
import 'package:logging/logging.dart';

const expiredId = '6289a7bb-a1a8-40d5-bed1-bff3a5f62ee6';
const validId = '092cc8ac-5e12-4654-8fed-1bcfe802771d';

void main() {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

      await DiModule.setup();
      runApp(const App());
    },
    (error, stacktrace) => Logger('main').severe('Error occurred running app', error, stacktrace),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(primarySwatch: Colors.orange),
        home: const HomeScreen(propertyId: validId),
      );
}
