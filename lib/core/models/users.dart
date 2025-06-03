class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String? image;
  final String confirmPassword;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'image': image,
    };
  }
}
