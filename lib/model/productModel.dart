class ProductModel {
  String id;
  String title;
  String description;
  String image;
  String uid;
  ProductModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.image,
      required this.uid});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      uid: json['uid'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'title': title,
      'description': description,
      'image': image,
    };
  }
}
