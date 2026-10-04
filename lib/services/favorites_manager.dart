import 'package:flutter/foundation.dart';

import '../models/anime.dart';

class FavoritesManager extends ChangeNotifier {
  FavoritesManager._internal();
  static final FavoritesManager instance = FavoritesManager._internal();

  final List<Anime> _favorites = [];

  List<Anime> get favorites => List.unmodifiable(_favorites);

  bool isFavorite(String id) {
    return _favorites.any((anime) => anime.id == id);
  }

  void toggleFavorite(Anime anime) {
    if (isFavorite(anime.id)) {
      _favorites.removeWhere((a) => a.id == anime.id);
    } else {
      _favorites.add(anime);
    }
    notifyListeners();
  }
}
