import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_wallpaper_app/helper/firebase_auth_helper.dart';
import 'package:my_wallpaper_app/utils/route_utils.dart';
import 'package:my_wallpaper_app/views/screens/home_page.dart';
import 'package:my_wallpaper_app/views/screens/intro_screen.dart';
import 'package:my_wallpaper_app/views/screens/lanagues_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  Duration get loginTime => const Duration(milliseconds: 2250);

  Map<String, String> users = {
    'nikunjparmar507@gmail.com': '12345',
    'hunter@gmail.com': 'hunter',
  };

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return null!;
    });
  }

  Future<String?> _onSignup(SignupData data) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: data.name.toString(),
        password: data.password.toString(),
      );
      return null; // Return null if sign up is successful
    } catch (e) {
      print("Error signing up: $e");
      return e.toString(); // Return the error message if sign up fails
    }
  }

  Future<String?> _onLogin(LoginData data) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: data.name,
        password: data.password,
      );
      return null; // Return null if login is successful
    } catch (e) {
      print("Error signing in: $e");
      return e.toString(); // Return the error message if login fails
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User? user = FireBaseHelper.fireBaseHelper.firebaseAuth.currentUser;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: FlutterLogin(
        userType: LoginUserType.email,
        confirmSignupKeyboardType: TextInputType.emailAddress,
        logo: const AssetImage("assets/icons/new.png"),
        title: "WallGallery",
        onLogin: _onLogin,
        passwordValidator: (value) {},
        onRecoverPassword: _recoverPassword,
        onSignup: _onSignup,
        theme: LoginTheme(
          logoWidth: 0.35,
          titleStyle: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
          primaryColor: const Color(0xffFDBC02),
          buttonStyle: const TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
          buttonTheme: LoginButtonTheme(
            // splashColor: Colors.grey,
            // // backgroundColor: Colors.pinkAccent,
            // elevation: 9.0,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          cardTheme: CardTheme(
            margin: const EdgeInsets.all(20),
            color: Colors.black,
            elevation: 20,
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(30)),
          ),
          errorColor: Colors.white,
          bodyStyle: const TextStyle(color: Colors.white),
          inputTheme: InputDecorationTheme(
            iconColor: Colors.red,
            fillColor: const Color(0xffFDBC02),
            filled: true,
            contentPadding: const EdgeInsets.all(10),
            hintStyle: const TextStyle(
              color: Colors.white,
              backgroundColor: Colors.red,
            ),
            labelStyle: const TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade700, width: 2),
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white54, width: 3),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              // borderRadius: inputBorder,
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              // borderRadius: inputBorder,
            ),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              // borderRadius: inputBorder,
            ),
          ),
        ),
        loginProviders: <LoginProvider>[
          LoginProvider(
            icon: FontAwesomeIcons.google,
            label: 'Google',
            callback: () async {
              await FireBaseHelper.fireBaseHelper.loginWithGoogle();
              // debugPrint('start google sign in');
              await Future.delayed(loginTime);
              // debugPrint('stop google sign in');
              // return null;
            },
          ),
          // LoginProvider(
          //   icon: FontAwesomeIcons.linkedinIn,
          //   label: 'Linkdin',
          //   callback: () async {
          //     debugPrint('start linkdin sign in');
          //     await Future.delayed(loginTime);
          //     debugPrint('stop linkdin sign in');
          //     return null;
          //   },
          // ),
          // LoginProvider(
          //   icon: FontAwesomeIcons.githubAlt,
          //   label: 'Github',
          //   callback: () async {
          //     debugPrint('start github sign in');
          //     await Future.delayed(loginTime);
          //     debugPrint('stop github sign in');
          //     return null;
          //   },
          // ),
        ],
        onSubmitAnimationCompleted: () {
          Navigator.of(context).pushReplacementNamed(
            (user != null) ? MyRoutes.home : MyRoutes.languagePage,
          );
        },
      ),
    );
  }
}
