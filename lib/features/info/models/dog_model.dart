class DogModel {
  final String image;

  DogModel({
    required this.image,
  });

  factory DogModel.fromJson(String image) {
    return DogModel(
      image: image,
    );
  }
}