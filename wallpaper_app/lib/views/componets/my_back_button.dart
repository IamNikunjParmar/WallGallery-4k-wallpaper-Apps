import 'package:flutter/material.dart';
import 'package:my_wallpaper_app/controller/theme_controller.dart';
import 'package:my_wallpaper_app/utils/route_utils.dart';
import 'package:provider/provider.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(builder: (context, pro, _) {
      return IconButton(
        onPressed: () => Navigator.of(context)
            .pushNamedAndRemoveUntil(MyRoutes.home, (route) => false),
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: pro.isDark ? Colors.black : Colors.yellow,
        ),
      );
    });
  }
}
