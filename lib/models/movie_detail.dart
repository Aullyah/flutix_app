part of 'models.dart';

class MovieDetail extends Equatable {
  final List<String> genres;
  final String language;
  final Movie movie;

  MovieDetail(this.movie, {this.genres, this.language}) : super();

  String get genresAndLanguage {
    String s = "";

    for (var genre in genres) {
      s += genre + (genre != genres.last ? ', ' : '');
    }

    return "$s - $language";
  }

  @override
  List<Object> get props => [];
}
