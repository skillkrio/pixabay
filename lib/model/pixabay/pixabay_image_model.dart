class PixabayImageModel {
  final String url;
  final int likes;
  final int views;

  PixabayImageModel(
      {required this.url, required this.likes, required this.views});

  factory PixabayImageModel.fromJson(Map<String, dynamic> json) {
    return PixabayImageModel(
      views: json['views'],
      url: json['webformatURL'],
      likes: json['likes'],
    );
  }
  static List<PixabayImageModel> constructList(List imageList) {
    return imageList
        .map(
          (entity) => PixabayImageModel.fromJson(entity),
        )
        .toList();
  }
}
