import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_wallpaper_app/controller/theme_controller.dart';
import 'package:my_wallpaper_app/controller/wallpaper_controller.dart';
import 'package:my_wallpaper_app/utils/route_utils.dart';
import 'package:my_wallpaper_app/views/class/local_string.dart';
import 'package:my_wallpaper_app/views/componets/all_categories.dart';
import 'package:my_wallpaper_app/views/screens/categorie_page.dart';
import 'package:my_wallpaper_app/views/screens/details_page.dart';
import 'package:my_wallpaper_app/views/screens/home_page.dart';
import 'package:my_wallpaper_app/views/screens/intro_screen.dart';
import 'package:my_wallpaper_app/views/screens/lanagues_page.dart';
import 'package:my_wallpaper_app/views/screens/liked_page.dart';
import 'package:my_wallpaper_app/views/screens/login_page.dart';
import 'package:my_wallpaper_app/views/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => WallpaperController(),
      ),
      ChangeNotifierProvider(
        create: (context) => ThemeController(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: LocalString(),
      locale: const Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "Poppins",
      ),
      themeMode: Provider.of<ThemeController>(context).isDark
          ? ThemeMode.dark
          : ThemeMode.light,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      initialRoute: MyRoutes.splashScreen,
      routes: {
        MyRoutes.home: (context) => HomePage(),
        MyRoutes.splashScreen: (context) => const SplashScreen(),
        MyRoutes.introScreen: (context) => const IntroScreen(),
        MyRoutes.languagePage: (context) => LanguagePage(),
        MyRoutes.loginPage: (context) => LoginPage(),
        MyRoutes.categoriesPage: (context) => const CategoriesPage(),
        MyRoutes.likedPage: (context) => const LikedPage(),
        MyRoutes.allCategories: (context) => const AllCategories(),
        MyRoutes.detailsPage: (context) => const DetailPage(),
      },
    );
  }
}
