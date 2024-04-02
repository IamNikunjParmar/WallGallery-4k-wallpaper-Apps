import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_wallpaper_app/controller/wallpaper_controller.dart';
import 'package:my_wallpaper_app/modal/wallpaper_modal.dart';
import 'package:provider/provider.dart';
import 'package:circular_menu/circular_menu.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final Wallpaper wallpaper =
        ModalRoute.of(context)!.settings.arguments as Wallpaper;

    return Consumer<WallpaperController>(builder: (context, pro, _) {
      return Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: 868,
              child: Image(
                image: NetworkImage(wallpaper.largeImageUrl),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 5,
              top: 40,
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.black.withOpacity(0.4),
                  ),
                  iconColor: MaterialStateProperty.all(
                    Colors.white,
                  ),
                ),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                label: const Text(""),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Transform.translate(
                offset: const Offset(0, -10),
                child: CircularMenu(
                  toggleButtonColor: Colors.black.withOpacity(0.4),
                  items: [
                    CircularMenuItem(
                      // enableBadge: true,
                      icon: Icons.lock,
                      badgeLabel: "LockScreen",
                      badgeTextColor: Colors.white,
                      iconColor: const Color(0xffFDBC02),
                      color: Colors.black.withOpacity(0.4),
                      onTap: () {
                        pro.setLockWallpaper(link: wallpaper.largeImageUrl);
                      },
                    ),
                    CircularMenuItem(
                      icon: Icons.home,
                      badgeLabel: "HomeScreen",
                      badgeTextColor: Colors.white,
                      iconColor: const Color(0xffFDBC02),
                      color: Colors.black.withOpacity(0.4),
                      onTap: () {
                        pro.setHomeWallpaper(link: wallpaper.largeImageUrl);
                      },
                    ),
                    CircularMenuItem(
                      //enableBadge: true,
                      icon: FontAwesomeIcons.mobileScreen,
                      iconColor: const Color(0xffFDBC02),
                      color: Colors.black.withOpacity(0.4),
                      onTap: () {
                        pro.setBothWallpaper(link: wallpaper.largeImageUrl);
                      },
                    ),
                    CircularMenuItem(
                      //enableBadge: true,
                      icon: FontAwesomeIcons.heart,
                      iconColor: const Color(0xffFDBC02),
                      color: Colors.black.withOpacity(0.4),
                      onTap: () {
                        pro.WallpaperLikeStatus(context, wallpaper);
                      },
                    ),
                    CircularMenuItem(
                      //enableBadge: true,
                      icon: Icons.share,
                      iconColor: const Color(0xffFDBC02),
                      color: Colors.black.withOpacity(0.4),
                      onTap: () {
                        pro.shareWallpaper(wallpaper.largeImageUrl);
                      },
                    ),
                    CircularMenuItem(
                      //enableBadge: true,
                      icon: Icons.download,
                      iconColor: const Color(0xffFDBC02),
                      color: Colors.black.withOpacity(0.4),
                      onTap: () {
                        pro.saveWallpaperToGallery(wallpaper.largeImageUrl);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            showCloseIcon: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                            content: const Text('Wallpaper saved to gallery'),
                            backgroundColor: Colors.black.withOpacity(0.4),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
