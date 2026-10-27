import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/routes.dart';
import '../widgets/app_scaffold.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  bool _isLoading = false;
  bool _emailSent = false;

  final _emailRegex = RegExp(r'^[\w.\-]+@([\w\-]+\.)+[\w\-]{2,}$');

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email wajib diisi';
    }
    if (!_emailRegex.hasMatch(value.trim())) {
      return 'Format email tidak valid';
    }
    return null;
  }

  Future<void> _handleSendResetLink() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // TODO: Implement send reset password email
      // contoh (Firebase): await FirebaseAuth.instance
      //     .sendPasswordResetEmail(email: _emailController.text.trim());
      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _emailSent = true;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal mengirim link reset. Coba lagi.'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return AppScaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isLargeScreen = constraints.maxWidth > 600;
          final maxWidth = isLargeScreen ? 400.0 : constraints.maxWidth;

          return SingleChildScrollView(
            child: Center(
              child: Container(
                width: maxWidth,
                padding: EdgeInsets.all(screenWidth * 0.06),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _emailSent
                      ? _buildSuccessView(
                          screenWidth,
                          screenHeight,
                          isLargeScreen,
                        )
                      : _buildFormView(
                          screenWidth,
                          screenHeight,
                          isLargeScreen,
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // FORM VIEW
  // ---------------------------------------------------------------------------
  Widget _buildFormView(
    double screenWidth,
    double screenHeight,
    bool isLargeScreen,
  ) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        key: const ValueKey('form'),
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Back button
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => context.go(AppRoutes.signIn),
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white70,
                size: screenWidth * 0.06,
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.06),

          // Icon
          Container(
            padding: EdgeInsets.all(screenWidth * 0.05),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.lock_reset_rounded,
              color: Colors.blue.shade300,
              size: screenWidth * (isLargeScreen ? 0.06 : 0.14),
            ),
          ),

          SizedBox(height: screenHeight * 0.03),

          // Title
          Text(
            'Forgot Password?',
            style: TextStyle(
              fontSize: screenWidth * (isLargeScreen ? 0.05 : 0.08),
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: screenHeight * 0.01),

          Text(
            'Masukkan email yang terdaftar dan kami akan\nmengirimkan link untuk mereset password kamu',
            style: TextStyle(
              fontSize: screenWidth * 0.035,
              fontWeight: FontWeight.w500,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: screenHeight * 0.05),

          // Email TextField
          TextFormField(
            controller: _emailController,
            validator: _validateEmail,
            enabled: !_isLoading,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _handleSendResetLink(),
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(
                fontSize: screenWidth * 0.04,
                color: Colors.white70,
              ),
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
                borderSide: const BorderSide(color: Colors.redAccent),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                  width: 1.5,
                ),
              ),
              errorStyle: TextStyle(
                color: Colors.redAccent.shade100,
                fontSize: screenWidth * 0.03,
              ),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white70,
                size: screenWidth * 0.06,
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.025,
                horizontal: screenWidth * 0.055,
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.04),

          // Send Reset Link Button
          SizedBox(
            width: double.infinity,
            height: screenHeight * 0.075,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handleSendResetLink,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.withValues(alpha: 0.8),
                disabledBackgroundColor: Colors.blue.withValues(alpha: 0.4),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.03),
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
                      'Send Reset Link',
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),

          SizedBox(height: screenHeight * 0.03),

          // Back to sign in
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Ingat password kamu? ',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.white70,
                ),
              ),
              TextButton(
                onPressed: () => context.go(AppRoutes.signIn),
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade300,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: screenHeight * 0.05),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // SUCCESS VIEW
  // ---------------------------------------------------------------------------
  Widget _buildSuccessView(
    double screenWidth,
    double screenHeight,
    bool isLargeScreen,
  ) {
    return Column(
      key: const ValueKey('success'),
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: screenHeight * 0.14),

        Container(
          padding: EdgeInsets.all(screenWidth * 0.05),
          decoration: BoxDecoration(
            color: Colors.greenAccent.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.mark_email_read_outlined,
            color: Colors.greenAccent.shade200,
            size: screenWidth * (isLargeScreen ? 0.06 : 0.14),
          ),
        ),

        SizedBox(height: screenHeight * 0.03),

        Text(
          'Check Your Email',
          style: TextStyle(
            fontSize: screenWidth * (isLargeScreen ? 0.05 : 0.08),
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: screenHeight * 0.015),

        Text(
          'Kami sudah mengirim link reset password ke',
          style: TextStyle(
            fontSize: screenWidth * 0.035,
            fontWeight: FontWeight.w500,
            color: Colors.white70,
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: screenHeight * 0.005),

        Text(
          _emailController.text.trim(),
          style: TextStyle(
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.w700,
            color: Colors.blue.shade300,
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: screenHeight * 0.05),

        // Back to Sign In
        SizedBox(
          width: double.infinity,
          height: screenHeight * 0.075,
          child: ElevatedButton(
            onPressed: () => context.go(AppRoutes.signIn),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.withValues(alpha: 0.8),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
              ),
              elevation: 5,
            ),
            child: Text(
              'Back to Sign In',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        SizedBox(height: screenHeight * 0.02),

        // Resend / use another email
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tidak menerima email? ',
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                color: Colors.white70,
              ),
            ),
            TextButton(
              onPressed: () => setState(() => _emailSent = false),
              child: Text(
                'Kirim ulang',
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade300,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: screenHeight * 0.05),
      ],
    );
  }
}
