class Movie {
  String title;
  String overview;
  String originalLanguage;
  double popularity;
  String releaseDate;
  double voteAverage;
  String voteCount;
  String posterPath;

  Movie({
    required this.title,
    required this.overview,
    required this.originalLanguage,
    required this.popularity,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.posterPath,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      overview: json['overview'],
      originalLanguage: json['original_language'],
      popularity: json['popularity'],
      releaseDate: json['release_date'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
      posterPath: json['poster_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'overview': overview,
      'original_language': originalLanguage,
      'popularity': popularity,
      'release_date': releaseDate,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'poster_path': posterPath,
    };
  }
}
