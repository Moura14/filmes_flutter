import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:project_flutter/feature/filmes/data/datasource/filmes_datasource.dart';
import 'package:project_flutter/feature/filmes/data/repositories/filmes_repositories.dart';
import 'package:project_flutter/feature/filmes/domain/usecase/filmes_usecase.dart';
import 'package:project_flutter/feature/filmes/presentation/controller/filmes_controller.dart';

final getIt = GetIt.instance;


void setup() {
  // Register Dio
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Register Datasource
  getIt.registerLazySingleton<FilmesDatasource>(
      () => FilmesDatasourceImpl(getIt<Dio>()));

  // Register Repository
  getIt.registerLazySingleton<FilmesRepositories>(
      () => FilmesRepositoriesImpl(getIt<FilmesDatasource>()));

  // Register Usecases
  getIt.registerLazySingleton<FilmesUsecases>(
      () => FilmesUsecases(getIt<FilmesRepositories>()));

  // Register Controller
  getIt.registerLazySingleton<FilmesController>(
      () => FilmesController(getIt<FilmesUsecases>()));
}