import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/routes.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/app_text_field.dart';

class ChangeUsernameScreen extends StatefulWidget {
  /// Username saat ini. Kirim lewat `context.push(path, extra: username)`.
  final String currentUsername;

  const ChangeUsernameScreen({super.key, this.currentUsername = 'username'});

  @override
  State<ChangeUsernameScreen> createState() => _ChangeUsernameScreenState();
}

class _ChangeUsernameScreenState extends State<ChangeUsernameScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  bool _isLoading = false;

  final _usernameRegex = RegExp(r'^[a-zA-Z0-9_.]+$');

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  String? _validateUsername(String? value) {
    final username = value?.trim() ?? '';
    if (username.isEmpty) {
      return 'Username is required';
    }
    if (username.length < 3) {
      return 'Username must be at least 3 characters';
    }
    if (username.length > 20) {
      return 'Username must be at most 20 characters';
    }
    if (!_usernameRegex.hasMatch(username)) {
      return 'Only letters, numbers, underscores, and dots are allowed';
    }
    if (username == widget.currentUsername) {
      return 'New username must be different from the current one';
    }
    return null;
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // TODO: Implement change username functionality
      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return;
      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Username updated successfully'),
          backgroundColor: Colors.green.shade600,
          behavior: SnackBarBehavior.floating,
        ),
      );
      _goBack();
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update username. Please try again.'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _goBack() {
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
          onPressed: _goBack,
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: screenWidth * 0.055,
          ),
        ),
        title: Text(
          'Change Username',
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
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.02),

                      // Current username card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(screenWidth * 0.04),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(
                            screenWidth * 0.035,
                          ),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.15),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person_outline,
                              color: Colors.blue.shade300,
                              size: screenWidth * 0.07,
                            ),
                            SizedBox(width: screenWidth * 0.03),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Current username',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.032,
                                      color: Colors.white60,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.003),
                                  Text(
                                    widget.currentUsername,
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.042,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.035),

                      AppTextField(
                        controller: _usernameController,
                        label: 'New Username',
                        prefixIcon: Icons.alternate_email,
                        validator: _validateUsername,
                        enabled: !_isLoading,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _handleSave(),
                      ),

                      SizedBox(height: screenHeight * 0.01),

                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.02,
                        ),
                        child: Text(
                          '3-20 characters. Letters, numbers, underscores, and dots only.',
                          style: TextStyle(
                            fontSize: screenWidth * 0.03,
                            color: Colors.white54,
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      // Save button
                      SizedBox(
                        width: double.infinity,
                        height: screenHeight * 0.075,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleSave,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.withValues(alpha: 0.8),
                            disabledBackgroundColor: Colors.blue.withValues(
                              alpha: 0.4,
                            ),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                screenWidth * 0.03,
                              ),
                            ),
                            elevation: 5,
                          ),
                          child: _isLoading
                              ? SizedBox(
                                  height: screenWidth * 0.06,
                                  width: screenWidth * 0.06,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  'Save Changes',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.045,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
