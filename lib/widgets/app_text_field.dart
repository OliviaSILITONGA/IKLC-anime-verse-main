import 'package:flutter/material.dart';

/// Text field dengan gaya yang sama seperti di SignInScreen.
/// Kalau [isPassword] = true, otomatis ada tombol show/hide password.
class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final IconData prefixIcon;
  final String? Function(String?)? validator;
  final bool isPassword;
  final bool enabled;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.prefixIcon,
    this.validator,
    this.isPassword = false,
    this.enabled = true,
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscure = widget.isPassword;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    OutlineInputBorder border({Color? color, double width = 1}) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
        borderSide: color == null
            ? BorderSide.none
            : BorderSide(color: color, width: width),
      );
    }

    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      enabled: widget.enabled,
      obscureText: _obscure,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          fontSize: screenWidth * 0.04,
          color: Colors.white70,
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.1),
        border: border(),
        enabledBorder: border(),
        focusedBorder: border(color: Colors.blue.shade300, width: 1.5),
        errorBorder: border(color: Colors.redAccent),
        focusedErrorBorder: border(color: Colors.redAccent, width: 1.5),
        errorStyle: TextStyle(
          color: Colors.redAccent.shade100,
          fontSize: screenWidth * 0.03,
        ),
        prefixIcon: Icon(
          widget.prefixIcon,
          color: Colors.white70,
          size: screenWidth * 0.06,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.white70,
                  size: screenWidth * 0.06,
                ),
                onPressed: () => setState(() => _obscure = !_obscure),
              )
            : null,
        contentPadding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.025,
          horizontal: screenWidth * 0.055,
        ),
      ),
    );
  }
}
