import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hike_mates/features/gui/ui/drawer/drawer.dart';
import 'package:hike_mates/features/gui/ui/drawer/emergency_contacts.dart';
import 'package:hike_mates/features/gui/ui/routers/app_router.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  void _showAlert() {
    // logic forr the alert notif
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: const Text('This will be visible to other active users.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToEmergencyContacts() {
    AutoRouter.of(context).push(EmergencyContactsRouteRoute());

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const EmergencyContactsScreen()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'HikeMates',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(208, 72, 71, 71),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const MyDrawer(),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0, bottom: 8.0),
                  child: FloatingActionButton(
                    onPressed: _showAlert,
                    backgroundColor: const Color.fromARGB(255, 250, 181, 34),
                    child: const Icon(Icons.crisis_alert),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: ElevatedButton(
                    onPressed: _navigateToEmergencyContacts,
                    // backgroundColor: const Color.fromARGB(255, 45, 101, 234),
                    child: const Icon(Icons.phone),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
