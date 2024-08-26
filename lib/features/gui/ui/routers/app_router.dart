import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../presenter/homepage/homepage.dart';
import '../../presenter/login/login_page.dart';
import '../drawer/emergency_contacts.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: EmergencyContactsRouteRoute.page),
      ];
}
