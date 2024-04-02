import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_wallpaper_app/views/screens/home_page.dart';
import 'package:my_wallpaper_app/views/screens/intro_screen.dart';
import 'package:my_wallpaper_app/views/screens/login_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../helper/firebase_auth_helper.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FireBaseHelper.fireBaseHelper.firebaseAuth.currentUser;

    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;

    return AnimatedSplashScreen(
      duration: 4400,
      backgroundColor: const Color(0xffFDBC02),
      splash: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Image(
            height: h * 0.3,
            width: w * 0.3,
            image: const AssetImage('assets/icons/new.png'),
          ),
          Align(
            alignment: const Alignment(0, 0.75),
            child: Text(
              "WallGallery",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            )
                .animate(delay: 1300.milliseconds)
                .fade(delay: 1300.milliseconds)
                .slideY(curve: Curves.easeIn),
          ),
        ],
      ),
      splashIconSize: 260,
      nextScreen: (user != null) ? HomePage() : const IntroScreen(),
      splashTransition: SplashTransition.scaleTransition,
      pageTransitionType: PageTransitionType.rightToLeft,
      animationDuration: const Duration(seconds: 2),
    );
  }
}
