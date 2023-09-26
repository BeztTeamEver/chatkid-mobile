import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final String? Function(String?)? validator;
  final String hint;
  final TextInputType type;

  const InputField({
    super.key,
    this.label = "",
    this.type = TextInputType.text,
    this.hint = "",
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          obscureText: type == TextInputType.visiblePassword,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
