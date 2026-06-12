import 'package:project_flutter/feature/filmes/data/models/filmes_model.dart';
import 'package:project_flutter/feature/filmes/data/repositories/filmes_repositories.dart';

class FilmesUsecases{


  final FilmesRepositories repositories;

  FilmesUsecases(this.repositories);

  Future<List<MovieModel>> getFilmesPopulares() async {
    return await repositories.getFilmesPopulares();
  }
}