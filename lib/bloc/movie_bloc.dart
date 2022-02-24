import 'package:bwa_flutix/models/models.dart';
import 'package:bwa_flutix/services/services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  @override
  MovieState get initialState => MovieInitial();

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is FetchMovie) {
      List<Movie> movies = await MovieServices.getMovies(1);
      yield MovieLoaded(movies: movies);
    }
  }
}
