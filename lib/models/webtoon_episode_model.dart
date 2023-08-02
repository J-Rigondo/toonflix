class WebtoonEpisodeModel {
  final String id, title, rating, date, thumb;

  const WebtoonEpisodeModel({
    required this.id,
    required this.title,
    required this.rating,
    required this.date,
    required this.thumb,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'rating': this.rating,
      'date': this.date,
    };
  }

  factory WebtoonEpisodeModel.fromMap(Map<String, dynamic> map) {
    return WebtoonEpisodeModel(
        id: map['id'] as String,
        title: map['title'] as String,
        rating: map['rating'] as String,
        date: map['date'] as String,
        thumb: map['thumb'] as String);
  }
}
