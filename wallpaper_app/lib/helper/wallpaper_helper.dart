import 'dart:convert';
import 'package:http/http.dart' as http;

import '../modal/wallpaper_modal.dart';

class ApiHelper {
  ApiHelper._();

  List allImages = [
    //A
    'assets/catImage/abstract.jpg',
    'assets/catImage/animal.jpg',
    'assets/catImage/artistic2.jpg',
    'assets/catImage/astronomy.jpg',
    'assets/catImage/autumn.jpg',
    //B
    'assets/catImage/background.jpg',
    'assets/catImage/babies.jpg',
    'assets/catImage/birds.jpg',
    'assets/catImage/blue.jpg',
    'assets/catImage/bokeh.jpg',
    'assets/catImage/building.jpg',

    //c
    'assets/catImage/car.jpg',
    'assets/catImage/computer.jpg',
    'assets/catImage/cat.jpg',
    'assets/catImage/colorful.jpg',
    'assets/catImage/classic.jpg',

    //D
    'assets/catImage/dog.jpg',
    'assets/catImage/dusk.jpg',

    //all
    'assets/catImage/nature.jpg',
    'assets/catImage/sunshine.jpg',
    'assets/catImage/education.jpg',
    'assets/catImage/feeling.jpg',
    'assets/catImage/festival.jpg',
    'assets/catImage/music.jpg',
    'assets/catImage/sports.jpg',
    'assets/catImage/food.jpg',
    'assets/catImage/love.jpg',
    'assets/catImage/random.jpg',
    'assets/catImage/winter.jpg',
    'assets/catImage/travel.jpg',
  ];
  List allCategory = [
    "Abstract",
    "Animals",
    "Artistic",
    "Astronomy",
    "Autumn",
    "Background",
    "Babies",
    "Birds",
    "Blue",
    "Bokeh",
    "Buildings",
    "Cars",
    "Computer",
    "Cats",
    "Colorful",
    "Classic",
    "Dog",
    "Dusk",
    "Nature",
    "Sunshine",
    "Education",
    "Feelings",
    "Festival",
    "Music",
    "Sports",
    "food",
    "Love",
    "Random",
    "Winter",
    "Travel",
  ];

  static final ApiHelper apiHelper = ApiHelper._();

  String wallpaperApi =
      "https://pixabay.com/api/?key=39792241-01b3922a3633d54ff83ce1dc7&q=4k wallpaper&per_page=60&orientation=vertical";

  Future<List<Wallpaper>?> getWallpaper({String query = "4k wallpaper"}) async {
    http.Response response =
        await http.get(Uri.parse("$wallpaperApi&q=$query"));

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      List allData = data['hits'];

      List<Wallpaper> allWallpapers = allData
          .map((e) => Wallpaper.fromJson(
                json: e,
              ))
          .toList();

      return allWallpapers;
    } else {
      return null;
    }
  }
}
