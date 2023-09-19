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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Center(
            child: Text(
              "Home page text s",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              "Home page text m",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              "Home page text l",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              "Home page head l".toUpperCase(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              "Home page head m",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              "Home page head s",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              child: const Text("Go to chat route"),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
