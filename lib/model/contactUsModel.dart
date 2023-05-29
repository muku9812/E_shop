class ContactUsModel {
  String id;
  String name;
  String feedback;
  String email;

  ContactUsModel(
      {required this.id,
      required this.name,
      required this.feedback,
      required this.email});

  factory ContactUsModel.fromJson(Map<String, dynamic> json) {
    return ContactUsModel(
      id: json['id'],
      name: json['name'],
      feedback: json['feedback'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'feedback': feedback,
      'email': email,
    };
  }
}
