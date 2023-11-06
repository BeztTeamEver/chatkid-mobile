import 'package:chatkid_mobile/pages/explore/blogs/blog_categories_detail_page.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EducationCategoriesPage extends StatefulWidget {
  const EducationCategoriesPage({super.key});

  @override
  State<EducationCategoriesPage> createState() =>
      _EducationCategoriesPageState();
}

class _EducationCategoriesPageState extends State<EducationCategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 15.0),
        color: const Color.fromRGBO(255, 251, 245, 1),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => {
                Navigator.push(
                  context,
                  createRoute(
                    () => const BlogCategoriesDetailPage(),
                  ),
                )
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 5,
                margin: const EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular((8.0)))),
                          child: Image.asset(
                            'assets/thumbnails/animals.png',
                            width: MediaQuery.of(context).size.width - 40,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text(
                            "Toán học",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => {
                Navigator.push(
                  context,
                  createRoute(
                    () => const BlogCategoriesDetailPage(),
                  ),
                )
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 5,
                margin: const EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular((8.0)))),
                          child: SvgPicture.asset(
                            'assets/thumbnails/education_games.svg',
                            width: MediaQuery.of(context).size.width - 40,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text(
                            "Trò chơi giáo dục",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
