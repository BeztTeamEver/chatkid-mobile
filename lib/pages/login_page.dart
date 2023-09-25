import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InputField(label: "Email", type: TextInputType.emailAddress),
                const SizedBox(
                  height: 20,
                ),
                InputField(
                  label: "Password",
                  type: TextInputType.visiblePassword,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
