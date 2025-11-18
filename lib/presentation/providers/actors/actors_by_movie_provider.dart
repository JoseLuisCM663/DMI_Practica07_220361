import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia_220361/domain/entities/actor.dart';
import 'package:cinemapedia_220361/presentation/providers/actors/actors_repository_provider.dart';

// 🔹 Provider principal
final actorsByMovieProvider = NotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>(ActorsByMovieNotifier.new);

// 🔹 Definición del tipo callback
typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

// 🔹 Notifier actualizado a la nueva sintaxis de Riverpod 3
class ActorsByMovieNotifier extends Notifier<Map<String, List<Actor>>> {
  late final GetActorsCallback getActors;

  @override
  Map<String, List<Actor>> build() {
    // Se obtiene el repositorio dentro del método build()
    final actorsRepository = ref.watch(actorsRepositoryProvider);
    getActors = actorsRepository.getActorsByMovie;

    // Estado inicial vacío
    return {};
  }

  // 🔹 Carga de actores por película
  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;

    final List<Actor> actors = await getActors(movieId);
    state = {...state, movieId: actors};
  }
}
