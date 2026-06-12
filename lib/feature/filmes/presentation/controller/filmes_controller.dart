import 'package:mobx/mobx.dart';
import 'package:project_flutter/feature/filmes/data/models/filmes_model.dart';
import 'package:project_flutter/feature/filmes/domain/usecase/filmes_usecase.dart';

part 'filmes_controller.g.dart';

class FilmesController = _FilmesController with _$FilmesController;

abstract class _FilmesController with Store {

  final FilmesUsecases usecases;
  
  _FilmesController(this.usecases);

  @observable
  bool isLoading = false;

  @observable
  List<MovieModel> filmes = [];


  @action
  Future<void> getFilmesPopulares() async {
    isLoading = true;
    try {
      filmes = await usecases.getFilmesPopulares();
    } catch (e) {
      print('Erro ao buscar filmes populares: $e');
    } finally {
      isLoading = false;
    }
  }
  
}