import 'package:get_it/get_it.dart';
import 'package:test_project/app/navigation/app_route.dart';

final getIt = GetIt.instance;

Future<void> initGetit() async {
  // Register your dependencies here
  getIt.registerSingleton<AppRoute>(AppRoute());
}