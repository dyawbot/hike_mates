// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'dart:io';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class AddContactPage extends StatefulWidget {
  final String? name;
  final String? phone;
  final String? photo;

  const AddContactPage({super.key, this.name, this.phone, this.photo});

  @override
  _AddContactPageState createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  File? _image;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name ?? '';
    _phoneController.text = widget.phone ?? '';
    if (widget.photo != null) {
      _image = File(widget.photo!);
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  void _saveContact() {
    final name = _nameController.text;
    final phone = _phoneController.text;
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add an image.'),
        ),
      );
    }
    if (name.isNotEmpty && phone.isNotEmpty && _image != null) {
      Navigator.of(context).pop({
        'name': name,
        'phone': phone,
        'photo': _image!.path,
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Contact',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.photo,
              color: Colors.white,
            ),
            onPressed: _pickImage,
          ),
        ],
        backgroundColor: const Color.fromRGBO(48, 48, 48, 1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            width: _width,
            height: _height * 0.2,
            decoration: const BoxDecoration(
                color: Color.fromRGBO(64, 64, 64, 1),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12))),
            child: Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: _image != null
                    ? FileImage(_image!)
                    : const AssetImage('assets/placeholder.png')
                        as ImageProvider,
                child: _image == null ? const Center() : null,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: _height * 0.08,
                ),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Name",
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  // decoration: const InputDecoration(labelText: 'Name'),
                ),
                const SizedBox(
                  height: 18,
                ),
                TextField(
                  controller: _phoneController,
                  // decoration: const InputDecoration(labelText: 'Phone'),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Phone",
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: _width,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffFFD9B3)),
                    onPressed: _saveContact,
                    child: const Text('SAVE CONTACT'),
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
