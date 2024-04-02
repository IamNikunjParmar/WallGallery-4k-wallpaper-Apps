import 'package:get/get.dart';

class LocalString extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'WallGallery',
          'message': "WELCOME TO PROTO CODERS POINT",
          'search': 'Search For Wallpaper',
          'like': 'Favourite',
          'nolike': 'No Liked WallPaper',
        },
        'hi_IN': {
          'WallGallery': 'वॉलगैलरी',
          'message': "प्रोटो कोडर्स पॉइंट में आपका स्वागत है",
          'search': 'वॉलपेपर खोजें',
          'like': 'पसंदीदा',
          'nolike': 'नो लाइक्ड वॉलपेपर',
        },
        'gu_IN': {
          'WallGallery': 'વોલગેલેરી',
          'message': "प्रोटो कोडर्स पॉइंट में आपका स्वागत है",
          'search': 'વૉલપેપર શોધો',
          'like': 'મનપસંદ',
          'nolike': 'ગમ્યું વોલપેપર નથી',
        },
      };
}
