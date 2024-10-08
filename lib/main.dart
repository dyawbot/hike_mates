import 'package:flutter/material.dart';
import 'package:hike_mates/common/app_module.dart';

import 'package:hike_mates/features/gui/ui/routers/app_router.dart';
// Import the new pages for Privacy Policy and Terms and Conditions

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies().then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: true,

      // home: const MyHikeMates(),
      // routes: {
      //   '/emergency_contacts': (context) => const EmergencyContactsScreen(),
      //   '/privacy_policy': (context) => const PrivacyPolicyPage(),
      //   '/terms_conditions': (context) => const TermsConditionsPage(),
      //   '/login': (context) => const Login(
      //         title: '',
      //       ),
      //   '/settings': (context) => const SettingsPage(),
      //   // Add other routes as needed
      // },
    );
  }
}

// class MyHikeMates extends StatefulWidget {
//   const MyHikeMates({super.key});

//   @override
//   State<MyHikeMates> createState() => _MyHikeMatesState();
// }

// class _MyHikeMatesState extends State<MyHikeMates> {
//   @override
//   Widget build(BuildContext context) {
//     return const Homepage();
//   }
// }
