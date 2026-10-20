import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/app/di/get_it.dart';
import 'package:test_project/app/observer/bloc_observer.dart';

class AppConfig {
  factory AppConfig.getInstance() {
    return _instance;
  }

  AppConfig._();

  static final AppConfig _instance = AppConfig._();
  Future<void> init() async {
    await initGetit ();
    await getIt.allReady();
    Bloc.observer = AppBlocObserver();
  }
}
