import 'dart:async';
import 'package:chatkid_mobile/constants/init_page.dart';
import 'package:chatkid_mobile/constants/routes.dart';
import 'package:chatkid_mobile/widgets/indicator.dart';
import 'package:chatkid_mobile/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  Timer? _timer;
  int _currentPage = 0;

  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < MAX_ITEMS - 1) {
        setState(() {
          _currentPage++;
        });
      } else {
        setState(() {
          _currentPage = 0;
        });
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const LogoWidget(),
              const SizedBox(
                height: 70,
              ),
              SizedBox(
                height: 320,
                child: PageView.builder(
                  onPageChanged: (value) => setState(() {
                    _currentPage = value;
                  }),
                  itemCount: MAX_ITEMS,
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset(
                          'assets/initPage/illusion${index + 1}.svg',
                          height: 300,
                        )
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Indicator(index: _currentPage),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Sử dụng chat AI có thể giúp trẻ em rèn luyện kỹ năng xã hội, bao gồm việc học cách tương tác, đặt câu hỏi, và nắm vững ngôn ngữ.",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  _timer?.cancel();
                  Navigator.pushNamed(
                      context, routesName['${AppRoutes.signUp}']!);
                },
                style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                      minimumSize: MaterialStateProperty.all<Size>(
                        const Size(double.infinity, 48),
                      ),
                    ),
                child: const Text("Tiếp tục"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
