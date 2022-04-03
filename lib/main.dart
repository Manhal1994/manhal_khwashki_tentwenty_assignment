import 'package:flutter/material.dart';
import 'injection_container.dart' as di;

import 'app.dart';
import 'di/di_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await configureDependencies();
  await di.init();

  runApp(const App());
}
