import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_wallpaper_app/utils/route_utils.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 18),
            child: ShaderMask(
              shaderCallback: (rect) {
                return const LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black, Colors.transparent])
                    .createShader(
                        Rect.fromLTRB(0, 200, rect.width, rect.height));
              },
              blendMode: BlendMode.dstIn,
              child: SizedBox(
                height: h * 0.72,
                width: w * 1,
                child: Image.asset(
                  'assets/images/intro.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.6),
            child: Text(
              "Explore Ultra 4K\n     Wallpapers",
              style: GoogleFonts.poppins(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const Align(
            alignment: Alignment(0, 0.74),
            child: Text(
              "      Explore,Create,Share\n  Ultra 4K Wallpapers Now!",
              style: TextStyle(
                fontSize: 15,
                color: Colors.white54,
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.94),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed(MyRoutes.loginPage);
              },
              child: Container(
                height: h * 0.065,
                width: w * 0.65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(0xffFDBC02),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Start Explore",
                  style: GoogleFonts.poppins(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
