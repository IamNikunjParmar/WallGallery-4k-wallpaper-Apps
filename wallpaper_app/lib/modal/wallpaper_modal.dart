class Wallpaper {
  final id;
  String previewUrl;
  String largeImageUrl;
  int views;
  int downloads;
  int collections;
  int likes;
  int comments;
  bool isLiked;

  Wallpaper({
    required this.id,
    required this.previewUrl,
    required this.largeImageUrl,
    required this.views,
    required this.downloads,
    required this.collections,
    required this.likes,
    required this.comments,
    required this.isLiked,
  });

  factory Wallpaper.fromJson({required Map<String, dynamic> json}) => Wallpaper(
        previewUrl: json["previewURL"],
        largeImageUrl: json["largeImageURL"],
        views: json["views"],
        downloads: json["downloads"],
        collections: json["collections"],
        likes: json["likes"],
        comments: json["comments"],
        isLiked: json['isLiked'] ?? false,
        id: json['id'] ?? '',
      );
}
