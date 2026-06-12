import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:project_flutter/feature/filmes/data/models/filmes_model.dart';
import 'package:project_flutter/feature/filmes/presentation/controller/filmes_controller.dart';



class Movie {
  final String title;
  final String genre;
  final String year;
  final double rating;
  final Color backdropColor;
  final Color accentColor;
  final String emoji;

  const Movie({
    required this.title,
    required this.genre,
    required this.year,
    required this.rating,
    required this.backdropColor,
    required this.accentColor,
    required this.emoji,
  });
}

const List<Movie> featuredMovies = [
  Movie(title: 'Duna: Parte Dois', genre: 'Ficção Científica', year: '2024', rating: 8.5, backdropColor: Color(0xFF4A3000), accentColor: Color(0xFFE8B84B), emoji: '🏜️'),
  Movie(title: 'Oppenheimer', genre: 'Drama Histórico', year: '2023', rating: 8.9, backdropColor: Color(0xFF1A0A00), accentColor: Color(0xFFFF6B35), emoji: '☢️'),
  Movie(title: 'Pobres Criaturas', genre: 'Fantasia', year: '2023', rating: 8.1, backdropColor: Color(0xFF002030), accentColor: Color(0xFF4FC3F7), emoji: '🦋'),
];

const List<Movie> trendingMovies = [
  Movie(title: 'Alien: Romulus', genre: 'Terror', year: '2024', rating: 7.4, backdropColor: Color(0xFF0D1F0D), accentColor: Color(0xFF69F0AE), emoji: '👾'),
  Movie(title: 'Deadpool & Wolverine', genre: 'Ação', year: '2024', rating: 8.0, backdropColor: Color(0xFF2D0000), accentColor: Color(0xFFEF5350), emoji: '⚔️'),
  Movie(title: 'Coringa 2', genre: 'Drama', year: '2024', rating: 5.8, backdropColor: Color(0xFF1A1000), accentColor: Color(0xFFFFEB3B), emoji: '🃏'),
  Movie(title: 'Beetlejuice 2', genre: 'Comédia', year: '2024', rating: 7.2, backdropColor: Color(0xFF1A001A), accentColor: Color(0xFFCE93D8), emoji: '👻'),
];

const List<Movie> classicsMovies = [
  Movie(title: 'O Poderoso Chefão', genre: 'Crime', year: '1972', rating: 9.2, backdropColor: Color(0xFF1A0A00), accentColor: Color(0xFFFFCC02), emoji: '🌹'),
  Movie(title: '2001: Odisseia no Espaço', genre: 'Ficção Científica', year: '1968', rating: 8.3, backdropColor: Color(0xFF000020), accentColor: Color(0xFF80DEEA), emoji: '🚀'),
  Movie(title: 'Blade Runner', genre: 'Neo-noir', year: '1982', rating: 8.1, backdropColor: Color(0xFF0A0015), accentColor: Color(0xFFFF80AB), emoji: '🌧️'),
  Movie(title: 'Metrópolis', genre: 'Sci-Fi Clássico', year: '1927', rating: 8.3, backdropColor: Color(0xFF151510), accentColor: Color(0xFFB0BEC5), emoji: '🏙️'),
];



class HomeScreen extends StatefulWidget {
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentFeatured = 0;
  int _selectedNav = 0;

  final finalController = GetIt.I<FilmesController>();

