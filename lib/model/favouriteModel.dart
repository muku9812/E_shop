class FavouriteModel {
  String id;
  String productId;
  String title;
  String description;
  String imageUrl;

  FavouriteModel({
    required this.id,
    required this.title,
    required this.productId,
    required this.description,
    required this.imageUrl,
  });

  factory FavouriteModel.fromJson(Map<String, dynamic> json) {
    return FavouriteModel(
      id: json['id'],
      title: json['title'],
      productId: json['productId'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'productId': productId,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}
