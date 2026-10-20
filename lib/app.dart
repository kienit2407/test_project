import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_project/app/di/get_it.dart';
import 'package:test_project/app/navigation/app_route.dart';
import 'package:test_project/app/observer/route_observer.dart';
import 'package:test_project/app/themes/app_theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp.router(
          theme: AppTheme.appTheme,
          debugShowCheckedModeBanner: false,
          routerConfig: getIt<AppRoute>().config(
            navigatorObservers: () => [AppRouteObserver()],
          ),
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: TextScaler.noScaling),
              child: child!,
            );
          },
        ),
      ),
    );
  }
}
