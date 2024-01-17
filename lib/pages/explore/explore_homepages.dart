import 'package:chatkid_mobile/constants/init_item.dart';
import 'package:chatkid_mobile/pages/explore/button/button.dart';
import 'package:chatkid_mobile/pages/explore/explore_pages.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:chatkid_mobile/widgets/indicator.dart';

class ExploreHomepage extends StatefulWidget {
  const ExploreHomepage({super.key});

  @override
  State<ExploreHomepage> createState() => _ExploreHomepageState();
}

class _ExploreHomepageState extends State<ExploreHomepage> {
  int _currentBanner = 0;

  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: PageView.builder(
                    onPageChanged: (value) => setState(() {
                      _currentBanner = value;
                    }),
                    itemCount: MAX_ITEMS,
                    scrollDirection: Axis.horizontal,
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://bizweb.dktcdn.net/100/396/591/files/kv-web-banner-dl-25-10.jpg?v=1666775796140"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: null,
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 8,
                  child: Container(
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 0,
                          blurRadius: 20,
                          offset: Offset(0, 0))
                    ]),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Indicator(
                          index: _currentBanner,
                          lenght: MAX_ITEMS,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0F4E2813),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Color(0x0A4E2914),
                  blurRadius: 2,
                  offset: Offset(0, -1),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Color(0x0F742B00),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 16,
              children: [
                ButtonBlogAnimated(
                  text: 'Kiến thức',
                  icon: "bottomMenu/reward",
                  onPressed: () {
                    Future.delayed(const Duration(milliseconds: 100), () {
                      Navigator.push(
                          context, createRoute(() => const ExplorePage()));
                    });
                  },
                ),
                ButtonBlogAnimated(
                  text: 'Trò chơi',
                  icon: "logo",
                  onPressed: () {
                    Future.delayed(const Duration(milliseconds: 100), () {
                      Navigator.push(
                          context, createRoute(() => const ExplorePage()));
                    });
                  },
                  primaryColor: const Color(0xFF32FF2D),
                  secondaryColor: const Color(0xFF00E24C),
                ),
                ButtonBlogAnimated(
                  text: 'Năng lượng',
                  icon: "sparkle",
                  onPressed: () {
                    Future.delayed(const Duration(milliseconds: 100), () {
                      Navigator.push(
                          context, createRoute(() => const ExplorePage()));
                    });
                  },
                  primaryColor: primary.shade500,
                  secondaryColor: primary.shade700,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
