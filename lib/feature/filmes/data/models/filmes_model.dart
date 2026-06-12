class FilmesResponseModel {
  final int? page;
  final List<MovieModel>? results;
  final int? totalPages;
  final int? totalResults;

  FilmesResponseModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory FilmesResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return FilmesResponseModel(
      page: json['page'],

      results: (json['results'] as List<dynamic>?)
          ?.map(
            (e) => MovieModel.fromJson(e),
          )
          .toList(),

      totalPages: json['total_pages'],

      totalResults: json['total_results'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,

      'results':
          results?.map((e) => e.toJson()).toList(),

      'total_pages': totalPages,

      'total_results': totalResults,
    };
  }
}

class MovieModel {
  final bool? adult;
  final String? backdropPath;
  final List<int>? genreIds;
  final int? id;
  final String? title;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? releaseDate;
  final bool? softcore;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  MovieModel({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.title,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.softcore,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory MovieModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return MovieModel(
      adult: json['adult'],

      backdropPath: json['backdrop_path'],

      genreIds:
          (json['genre_ids'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList(),

      id: json['id'],

      title: json['title'],

      originalLanguage:
          json['original_language'],

      originalTitle:
          json['original_title'],

      overview: json['overview'],

      popularity:
          (json['popularity'] as num?)
              ?.toDouble(),

      posterPath:
          json['poster_path'],

      releaseDate:
          json['release_date'],

      softcore:
          json['softcore'],

      video: json['video'],

      voteAverage:
          (json['vote_average'] as num?)
              ?.toDouble(),

      voteCount:
          json['vote_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,

      'backdrop_path': backdropPath,

      'genre_ids': genreIds,

      'id': id,

      'title': title,

      'original_language':
          originalLanguage,

      'original_title': originalTitle,

      'overview': overview,

      'popularity': popularity,

      'poster_path': posterPath,

      'release_date': releaseDate,

      'softcore': softcore,

      'video': video,

      'vote_average': voteAverage,

      'vote_count': voteCount,
    };
  }
}