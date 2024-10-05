import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

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
          'Privacy Policy',
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
              'This Privacy Policy describes Our policies and procedures on the collection, use, and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.',
            ),
            const SizedBox(height: 20),
            const Text(
              'We use Your Personal data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy.',
            ),
            const SizedBox(height: 20),
            sectionTitle('Interpretation and Definitions'),
            sectionTitle('Interpretation'),
            sectionContent(
                'The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.'),
            sectionTitle('Definitions'),
            sectionContent(
                'Account means a unique account created for You to access our Service or parts of our Service.'),
            sectionContent(
                'Personal Data You provide can give You access to different functionalities of the Service that are available to You as a registered user.'),
            sectionContent(
                'For the performance of a contract: the development, compliance and undertaking of the purchase contract for the products, items or services You have purchased or of any other contract with Us through the Service.'),
            sectionContent(
                'To contact You: To contact You by email, telephone calls, SMS, or other equivalent forms of electronic communication, such as a mobile application\'s push notifications regarding updates or informative communications.'),
            const SizedBox(height: 20),
            sectionTitle('Retention of Your Personal Data'),
            sectionContent(
                'The Company will retain Your Personal Data only for as long as is necessary for the purposes set out in this Privacy Policy.'),
            sectionTitle('Transfer of Your Personal Data'),
            sectionContent(
                'Your information, including Personal Data, is processed at the Company\'s operating offices and in any other places where the parties involved in the processing are located.'),
            const SizedBox(height: 20),
            sectionTitle('Delete Your Personal Data'),
            sectionContent(
                'You have the right to delete or request that We assist in deleting the Personal Data that We have collected about You.'),
            sectionTitle('Disclosure of Your Personal Data'),
            sectionContent(
                'The Company may disclose Your Personal Data in the good faith belief that such action is necessary to comply with a legal obligation.'),
            const SizedBox(height: 20),
            sectionTitle('Children\'s Privacy'),
            sectionContent(
                'Our Service does not address anyone under the age of 13. We do not knowingly collect personally identifiable information from anyone under the age of 13.'),
            sectionTitle('Changes to this Privacy Policy'),
            sectionContent(
                'We may update Our Privacy Policy from time to time. We will notify You of any changes by posting the new Privacy Policy on this page.'),
            const SizedBox(height: 20),
            sectionTitle('Contact Us'),
            sectionContent(
                'If you have any questions about this Privacy Policy, You can contact us by email: hikematescda2425@gmail.com'),
          ],
        ),
      ),
    );
  }
}
