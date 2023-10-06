import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TitleWithTextField extends StatelessWidget {
  const TitleWithTextField({
    super.key,
    required this.name,
    required this.title,
    this.textInputAction,
    this.obscureText = false,
    this.validator,
    this.suffixIcon,
  });
  final bool obscureText;
  final String name;
  final String title;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: themeData.textTheme.bodyLarge,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: FormBuilderTextField(
            name: name,
            textInputAction: textInputAction,
            obscureText: obscureText,
            validator: validator,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
            ),
          ),
        ),
      ],
    );
  }
}
