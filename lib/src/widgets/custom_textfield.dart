import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.icon,
    required this.labelText,
    this.isPassword = false,
  });

  final Icon icon;
  final String labelText;
  final bool isPassword;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  // Initially password is obscure
  bool _obscureText = true;
  Icon _peek = const Icon(CupertinoIcons.eye);

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
      _peek = _obscureText
          ? const Icon(CupertinoIcons.eye)
          : const Icon(CupertinoIcons.eye_fill);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.isPassword
        ? Material(
            elevation: 2,
            borderOnForeground: false,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: widget.icon,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                labelText: widget.labelText,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                suffixIcon: IconButton(
                  icon: _peek,
                  onPressed: _toggle,
                ),
              ),
              obscureText: _obscureText,
              enableSuggestions: false,
              autocorrect: false,
            ),
          )
        : Material(
            elevation: 2,
            borderOnForeground: false,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: widget.icon,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                labelText: widget.labelText,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                // fillColor: Colors.transparent,
                // filled: true,
              ),
            ),
          );
  }
}
