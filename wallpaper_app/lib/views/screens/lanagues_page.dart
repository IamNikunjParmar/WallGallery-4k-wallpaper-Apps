import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wallpaper_app/controller/theme_controller.dart';
import 'package:my_wallpaper_app/utils/route_utils.dart';
import 'package:my_wallpaper_app/views/componets/my_back_button.dart';
import 'package:provider/provider.dart';

class LanguagePage extends StatelessWidget {
  LanguagePage({super.key});

  final List locale = [
    {'name': 'ENGLISH', 'locale': const Locale('en', 'US')},
    {'name': 'हिंदी', 'locale': const Locale('hi', 'IN')},
    {'name': 'ગુજરાતી', 'locale': const Locale('gu', 'IN')},
  ];

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  buildDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: const Text('Choose Your Language'),
            content: Container(
              decoration: const BoxDecoration(),
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(8),
                        child: GestureDetector(
                            onTap: () {
                              print(locale[index]['name']);
                              updateLanguage(locale[index]['locale']);
                              Navigator.of(context).pushNamed(MyRoutes.home);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  showCloseIcon: true,
                                  closeIconColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                  ),
                                  content: Text(
                                    'Language changed',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: Colors.black,
                                    ),
                                  ),
                                  backgroundColor: Color(0xffFDBC02),
                                ),
                              );
                            },
                            child: Text(
                              locale[index]['name'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            )));
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Colors.grey,
                    );
                  },
                  itemCount: locale.length),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;

    return Consumer<ThemeController>(builder: (context, pro, _) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          //leading: const MyBackButton(),
          backgroundColor: pro.isDark ? Colors.white : const Color(0xffFDBC02),
          title: const Text(
            'Language',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          foregroundColor: Colors.black,
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: h * 0.89,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage(
                        'assets/images/lang1.jpg',
                      ),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.transparent.withOpacity(0.4),
                          BlendMode.dstATop),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Please Choose your language\n         "
                        "      Click Your Button!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Align(
                        alignment: const Alignment(0, 0.2),
                        child: ElevatedButton(
                          onPressed: () {
                            buildDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            backgroundColor: pro.isDark
                                ? Colors.white
                                : const Color(0xffFDBC02),
                            foregroundColor: Colors.black,
                            elevation: 5,
                          ),
                          child: const Text(
                            'choose Languages',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
