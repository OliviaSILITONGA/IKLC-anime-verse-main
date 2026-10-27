import 'package:flutter/material.dart';

const List<String> kGenres = [
  "All",
  "Action",
  "Adventure",
  "Comedy",
  "Drama",
  "Fantasy",
  "Horror",
  "Mystery",
  "Romance",
  "Sci-Fi",
  "Slice of Life",
];

/// Tombol filter kecil (di samping search bar).
/// Kalau ditekan, muncul bottom sheet berisi pilihan genre.
class GenreFilterButton extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onGenreSelected;

  const GenreFilterButton({
    super.key,
    required this.selected,
    required this.onGenreSelected,
  });

  bool get _isFiltered => selected != "All";

  void _showGenreSheet(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0b395e),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(screenWidth * 0.06),
        ),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              screenWidth * 0.05,
              screenHeight * 0.02,
              screenWidth * 0.05,
              screenHeight * 0.03,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Filter Genre",
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    if (_isFiltered)
                      TextButton(
                        onPressed: () {
                          Navigator.pop(sheetContext);
                          onGenreSelected("All");
                        },
                        child: Text(
                          "Reset",
                          style: TextStyle(
                            fontSize: screenWidth * 0.038,
                            color: Colors.blue.shade300,
                          ),
                        ),
                      ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.015),

                // Genre chips
                Wrap(
                  spacing: screenWidth * 0.025,
                  runSpacing: screenHeight * 0.01,
                  children: kGenres.map((genre) {
                    final isActive = genre == selected;
                    return Material(
                      color: isActive
                          ? const Color(0xFF2196F3)
                          : const Color(0xFF1B5E91),
                      borderRadius: BorderRadius.circular(screenWidth * 0.06),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(screenWidth * 0.06),
                        onTap: () {
                          // Langsung tutup & terapkan, jadi tidak perlu tombol "Apply"
                          Navigator.pop(sheetContext);
                          onGenreSelected(genre);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.045,
                            vertical: screenHeight * 0.01,
                          ),
                          child: Text(
                            genre,
                            style: TextStyle(
                              fontSize: screenWidth * 0.038,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final size = screenWidth * 0.14;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: const Color(0xFF0b395e),
            borderRadius: BorderRadius.circular(screenWidth * 0.075),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: screenWidth * 0.02,
                offset: Offset(0, screenHeight * 0.005),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(screenWidth * 0.075),
              onTap: () => _showGenreSheet(context),
              child: Icon(
                Icons.tune_rounded,
                color: _isFiltered ? Colors.blue.shade300 : Colors.white70,
                size: screenWidth * 0.06,
              ),
            ),
          ),
        ),

        // Titik indikator kalau filter sedang aktif
        if (_isFiltered)
          Positioned(
            top: screenWidth * 0.005,
            right: screenWidth * 0.005,
            child: Container(
              width: screenWidth * 0.03,
              height: screenWidth * 0.03,
              decoration: BoxDecoration(
                color: Colors.blue.shade300,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF0b395e), width: 1.5),
              ),
            ),
          ),
      ],
    );
  }
}
