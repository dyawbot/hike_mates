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

    if (name.isNotEmpty && phone.isNotEmpty) {
      Navigator.of(context).pop({
        'name': name,
        'phone': phone,
        'photo': _image?.path,
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Contact'),
        backgroundColor: const Color.fromRGBO(48, 48, 48, 1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : const AssetImage('lib/drawer/assets/placeholder.png') as ImageProvider,
                  child: _image == null
                      ? const Center(
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.photo),
                  onPressed: _pickImage,
                ),
              ],
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveContact,
              child: const Text('Save Contact'),
            ),
          ],
        ),
      ),
    );
  }
}
