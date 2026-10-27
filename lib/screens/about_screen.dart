import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/routes.dart';
import '../widgets/app_scaffold.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  // TODO: ganti dengan versi dari pubspec.yaml (bisa pakai package_info_plus)
  static const String _appVersion = '1.0.0';

  static const List<_Feature> _features = [
    _Feature(
      icon: Icons.search_rounded,
      title: 'Search Anime',
      description: 'Find your favorite anime by title in seconds.',
    ),
    _Feature(
      icon: Icons.tune_rounded,
      title: 'Filter by Genre',
      description: 'Discover new series across all of your favorite genres.',
    ),
    _Feature(
      icon: Icons.favorite_border_rounded,
      title: 'Favorites',
      description: 'Save the anime you love and come back to them anytime.',
    ),
    _Feature(
      icon: Icons.info_outline_rounded,
      title: 'Anime Details',
      description: 'Check ratings, genres, episodes, and the full synopsis.',
    ),
  ];

  void _goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.profile);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return AppScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => _goBack(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: screenWidth * 0.055,
          ),
        ),
        title: Text(
          'About AnimeVerse',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: screenWidth * 0.05,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isLargeScreen = constraints.maxWidth > 600;
          final maxWidth = isLargeScreen ? 400.0 : constraints.maxWidth;

          return SingleChildScrollView(
            child: Center(
              child: Container(
                width: maxWidth,
                padding: EdgeInsets.all(screenWidth * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.02),

                    // App icon (placeholder, ganti dengan logo kamu)
                    Container(
                      padding: EdgeInsets.all(screenWidth * 0.05),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.blue.shade400,
                            const Color(0xFF0b395e),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: screenWidth * 0.03,
                            offset: Offset(0, screenHeight * 0.008),
                          ),
                        ],
                      ),
                      // TODO: ganti dengan Image.asset('assets/images/logo.png')
                      child: Icon(
                        Icons.play_circle_fill_rounded,
                        color: Colors.white,
                        size: screenWidth * (isLargeScreen ? 0.08 : 0.16),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.025),

                    Text(
                      'AnimeVerse',
                      style: TextStyle(
                        fontSize: screenWidth * (isLargeScreen ? 0.06 : 0.09),
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.005),

                    Text(
                      'Version $_appVersion',
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: Colors.white60,
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.03),

                    // Description
                    _InfoCard(
                      child: Text(
                        'AnimeVerse is your companion for exploring the world of anime. '
                        'Browse popular series, search by title, filter by genre, and '
                        'keep track of the shows you love, all in one place.',
                        style: TextStyle(
                          fontSize: screenWidth * 0.036,
                          height: 1.5,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.03),

                    // Features
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Features',
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.01),

                    ..._features.map(
                      (feature) => Padding(
                        padding: EdgeInsets.only(bottom: screenHeight * 0.01),
                        child: _InfoCard(
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(screenWidth * 0.025),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(
                                    screenWidth * 0.02,
                                  ),
                                ),
                                child: Icon(
                                  feature.icon,
                                  color: Colors.white,
                                  size: screenWidth * 0.05,
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.035),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      feature.title,
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.04,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.003),
                                    Text(
                                      feature.description,
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.032,
                                        color: Colors.white60,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.02),

                    // Licenses button (halaman bawaan Flutter)
                    SizedBox(
                      width: double.infinity,
                      height: screenHeight * 0.065,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          showLicensePage(
                            context: context,
                            applicationName: 'AnimeVerse',
                            applicationVersion: _appVersion,
                          );
                        },
                        icon: Icon(
                          Icons.description_outlined,
                          color: Colors.blue.shade300,
                          size: screenWidth * 0.055,
                        ),
                        label: Text(
                          'Open Source Licenses',
                          style: TextStyle(
                            fontSize: screenWidth * 0.038,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue.shade300,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              screenWidth * 0.03,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.03),

                    Text(
                      'Made with Flutter',
                      style: TextStyle(
                        fontSize: screenWidth * 0.032,
                        color: Colors.white54,
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.005),

                    Text(
                      '© ${DateTime.now().year} AnimeVerse. All rights reserved.',
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: Colors.white38,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: screenHeight * 0.03),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Feature {
  final IconData icon;
  final String title;
  final String description;

  const _Feature({
    required this.icon,
    required this.title,
    required this.description,
  });
}

/// Container dengan gaya yang sama seperti ProfileButton.
class _InfoCard extends StatelessWidget {
  final Widget child;

  const _InfoCard({required this.child});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(screenWidth * 0.035),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: child,
    );
  }
}
