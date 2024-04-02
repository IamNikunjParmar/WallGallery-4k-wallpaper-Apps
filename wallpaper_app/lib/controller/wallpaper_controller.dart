import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_wallpaper_app/modal/wallpaper_modal.dart';
import 'package:share_plus/share_plus.dart';

import '../helper/firebase_auth_helper.dart';
import '../helper/wallpaper_helper.dart';

class WallpaperController extends ChangeNotifier {
  List<Wallpaper> allWallpapers = [];

  WallpaperController() {
    getWallPaper();
  }

  bool isDark = false;

  getWallPaper({String query = "4k wallpaper"}) async {
    allWallpapers = await ApiHelper.apiHelper.getWallpaper(query: query) ?? [];

    notifyListeners();
  }

  Future<void> setHomeWallpaper({required String link}) async {
    try {
      await AsyncWallpaper.setWallpaper(
        url: link,
        wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
        toastDetails: ToastDetails(
          message: "Wallpaper set successfully",
        ),
        errorToastDetails: ToastDetails(
          message: "Failed to set wallpaper",
        ),
      );
    } catch (e) {
      print("Error setting wallpaper: $e");
    }
  }

  Future<void> setLockWallpaper({required String link}) async {
    try {
      await AsyncWallpaper.setWallpaper(
        url: link,
        wallpaperLocation: AsyncWallpaper.LOCK_SCREEN,
        toastDetails: ToastDetails(
          message: "Wallpaper set successfully",
        ),
        errorToastDetails: ToastDetails(
          message: "Failed to set wallpaper",
        ),
      );
    } catch (e) {
      print("Error setting wallpaper: $e");
    }
  }

  Future<void> setBothWallpaper({required String link}) async {
    try {
      await AsyncWallpaper.setWallpaper(
        url: link,
        wallpaperLocation: AsyncWallpaper.BOTH_SCREENS,
        toastDetails: ToastDetails(
          message: "Wallpaper set successfully",
        ),
        errorToastDetails: ToastDetails(
          message: "Failed to set wallpaper",
        ),
      );
    } catch (e) {
      print("Error setting wallpaper: $e");
    }
  }

  Future<void> shareWallpaper(String imageUrl) async {
    try {
      await Share.share(imageUrl);
    } catch (e) {
      print('Error sharing wallpaper: $e');
    }
  }

  Future<void> saveWallpaperToGallery(String imageUrl) async {
    try {
      final imageData = await _getImageData(imageUrl);
      final result = await ImageGallerySaver.saveImage(imageData);

      print('Image saved to gallery: $result');
    } catch (e) {
      print('Error saving image to gallery: $e');
    }
  }

  Future<Uint8List> _getImageData(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load image');
    }
  }

  void WallpaperLikeStatus(BuildContext context, Wallpaper wallpaper) {
    // like wallpaper
    wallpaper.isLiked = !wallpaper.isLiked;

    // Update Firebase
    FireBaseHelper.fireBaseHelper.wallpaperLikeStatus(context, wallpaper);
    notifyListeners();
  }
}
