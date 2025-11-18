import 'package:cinemapedia_220361/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia_220361/domain/entities/actor.dart';
import 'package:cinemapedia_220361/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository {

  final ActorsDatasource datasource;
  ActorRepositoryImpl(this.datasource);


  @override
  Future<List<Actor>> getActorsByMovie(String movieId){
    return datasource.getActorsByMovie(movieId);
  }


}