  initState() {
    super.initState();
    final teste = finalController.getFilmesPopulares();
    print('teste ${teste}');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildTopBar()),
            SliverToBoxAdapter(child: _buildGenreChips()),
            SliverToBoxAdapter(child: _buildFeaturedCarousel()),
            SliverToBoxAdapter(child: _buildCarouselDots()),
            SliverToBoxAdapter(child: _buildSection('Em Alta', trendingMovies, compact: false)),
            SliverToBoxAdapter(child: _buildSection('Clássicos Essenciais', classicsMovies, compact: true)),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        children: [
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(text: 'Cine', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 24, fontWeight: FontWeight.w300, letterSpacing: 1)),
                TextSpan(text: 'Vault', style: TextStyle(color: Color(0xFFE8B84B), fontSize: 24, fontWeight: FontWeight.w800, letterSpacing: 1)),
              ],
            ),
          ),
          const Spacer(),
          Container(
            width: 38, height: 38,
            decoration: BoxDecoration(color: const Color(0xFF1C1C27), borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.search_rounded, color: Color(0xFFB0B0C0), size: 20),
          ),
          const SizedBox(width: 10),
          Container(
            width: 38, height: 38,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFE8B84B), width: 2), color: const Color(0xFF2C2C37)),
            child: const Center(child: Text('A', style: TextStyle(color: Color(0xFFE8B84B), fontWeight: FontWeight.bold))),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedCarousel() {
    return SizedBox(
      height: 380,
      child: Observer(
        builder: (_) {
          final filmes = finalController.filmes;
          if (filmes.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return PageView.builder(
            itemCount: filmes.length,
            onPageChanged: (index) => setState(() => _currentFeatured = index),
            itemBuilder: (context, index) => _buildFeaturedCard(filmes[index]),
          );
        },
      )
    );
  }

  Widget _buildFeaturedCard(MovieModel movie) {
    final title = movie.title ?? 'Título desconhecido';
    final year = movie.releaseDate?.split('-').first ?? '----';
    final rating = movie.voteAverage?.toStringAsFixed(1) ?? '0.0';
    final language = movie.originalLanguage ?? '';
    final imageUrl = movie.backdropPath != null && movie.backdropPath!.isNotEmpty
        ? 'https://image.tmdb.org/t/p/w500${movie.backdropPath}'
        : null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 380,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            decoration: BoxDecoration(
              image: imageUrl != null
                  ? DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.45),
                        BlendMode.darken,
                      ),
                    )
                  : null,
              color: const Color(0xFF1C1C27),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  top: -30,
                  right: -30,
                  child: Container(width: 200, height: 200, decoration: const BoxDecoration(shape: BoxShape.circle)),
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.white)),
                          child: const Text('DESTAQUE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.5, color: Colors.white)),
                        ),
                        const SizedBox(height: 16),
                        Text(title, style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w800, height: 1.1)),
                        const SizedBox(height: 6),
                        Row(children: [
                          Text('$rating/10', style: const TextStyle(color: Colors.white, fontSize: 13)),
                          const Text(' · ', style: TextStyle(color: Colors.white, fontSize: 13)),
                          Text(language, style: const TextStyle(color: Colors.white, fontSize: 13)),
                        ]),
                        const SizedBox(height: 8),
                        Text(movie.overview ?? 'Sem descrição disponível', maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 12)),
                        const SizedBox(height: 8),
                        Text('Lançamento: $year', style: const TextStyle(color: Colors.white, fontSize: 12)),
                        const Spacer(flex: 1),
                        Row(
                          children: [
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white70),
                              child: Row(mainAxisSize: MainAxisSize.min, children: const [
                                Icon(Icons.play_arrow_rounded, color: Color(0xFF0A0A0F), size: 18),
                                SizedBox(width: 4),
                                Text('Assistir', style: TextStyle(color: Color(0xFF0A0A0F), fontWeight: FontWeight.w800, fontSize: 13)),
                              ]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStarRating(double rating, Color color) {
    return Row(children: [
      Icon(Icons.star_rounded, color: color, size: 18),
      const SizedBox(width: 4),
      Text(rating.toString(), style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 15)),
      Text('/10', style: TextStyle(color: color.withOpacity(0.5), fontSize: 12)),
    ]);
  }

  Widget _buildCarouselDots() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(featuredMovies.length, (i) {
          final active = i == _currentFeatured;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: active ? 20 : 6, height: 6,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: active ? const Color(0xFFE8B84B) : const Color(0xFF3C3C50)),
          );
        }),
      ),
    );
  }

  Widget _buildSection(String title, List<Movie> movies, {required bool compact}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 14),
          child: Row(children: [
            Container(width: 3, height: 18, color: const Color(0xFFE8B84B)),
            const SizedBox(width: 10),
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
            const Spacer(),
            const Text('Ver tudo', style: TextStyle(color: Color(0xFFE8B84B), fontSize: 13)),
          ]),
        ),
        SizedBox(
          height: compact ? 160 : 210,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: movies.length,
            itemBuilder: (context, index) => compact ? _buildCompactCard(movies[index]) : _buildMovieCard(movies[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildMovieCard(Movie movie) {
    return Container(
      width: 140,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [movie.backdropColor, const Color(0xFF1C1C27)]),
        border: Border.all(color: const Color(0xFF2C2C3A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(borderRadius: const BorderRadius.vertical(top: Radius.circular(16)), color: movie.accentColor.withOpacity(0.1)),
              child: Center(child: Text(movie.emoji, style: const TextStyle(fontSize: 44))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(movie.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Row(children: [
                Icon(Icons.star_rounded, color: movie.accentColor, size: 12),
                const SizedBox(width: 3),
                Text(movie.rating.toString(), style: TextStyle(color: movie.accentColor, fontSize: 11, fontWeight: FontWeight.w700)),
              ]),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactCard(Movie movie) {
    return Container(
      width: 260,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: const Color(0xFF1C1C27), border: Border.all(color: const Color(0xFF2C2C3A))),
      child: Row(
        children: [
          Container(
            width: 80,
            decoration: BoxDecoration(borderRadius: const BorderRadius.horizontal(left: Radius.circular(14)), color: movie.accentColor.withOpacity(0.12)),
            child: Center(child: Text(movie.emoji, style: const TextStyle(fontSize: 36))),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: movie.accentColor.withOpacity(0.15), borderRadius: BorderRadius.circular(4)),
                  child: Text(movie.genre.toUpperCase(), style: TextStyle(color: movie.accentColor, fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 1)),
                ),
                const SizedBox(height: 6),
                Text(movie.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700, height: 1.2)),
                const SizedBox(height: 6),
                Row(children: [
                  Icon(Icons.star_rounded, color: movie.accentColor, size: 13),
                  const SizedBox(width: 3),
                  Text('${movie.rating}  ·  ${movie.year}', style: const TextStyle(color: Color(0xFF8080A0), fontSize: 11)),
                ]),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenreChips() {
    const genres = ['Todos', 'Ação', 'Drama', 'Terror', 'Comédia', 'Sci-Fi', 'Animação'];
    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: genres.length,
        itemBuilder: (context, index) {
          final selected = index == 0;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: selected ? const Color(0xFFE8B84B) : const Color(0xFF1C1C27),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: selected ? const Color(0xFFE8B84B) : const Color(0xFF2C2C3A)),
            ),
            child: Center(child: Text(genres[index], style: TextStyle(color: selected ? const Color(0xFF0A0A0F) : const Color(0xFF8080A0), fontSize: 13, fontWeight: selected ? FontWeight.w700 : FontWeight.w500))),
          );
        },
      ),
    );
  }

  Widget _buildBottomNav() {
    const items = [
      (Icons.home_rounded, 'Início'),
      (Icons.explore_rounded, 'Explorar'),
      (Icons.bookmark_rounded, 'Salvos'),
      (Icons.person_rounded, 'Perfil'),
    ];
    return Container(
      decoration: const BoxDecoration(color: Color(0xFF0F0F1A), border: Border(top: BorderSide(color: Color(0xFF2C2C3A)))),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final selected = i == _selectedNav;
              return GestureDetector(
                onTap: () => setState(() => _selectedNav = i),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Icon(items[i].$1, color: selected ? const Color(0xFFE8B84B) : const Color(0xFF4C4C60), size: 26),
                  const SizedBox(height: 3),
                  Text(items[i].$2, style: TextStyle(color: selected ? const Color(0xFFE8B84B) : const Color(0xFF4C4C60), fontSize: 10, fontWeight: selected ? FontWeight.w700 : FontWeight.w400)),
                ]),
              );
            }),
          ),
        ),
      ),
    );
  }
}