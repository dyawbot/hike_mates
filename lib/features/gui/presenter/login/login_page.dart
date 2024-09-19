import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hike_mates/common/app_module.dart';
import 'package:hike_mates/features/domain/parameters/login_params.dart';
import 'package:hike_mates/features/gui/presenter/login/login_page_bloc.dart';
import 'package:hike_mates/features/gui/ui/custo_alert_dialog.dart';
import 'package:hike_mates/features/gui/ui/routers/app_router.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final bloc = getIt<LoginPageBloc>();

  final logger = Logger();
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _emailInput = TextEditingController();
  final TextEditingController _passInput = TextEditingController();
  bool _passwordVisi = false;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    logger.d("THIS IS IS INIT");

    Future.delayed(Duration(milliseconds: 200), () {
      checkLoginStatus();
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _passInput.dispose();
    _emailInput.dispose();
    super.dispose();
  }

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

  void _loginMethod() {
    var params =
        LoginParams(_emailInput.text.toString(), _emailInput.text.toString());

    bloc.add(GetLoginEvent(params: params));
    // final SharedPreferences _prefs = await SharedPreferences.getInstance();
    // try {
    // await _prefs.setString('username', _emailInput.text.toString());
    // await _prefs.setString('password', _emailInput.text.toString());
    // await _prefs.setBool('isLoggin', true);

    // logger.d(_prefs.getString('username'));
    // logger.d(_prefs.getBool('isLoggin'));

    //   if (_prefs.getBool('isLoggin') ?? false) {
    //     AutoRouter.of(context)
    //         .push(HomeRoute(isLoggedIn: _prefs.getBool('isLoggin')!));
    //   }
    // } on Exception catch (e) {
    //   // TODO
    //   logger.e(e);
    // }
  }

  void checkLoginStatus() {
    bloc.add(GetLoginEvent());
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // logger.d("THIS IS IS CHECKING LOGIN STATUS");

    // setState(() {
    //   final bool isLoggedIn = prefs.getBool('isLoggin') ?? false;
    //   // final String? username = prefs.getString('username');
    //   // final String? password = prefs.getString('password');

    //   _isLoggedIn = isLoggedIn;

    //   logger.d(_isLoggedIn);

    //   if (isLoggedIn) {
    //     // Navigate to the main page or dashboard
    //     AutoRouter.of(context).push(HomeRoute(isLoggedIn: _isLoggedIn));
    //   }
    // });
// Again, be cautious with passwords
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return BlocConsumer<LoginPageBloc, LoginPageState>(
      bloc: bloc,
      listener: (context, state) {
        // TODO: implement listener

        logger.d(state);
        if (state is LoginPageSuccessState) {
          AutoRouter.of(context).push(HomeRoute(isLoggedIn: true));
        }

        if (state is LoginPageInternetErrorState) {
          showDialog(
              context: context,
              builder: (context) {
                return CustomAlertDialog(
                    colorMessage: Colors.red,
                    title: "Connection Error",
                    child: Text(state.message!));
              });
        }

        if (state is LoginPageErrorState) {
          showDialog(
              context: context,
              builder: (context) {
                return CustomAlertDialog(
                    colorMessage: Colors.red,
                    title: "Error",
                    child: Text(state.message!));
              });
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color.fromRGBO(48, 48, 48, 48),
          body: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 100, 30, 20),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWS51CD9zsglzLVjpYo0klGhkkdCgQty9-CA&s"),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const ListTile(
                          title: Center(
                            child: Text(
                              "Login",
                              style:
                                  TextStyle(fontSize: 37, color: Colors.white),
                            ),
                          ),
                          subtitle: Center(
                              child: Text(
                                  "Welcome to Carpe Diem Adventure Emergency Assistance!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white))),
                        ),
                        const SizedBox(
                          height: 24,
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
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                backgroundColor: Colors.orange),
                            onPressed: _loginMethod,
                            child: SizedBox(
                              width: _width,
                              child: const ListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Login",
                                        style: TextStyle(color: Colors.white)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(Icons.login)
                                  ],
                                ),
                                // trailing: Icon(Icons.login),
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
      },
    );
  }
}
