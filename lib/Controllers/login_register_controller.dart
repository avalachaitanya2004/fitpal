import 'package:fit_pal/pages/login_page.dart';
import 'package:fit_pal/pages/register_page.dart';
import 'package:flutter/material.dart';

class RegisterLoginController extends StatefulWidget {
  const RegisterLoginController({super.key, required this.from_pre_login});
  final bool from_pre_login;
  @override
  State<RegisterLoginController> createState() =>
      _RegisterLoginControllerState(fromPreLogin: from_pre_login);
}

class _RegisterLoginControllerState extends State<RegisterLoginController> {
  bool login;
  _RegisterLoginControllerState({required bool fromPreLogin})
      : login = fromPreLogin;
  void toggle() {
    setState(() {
      login = !login;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (login) {
      return LoginPage(
        showRegPage: toggle,
      );
    } else {
      return RegisterPage(showLogin: toggle);
    }
  }
}
