import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../presenter/homepage/homepage.dart';
import '../../presenter/login/login_page.dart';
import '../drawer/emergency_contacts.dart';
import '../drawer/privacy_policy.dart';
import '../drawer/settings_page.dart';
import '../drawer/terms_conditions.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
        ),
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(page: EmergencyContactsRouteRoute.page),
        AutoRoute(page: SettingsRoute.page),
        AutoRoute(page: PrivacyPolicyRoute.page),
        AutoRoute(page: TermsConditionsRoute.page),
      ];
}
