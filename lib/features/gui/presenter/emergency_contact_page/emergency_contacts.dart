// ignore_for_file: library_private_types_in_public_api

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hike_mates/features/domain/parameters/user_contact_emergency_params.dart';
import 'package:hike_mates/features/gui/presenter/emergency_contact_page/emergency_contact_page_bloc.dart';
import 'package:hike_mates/features/gui/presenter/login/login_page_bloc.dart';

import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../common/app_module.dart';
import 'add_contact_page.dart'; // Import the AddContactPage

@RoutePage()
class EmergencyContactsScreenPage extends StatefulWidget {
  final int userId;
  const EmergencyContactsScreenPage(this.userId, {super.key});

  @override
  _EmergencyContactsScreenState createState() =>
      _EmergencyContactsScreenState();
}

class _EmergencyContactsScreenState extends State<EmergencyContactsScreenPage> {
  final logger = Logger();
  List<Map<String, dynamic>> _contacts = [];
  final _bloc = getIt<EmergencyContactPageBloc>();

  // final List<Map<String, String?>> _contacts = [
  //   {
  //     'name': 'National Emergency Hotline',
  //     'phone': '911',
  //     'photo': 'lib/drawer/assets/emergency_hotline.png', // Add your photo path
  //   },
  //   {
  //     'name': 'Philippine Red Cross',
  //     'phone': '143',
  //     'photo': 'lib/drawer/assets/red_cross.png', // Add your photo path
  //   },
  // ];

  @override
  void initState() {
    super.initState();
    _bloc.add(const AddContactInfoEvent());
  }

  void _addContact() async {
    final newContact = await Navigator.of(context).push<Map<String, String?>>(
      MaterialPageRoute(
        builder: (context) => AddContactPage(),
      ),
    );
    logger.d(newContact);

    if (newContact != null) {
      logger.d(_contacts.length);
      if (_contacts.length < 3) {
        // _contacts.add(newContact);

        var params = UserContactEmergencyParams(
            widget.userId, newContact["name"]!, newContact["phone"]!);

        _bloc.add(AddContactInfoEvent(params: params));
        logger.d("asdasd");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Maximum of 2 contacts allowed.'),
          ),
        );
      }
    }
  }

  void _editContact(int index) async {
    final updatedContact =
        await Navigator.of(context).push<Map<String, String?>>(
      MaterialPageRoute(
        builder: (context) => AddContactPage(
          name: _contacts[index]['name'],
          phone: _contacts[index]['phone'],
          photo: _contacts[index]['photo'],
        ),
      ),
    );

    if (updatedContact != null) {
      setState(() {
        _contacts[index] = updatedContact;
      });
    }
  }

  void _deleteContact(int index) {
    setState(() {
      // _contacts.removeAt(index);
      var phone = _contacts[index]['phone'];
      logger.d(phone);
      _bloc.add(DeleteContactInfoEvent(DeleteNumberParams(phone)));
    });
  }

  void _emergencyCall(String number) async {
    final Uri phoneUrl = Uri(scheme: "tel", path: number);

    if (await canLaunchUrl(phoneUrl)) {
      await launchUrl(phoneUrl);
    } else {
      // Handle the error, e.g., show a message to the user
      logger.e('Could not launch $phoneUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmergencyContactPageBloc, EmergencyContactPageState>(
      bloc: _bloc,
      listener: (context, state) {
        // TODO: implement listener
        logger.d(state);

        if (state is AddEmergencyContactPageState) {
          var data = state.updatedData;

          setState(() {
            _contacts = data.map((e) {
              var dataEntity = {
                'name': e.contactName,
                'phone': e.phoneNumber,
              };
              return dataEntity;
            }).toList();
          });
        }

        if (state is DeleteEmergencyContactPageState) {
          logger.d("DELETING");
          var data = state.updatedData;

          setState(() {
            _contacts = data.map((e) {
              var dataEntity = {
                'name': e.contactName,
                'phone': e.phoneNumber,
              };
              return dataEntity;
            }).toList();
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Emergency Call',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: const Color.fromRGBO(48, 48, 48, 1),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: const Color.fromARGB(255, 255, 255, 255),
                padding: const EdgeInsets.all(16),
                child: GestureDetector(
                  onTap: _addContact,
                  child: const Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.add,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Add New',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                  height: 16), // Spacing between "Add New" and contacts list
              Expanded(
                child: ListView.builder(
                  itemCount: _contacts.length,
                  itemBuilder: (context, index) {
                    final contact = _contacts[index];
                    return ListTile(
                      onTap: () {
                        logger.d(_contacts[index]["phone"]);
                        String number = _contacts[index]["phone"]!;

                        _emergencyCall(number);
                      },
                      leading: Icon(
                        Icons.people,
                        size: 48,
                      ),
                      title: Text(contact['name']!),
                      subtitle: Text(contact['phone']!),
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'Edit') {
                            _editContact(index);
                          } else if (value == 'Delete') {
                            _deleteContact(index);
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'Edit',
                            child: Text('Edit'),
                          ),
                          const PopupMenuItem(
                            value: 'Delete',
                            child: Text('Delete'),
                          ),
                        ],
                        icon: const Icon(Icons.more_vert),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
