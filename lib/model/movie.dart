class Movie {
  String title;
  String overview;
  String originalLanguage;
  double popularity;
  String releaseDate;
  double voteAverage;
  int voteCount;
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
}
