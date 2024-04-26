import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_pal/Controllers/LoginController.dart';
import 'package:fit_pal/Controllers/initializationController.dart';
import 'package:fit_pal/DataBaseServices/Intialziedata.dart';
import 'package:fit_pal/DataBaseServices/useruid.dart';
import 'package:fit_pal/DataFriends/getfriends.dart';
import 'package:fit_pal/Profileimage.dart';
import 'package:fit_pal/loadingPages/loadingpage1.dart';
import 'package:fit_pal/pages/introPages/intro_page_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLogin;
  const RegisterPage({super.key, required this.showLogin});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //define controller
  bool is_loading = false;
  bool is_loading1 = false;
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _passwordConfirm = TextEditingController();
  UserCredential? _userCredential;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _passwordConfirm.dispose();
    super.dispose();
  }

  //focus nodes
  final snackBar = SnackBar(
    content: Text('Something went wrong please try again'),
  );
  // FocusNode emailnode = FocusNode();
  // FocusNode passwordnode = FocusNode();
  // FocusNode passwordconfirmnode = FocusNode();
  bool weak_password = false;
  bool if_valid_email = true;
  bool email_not_entered = false;
  bool if_email_already = false;
  bool is_visible = false;
  bool is_visible1 = false;
  bool passwords_match = true;
  bool password_not_entered = false;

  String return_label_text_email() {
    String s = 'email';
    if (if_email_already) {
      s = 'This email is already taken';
      return s;
    }
    if (!if_valid_email) {
      s = 'Please enter a valid email';
      return s;
    }

    if (email_not_entered) {
      s = 'Please enter email';
      return s;
    }

    return s;
  }

  void changeVisibility() {
    setState(() {
      is_visible = !is_visible;
    });
  }

  bool check_passwords() {
    if (_password.text != _passwordConfirm.text) {
      setState(() {
        passwords_match = false;

        _passwordConfirm.text = "";
      });
      return false;
    } else {
      setState(() {
        passwords_match = true;
      });
    }
    return true;
  }

  bool check_allfilled() {
    if (_email.text == "") {
      setState(() {
        email_not_entered = true;
        // if_valid_email = false;
        if_valid_email = true;
      });
      return false;
    } else {
      if (!EmailValidator.validate(_email.text)) {
        setState(() {
          if_valid_email = false;
        });
        return false;
      } else {
        setState(() {
          email_not_entered = false;
          if_valid_email = true;
        });
      }
    }
    if (_password.text == "") {
      setState(() {
        password_not_entered = true;
      });
      return false;
    } else {
      setState(() {
        password_not_entered = false;
      });
    }
    if (check_passwords()) {
      return true;
    } else {
      return false;
    }
  }

  Future register() async {
    try {
      setState(() {
        is_loading = true;
      });
      _userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _email.text.trim(), password: _password.text.trim());
      setState(() {
        is_loading = false;
      });
      setState(() {
        is_loading1 = true;
      });
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(context, '/home');
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        is_loading = false;
      });
      // print(e);
      if (e.code == 'email-already-in-use') {
        setState(() {
          if_email_already = true;
        });
      } else {
        if (e.code == 'weak-password') {
          setState(() {
            if_email_already = false;
            weak_password = true;
            _passwordConfirm.text = "";
          });
        }
      }
    } catch (e) {
      setState(() {
        is_loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void register_done() async {
    if (check_allfilled()) {
      await register();
      if (_userCredential != null) {
        UserData userData =
            await UserData(uid: _userCredential!.user!.uid, statusMap: {});
        await userData.addUsersListToDatabase(
            _userCredential!.user!.uid); // Await this call
        AuthService.setUID(_userCredential!.user!.uid);
        Dataservices dataservices =
            await Dataservices(uid: _userCredential!.user!.uid);
        dataservices.initializeData(
            name: '',
            age: 0,
            gender: '',
            height: 0,
            weight: 0.0,
            check: 0,
            count: 0,
            goal: 0);
        dataservices.initializeWater(target: 12, quantity: 250);
        dataservices.StreakandWater();
        dataservices.initializeUserXPForConsecutiveDays();
        dataservices.initializeStreaks();
        Profilepage profilepage =
            Profilepage(uid: FirebaseAuth.instance.currentUser!.uid);
        profilepage.setProfileLink(
            "https://i.pinimg.com/564x/e9/51/25/e951250f7f452c8e278d12ac073b9b5b.jpg");
      }
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return LoginController();
    }));
  }

  void changeVisibility1() {
    setState(() {
      is_visible1 = !is_visible1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return !is_loading1
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Center(
                  child: Column(
                    children: [
                      // title
                      const Text(
                        'FitPal',
                        style: TextStyle(
                          fontFamily: 'Bebas_Neue',
                          fontSize: 70,
                        ),
                      ),
                      const Text(
                        'Register here',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      //email
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          // autofocus: true,
                          // focusNode: emailnode,
                          controller: _email,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email),
                              fillColor: Colors.grey[50],
                              filled: true,
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                // borderSide: BorderSide(color: Colors.lightBlue, width: 4),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: (if_email_already ||
                                        email_not_entered ||
                                        !if_valid_email)
                                    ? const BorderSide(color: Colors.red)
                                    : const BorderSide(color: Colors.blue),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: (if_email_already ||
                                        email_not_entered ||
                                        !if_valid_email)
                                    ? const BorderSide(color: Colors.red)
                                    : const BorderSide(color: Colors.blue),
                              ),
                              labelText: return_label_text_email(),
                              labelStyle: (if_email_already ||
                                      email_not_entered ||
                                      !if_valid_email)
                                  ? const TextStyle(
                                      color: Colors.red,
                                    )
                                  : null,
                              floatingLabelStyle: TextStyle(
                                color: (if_email_already ||
                                        email_not_entered ||
                                        !if_valid_email)
                                    ? Colors.red
                                    : Colors.blue,
                              )
                              // : TextStyle(
                              //     color: Colors.blue,
                              //   )
                              // : TextStyle(
                              //     color: Colors.black,
                              //   )
                              // hintText: 'Please enter your email',
                              // hintText: 'Username',
                              ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      //password
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          // focusNode: passwordnode,
                          controller: _password,
                          obscureText: !is_visible,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: Colors.blue),
                              ),
                              fillColor: Colors.grey[50],
                              filled: true,
                              isDense: true,
                              prefixIcon: const Icon(Icons.lock),
                              errorText: password_not_entered
                                  ? 'Please enter password'
                                  : (weak_password
                                      ? 'password must contain atleat 6 characters'
                                      : null),
                              suffixIcon: GestureDetector(
                                  onTap: changeVisibility,
                                  child: Icon(is_visible
                                      ? Icons.visibility
                                      : Icons.visibility_off)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: Colors.lightBlue),
                              ),
                              labelText: 'Password',
                              // labelStyle: TextStyle(
                              //   color: Colors.blue,
                              // ),
                              floatingLabelStyle: TextStyle(
                                color: password_not_entered || weak_password
                                    ? Colors.red
                                    : Colors.blue,
                              )),
                        ),
                      ),
                      const SizedBox(height: 15),
                      //confirmpassword
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          controller: _passwordConfirm,
                          obscureText: !is_visible1,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: Colors.blue),
                              ),
                              fillColor: Colors.grey[50],
                              filled: true,
                              isDense: true,
                              prefixIcon: const Icon(Icons.lock),
                              errorText: passwords_match
                                  ? null
                                  : 'passwords do not match',
                              suffixIcon: GestureDetector(
                                  onTap: changeVisibility1,
                                  child: Icon(is_visible1
                                      ? Icons.visibility
                                      : Icons.visibility_off)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: Colors.lightBlue),
                              ),
                              labelText: 'Confirm Password',
                              floatingLabelStyle: TextStyle(
                                color:
                                    passwords_match ? Colors.blue : Colors.red,
                              )
                              // labelStyle: TextStyle(
                              //   color: Colors.blue,
                              // ),

                              ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      //login button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: GestureDetector(
                          onTap: register_done,
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: !is_loading
                                ? const Center(
                                    child: Text(
                                    'Register',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Roboto',
                                      color: Colors.white,
                                    ),
                                  ))
                                : const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already a member?"),
                          SizedBox(
                            width: 4,
                          ),
                          GestureDetector(
                            onTap: widget.showLogin,
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        : const LoadingScreen1();
  }
}
