import 'package:flutter/material.dart';
import 'package:hike_mates/drawer/drawer.dart';
import 'package:hike_mates/drawer/emergency_contacts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EmergencyContactsScreen()),
    );
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
                  child: FloatingActionButton(
                    onPressed: _navigateToEmergencyContacts,
                    backgroundColor: const Color.fromARGB(255, 45, 101, 234),
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