class UserModel {
  final String name;
  final String email;
  final String country;
  final String image;

  UserModel({
    required this.name,
    required this.email,
    required this.country,
    required this.image,
  });

  factory UserModel.fromJson(
      Map<String, dynamic> json,
      ) {
    final name = json['name'] ?? {};

    return UserModel(
      name:
      '${name['first'] ?? ''} ${name['last'] ?? ''}',
      email: json['email'] ?? '',
      country: json['location']?['country'] ?? '',
      image: json['picture']?['medium'] ?? '',
    );
  }
}