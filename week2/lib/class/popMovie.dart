class PopMovie {
  final int id;
  String title;
  String homepage;
  String overview;
  String release_date;
  String vote_average;
  int runtime;
  List? genres;
  List? actor;

  PopMovie(
      {required this.id,
      required this.title,
      required this.homepage,
      required this.overview,
      required this.release_date,
      required this.vote_average,
      required this.runtime,
      required this.genres,
      required this.actor});
  factory PopMovie.fromJson(Map<String, dynamic> json) {
    return PopMovie(
      id: json['movie_id'] as int,
      title: json['title'] as String,
      homepage: json['homepage'] as String,
      overview: json['overview'] as String,
      release_date: json['release_date'] as String,
      vote_average: json['vote_average'] as String,
      runtime: json['runtime'] as int,
      genres: json['genres'],
      actor: json['actor']
    );
  }
}
