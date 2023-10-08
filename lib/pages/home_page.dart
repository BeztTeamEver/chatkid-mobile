import 'package:chatkid_mobile/pages/chat_page.dart';
import 'package:chatkid_mobile/pages/sign_in/sign_in_page.dart';
import 'package:chatkid_mobile/services/firebase_service.dart';
import 'package:chatkid_mobile/services/login_service.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Home page text s",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(),
          ),
          const SizedBox(height: 10),
          Text(
            "Home page text m",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
          ),
          const SizedBox(height: 10),
          Text(
            "Home page text l",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              "Home page head l".toUpperCase(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Home page head m",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(),
          ),
          const SizedBox(height: 10),
          Text(
            "Home page head s",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            child: const Text("Go to chat route"),
            onPressed: () {
              Navigator.of(context).push(
                createRoute(
                  () => const ChatPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
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
              child: const Text("Sign out"))
        ],
      ),
    );
  }
}
