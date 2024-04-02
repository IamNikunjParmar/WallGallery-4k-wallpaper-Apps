import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_wallpaper_app/controller/theme_controller.dart';
import 'package:my_wallpaper_app/controller/wallpaper_controller.dart';
import 'package:my_wallpaper_app/helper/firebase_auth_helper.dart';
import 'package:my_wallpaper_app/utils/route_utils.dart';
import 'package:my_wallpaper_app/views/componets/my_back_button.dart';
import 'package:provider/provider.dart';

import '../../helper/wallpaper_helper.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(builder: (context, themeController, _) {
      return Consumer<WallpaperController>(builder: (context, pro, _) {
        Size s = MediaQuery.of(context).size;
        double h = s.height;
        double w = s.width;
        return Scaffold(
          appBar: AppBar(
            elevation: 2,
            leading: IconButton(
              color: themeController.isDark
                  ? Colors.black
                  : const Color(0xffFDBC02),
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(MyRoutes.home, (route) => false);
                pro.getWallPaper();
              },
            ),
            backgroundColor:
                themeController.isDark ? Colors.white : const Color(0xff191d2e),
            centerTitle: true,
            title: Text(
              'All Categories',
              style: TextStyle(
                color: themeController.isDark
                    ? Colors.black
                    : const Color(0xffFDBC02),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            //centerTitle: true,
          ),
          backgroundColor:
              themeController.isDark ? Colors.white : const Color(0xff181C2E),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: StaggeredGrid.count(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              children: List.generate(
                ApiHelper.apiHelper.allCategory.length,
                (index) {
                  var cat = ApiHelper.apiHelper.allCategory[index];
                  var img = ApiHelper.apiHelper.allImages[index];
                  return GestureDetector(
                    onTap: () {
                      pro.getWallPaper(query: cat);
                      print('${cat}');
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          MyRoutes.allCategories, (route) => false,
                          arguments: ApiHelper.apiHelper.allCategory[index]);
                    },
                    child: Container(
                      height: h * 0.32,
                      width: w * 1,
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.yellow.shade100,
                            blurRadius: 3,
                            offset: const Offset(2, 2),
                          )
                        ],
                        image: DecorationImage(
                          image: AssetImage(img),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Text(
                        cat,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      });
    });
  }
}
