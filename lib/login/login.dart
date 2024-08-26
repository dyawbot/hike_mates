import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key, required String title});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _emailInput = TextEditingController();
  final TextEditingController _passInput = TextEditingController();
  bool _passwordVisi = false;

  String? _validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    final isValidEmail = emailRegex.hasMatch(email ?? '');
    if (!isValidEmail) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePass(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter you password';
    }
    return null;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _passInput.dispose();
    _emailInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(48, 48, 48, 48),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWS51CD9zsglzLVjpYo0klGhkkdCgQty9-CA&s"),
                    ),
                    const ListTile(
                      title: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 37, color: Colors.white),
                        ),
                      ),
                      subtitle: Center(
                          child: Text(
                              "Welcome to Carpe Diem Adventure Emergency Assistance!",
                              style: TextStyle(color: Colors.white))),
                    ),
                    TextFormField(
                      controller: _emailInput,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w100,
                          color: Colors.white),
                      validator: _validateEmail,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _passInput,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.white),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _passwordVisi = !_passwordVisi;
                              });
                            },
                            child: Icon(
                              _passwordVisi
                                  ? Icons.visibility
                                  : Icons.visibility_off_outlined,
                              color: Colors.white,
                            ),
                          )),
                      obscureText: !_passwordVisi,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w100,
                          color: Colors.white),
                      validator: _validatePass,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange),
                        onPressed: () {},
                        child: const SizedBox(
                          width: 118,
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Login",
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                            trailing: Icon(Icons.login),
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
