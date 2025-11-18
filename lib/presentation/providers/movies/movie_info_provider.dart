import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia_220361/domain/entities/movie.dart';
import 'package:cinemapedia_220361/presentation/providers/providers.dart';

// 🔹 Provider principal
final movieInfoProvider = NotifierProvider<MovieMapNotifier, Map<String, Movie>>(MovieMapNotifier.new);

// 🔹 Definición del tipo callback
typedef GetMovieCallback = Future<Movie> Function(String movieId);

// 🔹 Notifier actualizado
class MovieMapNotifier extends Notifier<Map<String, Movie>> {
  late final GetMovieCallback getMovie;

  @override
  Map<String, Movie> build() {
    // Se obtiene el repositorio dentro del método build()
    final movieRepository = ref.watch(movieRepositoryProvider);
    getMovie = movieRepository.getMovieById;

    // Estado inicial vacío
    return {};
  }

  // 🔹 Método para cargar una película si no está en el estado
  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;

    final movie = await getMovie(movieId);
    state = {...state, movieId: movie};
  }
}
