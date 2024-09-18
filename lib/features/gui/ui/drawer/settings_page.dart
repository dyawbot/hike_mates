import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hike_mates/features/gui/ui/routers/app_router.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = false; // Manage this state dynamically

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(48, 48, 48, 1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            // Preferences Section
            const ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Icon(Icons.brush, color: Colors.black),
              title: Text(
                'Preferences',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              dense: true,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 0), // Remove bottom padding
              child: Divider(
                color: Colors.grey[300],
                thickness: 1,
                height: 0, // Reduced height to bring it closer to the text
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 4),
              child: SwitchListTile(
                contentPadding: EdgeInsets
                    .zero, // Removes the extra padding inside the SwitchListTile
                value: isDarkMode,
                onChanged: (bool value) {
                  // Handle dark mode toggle
                  isDarkMode = value;
                },
                title: const Text(
                  'Dark Mode',
                  style: TextStyle(
                    fontSize: 14, // Decreased font size
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            // Others Section
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Icon(Icons.settings, color: Colors.black),
              title: Text(
                'Others',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              dense: true,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 0), // Remove bottom padding
              child: Divider(
                color: Colors.grey[300],
                thickness: 1,
                height: 0, // Reduced height to bring it closer to the text
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'Privacy Policy',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: const Color.fromRGBO(48, 48, 48, 1),
                      size: 16,
                    ),
                    onTap: () {
                      // Navigator.of(context).pushNamed('/privacy_policy');
                      AutoRouter.of(context).push(PrivacyPolicyRoute());
                    },
                  ),
                  const SizedBox(height: 10), // Small space between items
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'Terms and Conditions',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: const Color.fromRGBO(48, 48, 48, 1),
                      size: 16,
                    ),
                    onTap: () {
                      // Navigator.of(context).pushNamed('/terms_conditions');
                      AutoRouter.of(context).push(TermsConditionsRoute());
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16), // Additional spacing at the bottom
          ],
        ),
      ),
    );
  }
}
