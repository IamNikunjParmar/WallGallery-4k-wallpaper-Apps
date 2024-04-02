import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_wallpaper_app/controller/theme_controller.dart';
import 'package:my_wallpaper_app/controller/wallpaper_controller.dart';
import 'package:my_wallpaper_app/helper/firebase_auth_helper.dart';
import 'package:my_wallpaper_app/helper/wallpaper_helper.dart';
import 'package:my_wallpaper_app/modal/wallpaper_modal.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/route_utils.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  User? user = FireBaseHelper.fireBaseHelper.firebaseAuth.currentUser;

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Consumer<ThemeController>(builder: (context, pro, _) {
        return Scaffold(
          drawer: Drawer(
            backgroundColor:
                pro.isDark ? Colors.white : const Color(0xff262930),
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(15)),
                    // border: Border(
                    //   bottom: BorderSide(color: Colors.yellow, width: 1),
                    //   //  left: BorderSide(color: Colors.yellow, width: 3),
                    //   // top: BorderSide(color: Colors.yellow, width: 1),
                    //   right: BorderSide(color: Colors.yellow, width: 2),
                    // ),
                    color: pro.isDark ? Colors.white : Color(0xff262930),
                  ),
                  currentAccountPicture: ClipRRect(
                    child: CircleAvatar(
                      foregroundImage: NetworkImage(
                        user?.photoURL ??
                            "https://cdn4.iconfinder.com/data/icons/ionicons/512/icon-ios7-contact-512.png",
                      ),
                    ),
                  ),
                  accountEmail: Text(
                    user?.email ?? " email not found",
                    style: TextStyle(
                      color: pro.isDark ? Colors.black : Colors.white,
                    ),
                  ),
                  accountName: Text(
                    user?.displayName ?? "",
                    style: TextStyle(
                      color: pro.isDark ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Consumer<ThemeController>(builder: (context, pro, _) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: ListTile(
                          title: Text(
                            "Home",
                            style: TextStyle(
                              color: pro.isDark ? Colors.black : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: const Icon(
                            FontAwesomeIcons.house,
                            color: Color(0xffFDBC02),
                            size: 20,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: ListTile(
                          title: Text(
                            "Dark Mode",
                            style: TextStyle(
                              color: pro.isDark ? Colors.black : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: const Icon(
                            Icons.dark_mode,
                            color: Color(0xffFDBC02),
                            size: 20,
                          ),
                          trailing: Switch(
                            value: pro.isDark,
                            onChanged: (value) {
                              pro.themeChange();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  showCloseIcon: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                  ),
                                  content: pro.isDark
                                      ? const Text(
                                          'Light Mode Active',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      : const Text(
                                          "Dark Mode Active",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                  backgroundColor: const Color(0xffFDBC02),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(MyRoutes.categoriesPage);
                        },
                        child: ListTile(
                          title: Text(
                            "Categories",
                            style: TextStyle(
                              color: pro.isDark ? Colors.black : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: const Icon(
                            Icons.category,
                            color: Color(0xffFDBC02),
                            size: 20,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(MyRoutes.likedPage);
                        },
                        child: ListTile(
                          title: Text(
                            "Liked WallPaper",
                            style: TextStyle(
                              color: pro.isDark ? Colors.black : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: const Icon(
                            FontAwesomeIcons.solidHeart,
                            color: Color(0xffFDBC02),
                            size: 20,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          var link =
                              "https://wallgalleryprivacy.blogspot.com/2024/03/wallgallery-4k-wallpaper-apps.html";
                          launchUrl(
                            Uri.parse(link),
                          );
                        },
                        child: ListTile(
                          title: Text(
                            "Privacy Policy",
                            style: TextStyle(
                              color: pro.isDark ? Colors.black : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: const Icon(
                            Icons.privacy_tip_outlined,
                            color: Color(0xffFDBC02),
                            size: 20,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          (user != null)
                              ? Navigator.of(context)
                                  .pushNamed(MyRoutes.languagePage)
                              : Navigator.of(context)
                                  .pushReplacementNamed(MyRoutes.languagePage);
                        },
                        child: ListTile(
                          title: Text(
                            "Language Changed",
                            style: TextStyle(
                              color: pro.isDark ? Colors.black : Colors.white,
                              fontWeight: FontWeight.bold,
                              //  fontSize: 18,
                            ),
                          ),
                          leading: const Icon(
                            Icons.language,
                            color: Color(0xffFDBC02),
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                const Spacer(),
                ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color(0xffFDBC02),
                    ),
                  ),
                  onPressed: () async {
                    FireBaseHelper.fireBaseHelper.logoutUser().then((value) =>
                        Navigator.of(context)
                            .pushReplacementNamed(MyRoutes.loginPage));
                  },
                  label: const Text(
                    "LogOut",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  icon: const Icon(
                    FontAwesomeIcons.arrowRightFromBracket,
                    color: Colors.black,
                  ),
                ),
                const Center(
                  child: SizedBox(
                    height: 50,
                  ),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            iconTheme:
                IconThemeData(color: pro.isDark ? Colors.black : Colors.white),
            backgroundColor:
                pro.isDark ? Colors.white : const Color(0xff191d2e),
            title: Text(
              'WallGallery'.tr,
              style: TextStyle(
                color: pro.isDark ? Colors.black : Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            //centerTitle: true,
          ),
          backgroundColor: pro.isDark ? Colors.white : const Color(0xff181C2E),
          body: Consumer<WallpaperController>(builder: (context, pro, _) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: SizedBox(
                    height: 55,
                    child: TextField(
                      textInputAction: TextInputAction.search,
                      keyboardType: TextInputType.text,
                      onSubmitted: (val) {
                        pro.getWallPaper(query: val);
                      },
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          hintText: "search".tr,
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      ApiHelper.apiHelper.allCategory.length,
                      (index) {
                        var cat = ApiHelper.apiHelper.allCategory[index];
                        var img = ApiHelper.apiHelper.allImages[index];
                        return GestureDetector(
                          onTap: () {
                            pro.getWallPaper(query: cat);
                            print('${cat}');
                          },
                          child: Container(
                            height: h * 0.05,
                            width: w * 0.29,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: Color(0xffFDBC02),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              // image: DecorationImage(
                              //   image: AssetImage(img),
                              //   fit: BoxFit.cover,
                              // ),
                            ),
                            child: Text(
                              cat,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: StaggeredGrid.count(
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      crossAxisCount: 2,
                      children:
                          List.generate(pro.allWallpapers.length, (index) {
                        Wallpaper wallpaper = pro.allWallpapers[index];

                        return StaggeredGridTile.count(
                          crossAxisCellCount: 1,
                          mainAxisCellCount: index % 2 == 0 ? 1.4 : 1.7,
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        MyRoutes.detailsPage,
                                        arguments: pro.allWallpapers[index]);
                                  },
                                  child: Container(
                                    // margin: const EdgeInsets.all(2),
                                    height: h * 0.8,
                                    width: w * 0.5,
                                    decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(1.7, 1.7),
                                          blurRadius: 2,
                                        ),
                                      ],
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
                                  pro.WallpaperLikeStatus(context, wallpaper);
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
                  ),
                ),
              ],
            );
          }),
        );
      }),
    );
  }
}
