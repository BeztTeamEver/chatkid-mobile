import 'package:chatkid_mobile/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const LogoWidget(),
              const SizedBox(height: 100),
              SvgPicture.asset(
                'assets/initPage/illusion1.svg',
                width: 300,
                height: 300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
