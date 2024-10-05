// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    EmergencyContactsRouteRoute.name: (routeData) {
      final args = routeData.argsAs<EmergencyContactsRouteRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EmergencyContactsScreenPage(
          args.userId,
          key: args.key,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      final args = routeData.argsAs<HomeRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HomePage(
          args.userId,
          args.loginEntity,
          hikeCode: args.hikeCode,
          key: args.key,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginPage(),
      );
    },
    PrivacyPolicyRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PrivacyPolicyPage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsPage(),
      );
    },
    TermsConditionsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TermsConditionsPage(),
      );
    },
  };
}

/// generated route for
/// [EmergencyContactsScreenPage]
class EmergencyContactsRouteRoute
    extends PageRouteInfo<EmergencyContactsRouteRouteArgs> {
  EmergencyContactsRouteRoute({
    required int userId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          EmergencyContactsRouteRoute.name,
          args: EmergencyContactsRouteRouteArgs(
            userId: userId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'EmergencyContactsRouteRoute';

  static const PageInfo<EmergencyContactsRouteRouteArgs> page =
      PageInfo<EmergencyContactsRouteRouteArgs>(name);
}

class EmergencyContactsRouteRouteArgs {
  const EmergencyContactsRouteRouteArgs({
    required this.userId,
    this.key,
  });

  final int userId;

  final Key? key;

  @override
  String toString() {
    return 'EmergencyContactsRouteRouteArgs{userId: $userId, key: $key}';
  }
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    required int userId,
    required LoginEntity loginEntity,
    String? hikeCode,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(
            userId: userId,
            loginEntity: loginEntity,
            hikeCode: hikeCode,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<HomeRouteArgs> page = PageInfo<HomeRouteArgs>(name);
}

class HomeRouteArgs {
  const HomeRouteArgs({
    required this.userId,
    required this.loginEntity,
    this.hikeCode,
    this.key,
  });

  final int userId;

  final LoginEntity loginEntity;

  final String? hikeCode;

  final Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{userId: $userId, loginEntity: $loginEntity, hikeCode: $hikeCode, key: $key}';
  }
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PrivacyPolicyPage]
class PrivacyPolicyRoute extends PageRouteInfo<void> {
  const PrivacyPolicyRoute({List<PageRouteInfo>? children})
      : super(
          PrivacyPolicyRoute.name,
          initialChildren: children,
        );

  static const String name = 'PrivacyPolicyRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TermsConditionsPage]
class TermsConditionsRoute extends PageRouteInfo<void> {
  const TermsConditionsRoute({List<PageRouteInfo>? children})
      : super(
          TermsConditionsRoute.name,
          initialChildren: children,
        );

  static const String name = 'TermsConditionsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
