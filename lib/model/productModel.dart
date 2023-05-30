class ProductModel {
  String id;
  String title;
  String description;
  String image;
  ProductModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.image});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
    };
  }
}
