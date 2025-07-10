// lib/features/home/models/cat_image.dart

class CatImage {
  final String url;
  CatImage({required this.url});

  factory CatImage.fromJson(Map<String, dynamic> json) {
    return CatImage(url: json['url'] as String);
  }
}
