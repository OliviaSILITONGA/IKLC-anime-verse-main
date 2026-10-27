import 'package:flutter/material.dart';

import '../widgets/anime_view.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/genre_filter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedGenre = "All";
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return AppScaffold(
      appBar: AppBar(
        title: Text(
          "AnimeVerse",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: screenWidth * 0.075,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Search Bar + Filter Button
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          screenWidth * 0.075,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: screenWidth * 0.02,
                            offset: Offset(0, screenHeight * 0.005),
                          ),
                        ],
                      ),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Anime Title",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: screenWidth * 0.04,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: screenWidth * 0.06,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              screenWidth * 0.075,
                            ),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              screenWidth * 0.075,
                            ),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              screenWidth * 0.075,
                            ),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          filled: true,
                          fillColor: const Color(0xFF0b395e),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                            vertical: screenHeight * 0.015,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: screenWidth * 0.03),

                  GenreFilterButton(
                    selected: _selectedGenre,
                    onGenreSelected: (genre) {
                      setState(() {
                        _selectedGenre = genre;
                      });
                    },
                  ),
                ],
              ),
            ),

            // Chip filter aktif (muncul hanya kalau genre bukan "All")
            if (_selectedGenre != "All")
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.04,
                  right: screenWidth * 0.04,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: InputChip(
                    label: Text(_selectedGenre),
                    labelStyle: TextStyle(
                      fontSize: screenWidth * 0.036,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    backgroundColor: const Color(0xFF2196F3),
                    color: const WidgetStatePropertyAll(Color(0xFF2196F3)),
                    side: BorderSide.none,
                    deleteIconColor: Colors.white,
                    onDeleted: () {
                      setState(() {
                        _selectedGenre = "All";
                      });
                    },
                  ),
                ),
              ),

            SizedBox(height: screenHeight * 0.02),
            AnimeView(selectedGenre: _selectedGenre, searchQuery: _searchQuery),
            SizedBox(height: screenHeight * 0.025),
          ],
        ),
      ),
    );
  }
}
