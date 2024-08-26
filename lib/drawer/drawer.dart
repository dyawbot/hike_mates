import 'package:flutter/material.dart';
import 'settings_page.dart'; // Import the settings page

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromRGBO(48, 48, 48, 1),
      child: ListView(
        children: [
          const SizedBox(
              height: 70,
              child: DrawerHeader(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWS51CD9zsglzLVjpYo0klGhkkdCgQty9-CA&s"),
                  ),
                  title: Text(
                    "Carpe Diem Adventures",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )),
              ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/emergency_contacts');
            },
            leading: Icon(
              Icons.contact_emergency,
              color: Colors.white,
            ),
            title: Text(
              "Emergency Contacts",
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
            leading: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            title: const Text("Settings", style: TextStyle(color: Colors.white)),
          ),
          
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/about');
            },
            leading: const Icon(Icons.info, color: Colors.white),
            title: const Text("About", style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/logout');
            },
            leading: const Icon(Icons.logout_outlined, color: Colors.white),
            title: const Text("Logout", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
