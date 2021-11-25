import 'dart:async';

import 'package:ah/collection/collection_screen.dart';
import 'package:ah/common/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: Color(0xff607D8B),
            primaryVariant: Color(0xff607D8B),
            secondary: Color(0xff9E9E9E),
            secondaryVariant: Color(0xff757575),
            surface: Colors.white,
            background: Colors.white,
          ),
        ),
        home: const CollectionScreen(),
      );
}

