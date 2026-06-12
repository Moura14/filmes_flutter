
import '../datasource/filmes_datasource.dart';
import 'package:project_flutter/feature/filmes/data/models/filmes_model.dart';

abstract class FilmesRepositories {
  Future<List<MovieModel>> getFilmesPopulares();
}


class FilmesRepositoriesImpl implements FilmesRepositories {

  final FilmesDatasource  datasource;

  FilmesRepositoriesImpl(this.datasource);

  @override
  Future<List<MovieModel>> getFilmesPopulares() async {
    return await datasource.getFilmesPopulares();
  }
}