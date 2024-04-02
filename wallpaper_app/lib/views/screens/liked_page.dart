import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wallpaper_app/controller/theme_controller.dart';
import 'package:provider/provider.dart';

import '../../helper/firebase_auth_helper.dart';
import '../../modal/wallpaper_modal.dart';
import '../componets/my_back_button.dart';

class LikedPage extends StatelessWidget {
  const LikedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Object? wallpaper = ModalRoute.of(context)!.settings.arguments;

    return Consumer<ThemeController>(builder: (context, pro, _) {
      return Scaffold(
        appBar: AppBar(
          leading: const MyBackButton(),
          iconTheme:
              IconThemeData(color: pro.isDark ? Colors.black : Colors.white),
          backgroundColor: pro.isDark ? Colors.white : const Color(0xff191d2e),
          centerTitle: true,
          title: Text(
            'like'.tr,
            style: TextStyle(
              color: pro.isDark ? Colors.black : const Color(0xffFDBC02),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          //centerTitle: true,
        ),
        backgroundColor: pro.isDark ? Colors.white : const Color(0xff181C2E),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                child: Text(
                  'nolike'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: pro.isDark ? Colors.black : Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
