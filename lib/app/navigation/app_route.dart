import 'package:auto_route/auto_route.dart';
import 'package:test_project/app/navigation/app_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRoute extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [AutoRoute(page: HubRoute.page, initial: true)];
}
