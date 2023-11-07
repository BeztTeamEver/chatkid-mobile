import 'package:chatkid_mobile/pages/sign_in/sign_in_page.dart';
import 'package:chatkid_mobile/services/firebase_service.dart';
import 'package:chatkid_mobile/services/login_service.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        const Text("User Profile"),
        ElevatedButton(
          onPressed: () async {
            await FirebaseService.instance.signOut().then((value) {
              AuthService.signOut();
              Navigator.of(context).pushReplacement(
                createRoute(
                  () => const LoginPage(),
                ),
              );
            });
          },
          child: const Text("Sign out"),
        )
      ]),
    );
  }
}
