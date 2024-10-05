import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget sectionTitle(String title) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    }

    Widget sectionContent(String content) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(content),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Terms and Conditions',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Last updated: September 03, 2024'),
            const SizedBox(height: 20),
            const Text(
              'Please read these terms and conditions carefully before using Our Service.',
            ),
            const SizedBox(height: 20),
            sectionTitle('Interpretation and Definitions'),
            sectionTitle('Interpretation'),
            sectionContent(
                'The words of which the initial letter is capitalized have meanings defined under the following conditions.'),
            sectionTitle('Definitions'),
            sectionContent('For the purposes of these Terms and Conditions:'),
            sectionContent(
                'Application means the software program provided by the Company downloaded by You on any electronic device, named HikeMates.'),
            sectionContent('Country refers to: Philippines.'),
            sectionContent('Company refers to HikeMates.'),
            sectionContent(
                'Device means any device that can access the Service such as a computer, a cellphone, or a digital tablet.'),
            sectionContent('Service refers to the Application.'),
            sectionTitle('Acknowledgment'),
            sectionContent(
                'These are the Terms and Conditions governing the use of this Service and the agreement that operates between You and the Company.'),
            sectionContent(
                'Your access to and use of the Service is conditioned on Your acceptance of and compliance with these Terms and Conditions.'),
            sectionContent(
                'You represent that you are over the age of 18. The Company does not permit those under 18 to use the Service.'),
            const SizedBox(height: 20),
            sectionTitle('Severability and Waiver'),
            sectionTitle('Severability'),
            sectionContent(
                'If any provision of these Terms is held to be unenforceable or invalid, such provision will be changed and interpreted.'),
            sectionTitle('Waiver'),
            sectionContent(
                'The failure to exercise a right or to require performance of an obligation shall not affect a party\'s ability to exercise such right or require such performance at any time thereafter.'),
            sectionTitle('Changes to These Terms and Conditions'),
            sectionContent(
                'We reserve the right, at Our sole discretion, to modify or replace these Terms at any time.'),
            const SizedBox(height: 20),
            sectionTitle('Contact Us'),
            sectionContent(
                'If you have any questions about these Terms and Conditions, You can contact us by email: hikematescda2425@gmail.com'),
          ],
        ),
      ),
    );
  }
}
