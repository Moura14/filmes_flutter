import 'package:project_flutter/core/endpoints.dart';
import 'package:project_flutter/feature/filmes/data/models/filmes_model.dart';
import 'package:dio/dio.dart';

abstract class FilmesDatasource {
  Future<List<MovieModel>> getFilmesPopulares();
}


class FilmesDatasourceImpl implements FilmesDatasource {

  final Dio dio;

  FilmesDatasourceImpl(this.dio);
  @override
  Future<List<MovieModel>> getFilmesPopulares() async {
    try {

      final String token = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwN2I1ODYxNGI2ZmJjOTc2ZGQzNDMzMjk1MmE1ZWIyMyIsIm5iZiI6MTc3NjgyNjA3NC45NDcsInN1YiI6IjY5ZTgzNmRhZDdkNzQ1NGIzZGU0M2RjYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.3oggy6g9qbDPE-y1BxioPctM6q40xzBSfMJSrge0E2w';

      final response = await dio.get(Endpoints.filmesPopulares, options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        }));
      final filmesResponse = FilmesResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
      return filmesResponse.results ?? [];
    } catch (e) {
      throw Exception('Erro ao buscar filmes populares: $e');
    }
  }

}
