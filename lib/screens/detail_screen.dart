import 'package:flutter/material.dart';

import '../models/anime.dart';
import '../services/favorites_manager.dart';
import '../widgets/app_scaffold.dart';

class DetailScreen extends StatelessWidget {
  final Anime anime;

  const DetailScreen({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return AppScaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            expandedHeight: screenHeight * 0.3,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Container(
              margin: EdgeInsets.all(screenWidth * 0.02),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(anime.imagePath, fit: BoxFit.cover),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.3),
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.7),
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: screenHeight * 0.02,
                    left: screenWidth * 0.04,
                    right: screenWidth * 0.04,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          anime.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.07,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        Text(
                          anime.genre,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _InfoChip(
                        color: Colors.amber,
                        icon: Icons.star,
                        text: anime.rating,
                      ),
                      SizedBox(width: screenWidth * 0.03),
                      _InfoChip(
                        color: const Color(0xFF0b395e),
                        text: '${anime.totalEpisodes} Episodes',
                      ),
                      SizedBox(width: screenWidth * 0.03),
                      ListenableBuilder(
                        listenable: FavoritesManager.instance,
                        builder: (context, _) {
                          final isFav = FavoritesManager.instance.isFavorite(
                            anime.id,
                          );
                          return GestureDetector(
                            onTap: () =>
                                FavoritesManager.instance.toggleFavorite(anime),
                            child: _InfoChip(
                              color: Colors.redAccent,
                              icon: isFav
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              text: isFav
                                  ? 'Added to Favorites'
                                  : 'Add to Favorites',
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Text(
                    'Synopsis',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  Text(
                    anime.description,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: screenWidth * 0.038,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: screenHeight * 0.03),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final Color color;
  final IconData? icon;
  final String text;

  const _InfoChip({required this.color, required this.text, this.icon});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.01),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(w * 0.02),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: w * 0.02,
            offset: Offset(0, h * 0.005),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.white, size: w * 0.04),
            SizedBox(width: w * 0.01),
          ],
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: w * 0.035,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
