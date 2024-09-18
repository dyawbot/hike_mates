import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hike_mates/features/gui/ui/routers/app_router.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings_page.dart'; // Import the settings page

class MyDrawer extends StatelessWidget {
  final logger = Logger();
  final bool isLogin;
  MyDrawer({
    required this.isLogin,
    super.key,
  });

  _logout() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    logger.d(_prefs.getBool('isLogin'));
    await _prefs.remove('username');
    await _prefs.remove('password');
    await _prefs.remove('isLoggin');

    // await _prefs.setBool('isLogin', false);
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Drawer(
      backgroundColor: const Color.fromRGBO(48, 48, 48, 1),
      child: ListView(
        children: [
          SizedBox(
              height: _height * 0.12,
              child: const DrawerHeader(
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
              // Navigator.of(context).pushNamed('/emergency_contacts');
              AutoRouter.of(context).push(const EmergencyContactsRouteRoute());
            },
            leading: const Icon(
              Icons.contact_emergency,
              color: Colors.white,
            ),
            title: const Text(
              "Emergency Contacts",
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            onTap: () {
              AutoRouter.of(context).push(SettingsRoute());
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => const SettingsPage(),
              //   ),
              // );
            },
            leading: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            title:
                const Text("Settings", style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            onTap: () {
              // Navigator.of(context).pushNamed('/about');
            },
            leading: const Icon(Icons.info, color: Colors.white),
            title: const Text("About", style: TextStyle(color: Colors.white)),
          ),
          ListTile(
              onTap: () {
                // Navigator.of(context).pushNamed('/logout');
                _logout();

                AutoRouter.of(context).push(LoginRoute());
              },
              leading: const Icon(Icons.logout_outlined, color: Colors.white),
              title: isLogin
                  ? const Text("Logout", style: TextStyle(color: Colors.white))
                  : Container()),
        ],
      ),
    );
  }
}
