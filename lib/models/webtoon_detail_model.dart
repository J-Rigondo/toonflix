class WebtoonDetailModel {
  final String title, about, genre, age;

  WebtoonDetailModel(
      {required this.title,
      required this.about,
      required this.genre,
      required this.age});

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'about': this.about,
      'genre': this.genre,
      'age': this.age,
    };
  }

  factory WebtoonDetailModel.fromJson(Map<String, dynamic> map) {
    return WebtoonDetailModel(
      title: map['title'] as String,
      about: map['about'] as String,
      genre: map['genre'] as String,
      age: map['age'] as String,
    );
  }
}
