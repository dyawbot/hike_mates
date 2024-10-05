// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:hike_mates/features/domain/entity/login_entity.dart';

import 'package:hike_mates/features/gui/ui/routers/app_router.dart';
import 'package:hike_mates/features/gui/ui/widget/custo_alert_dialog.dart';
import 'package:logger/logger.dart';

//import 'settings_page.dart'; // Import the settings page

class MyDrawer extends StatelessWidget {
  final LoginEntity loginEntity;
  final String hikeCode;

  final logger = Logger();
  final bool isLogin;
  final void Function() logout;

  MyDrawer(
    this.loginEntity,
    this.hikeCode, {
    required this.isLogin,
    required this.logout,
    // this.usecase,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Drawer(
      backgroundColor: const Color.fromRGBO(48, 48, 48, 1),
      child: ListView(
        children: [
          SizedBox(
              height: _height * 0.15,
              child: DrawerHeader(
                padding: const EdgeInsets.fromLTRB(5, 16.0, 16.0, 8.0),
                child: ListTile(
                  leading: const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        scale: 1,
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWS51CD9zsglzLVjpYo0klGhkkdCgQty9-CA&s"),
                  ),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${loginEntity.firstName} ${loginEntity.lastName}",
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        "${loginEntity.phoneNumber}",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      Text(
                        loginEntity.username,
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              )),
          ListTile(
            onTap: () {
              // Navigator.of(context).pushNamed('/emergency_contacts');
              AutoRouter.of(context).push(
                  EmergencyContactsRouteRoute(userId: loginEntity.userId!));
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
              showDialog(
                  context: context,
                  builder: (context) {
                    return CustomAlertDialog(
                        colorMessage: Colors.green.shade600,
                        actionOkayVisibility: true,
                        actionCloseVisibility: false,
                        actionLabel: "Okay",
                        onPressOkay: () {
                          Navigator.pop(context);
                        },
                        title: "Code",
                        child: SizedBox(
                          width: _width,
                          child: Text(
                            hikeCode == "Hike Code"
                                ? "Please generate code"
                                : hikeCode,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.orange,
                                fontSize: 26,
                                fontWeight: FontWeight.bold),
                          ),
                        ));
                  });
            },
            leading: const Icon(
              Icons.lock_clock_sharp,
              color: Colors.white,
            ),
            title: const Text("Code", style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            onTap: () {
              AutoRouter.of(context).push(const SettingsRoute());
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
              onTap: logout,
              leading: const Icon(Icons.logout_outlined, color: Colors.white),
              title: isLogin
                  ? const Text("Logout", style: TextStyle(color: Colors.white))
                  : Container()),
        ],
      ),
    );
  }
}
