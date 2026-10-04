import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import 'anime_card.dart';

class AnimeView extends StatelessWidget {
  final String selectedGenre;
  final String searchQuery;

  const AnimeView({
    super.key,
    this.selectedGenre = "All",
    this.searchQuery = "",
  });

  @override
  Widget build(BuildContext context) {
    final filteredList = DummyData.animeList.where((anime) {
      final matchesGenre =
          selectedGenre == "All" ||
          anime.genre.toLowerCase().contains(selectedGenre.toLowerCase());
      final matchesSearch =
          searchQuery.isEmpty ||
          anime.title.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesGenre && matchesSearch;
    }).toList();

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount;
          double childAspectRatio;

          if (constraints.maxWidth < 600) {
            crossAxisCount = 3;
            childAspectRatio = 0.55;
          } else if (constraints.maxWidth < 900) {
            crossAxisCount = 5;
            childAspectRatio = 0.6;
          } else {
            crossAxisCount = (constraints.maxWidth / 200).floor().clamp(4, 6);
            childAspectRatio = 0.8;
          }

          if (filteredList.isEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.05,
              ),
              child: Center(
                child: Text(
                  'Anime tidak ditemukan',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: constraints.maxWidth * 0.04,
                  ),
                ),
              ),
            );
          }

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: constraints.maxWidth * 0.03,
              crossAxisSpacing: constraints.maxWidth * 0.05,
              childAspectRatio: childAspectRatio,
            ),
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              final anime = filteredList[index];
              return AnimeCard(
                id: anime.id,
                title: anime.title,
                imagePath: anime.imagePath,
              );
            },
          );
        },
      ),
    );
  }
}
