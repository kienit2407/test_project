import 'package:flutter/material.dart';
import 'package:test_project/app.dart';
import 'package:test_project/app/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.getInstance().init();
  runApp(const App());
}
