import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_wallpaper_app/controller/wallpaper_controller.dart';
import 'package:my_wallpaper_app/utils/route_utils.dart';
import 'package:provider/provider.dart';

import '../../controller/theme_controller.dart';
import '../../modal/wallpaper_modal.dart';

class AllCategories extends StatelessWidget {
  const AllCategories({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic? data = ModalRoute.of(context)!.settings.arguments;

    return Consumer<ThemeController>(builder: (context, pro, _) {
      Size s = MediaQuery.of(context).size;
      double h = s.height;
      double w = s.width;

      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: pro.isDark ? Colors.white : const Color(0xff191d2e),
          leading: IconButton(
            color: pro.isDark ? Colors.black : const Color(0xffFDBC02),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  MyRoutes.categoriesPage, (route) => false);
            },
          ),
          title: Text(
            data,
            style: TextStyle(
              color: pro.isDark ? Colors.black : Color(0xffFDBC02),
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: pro.isDark ? Colors.white : const Color(0xff191d2e),
        body: Consumer<WallpaperController>(builder: (context, pro, _) {
          return Padding(
            padding: const EdgeInsets.all(4),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  StaggeredGrid.count(
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    crossAxisCount: 3,
                    children: List.generate(pro.allWallpapers.length, (index) {
                      Wallpaper wallpaper = pro.allWallpapers[index];

                      return StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: index % 2 == 0 ? 1.4 : 1.7,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      MyRoutes.detailsPage,
                                      arguments: pro.allWallpapers[index]);
                                },
                                child: Container(
                                  height: h * 0.8,
                                  width: w * 0.5,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            wallpaper.largeImageUrl),
                                        fit: BoxFit.cover),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Wallpaper wallpaper = pro.allWallpapers[index];
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      pro.allWallpapers[index].isLiked
                                          ? CupertinoIcons.heart_fill
                                          : CupertinoIcons.heart,
                                      color: pro.allWallpapers[index].isLiked
                                          ? Colors.red
                                          : Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        }),
      );
    });
  }
}
