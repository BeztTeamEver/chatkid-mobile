import 'package:chatkid_mobile/models/blog_type_model.dart';
import 'package:chatkid_mobile/pages/explore/blogs/blog_page.dart';
import 'package:chatkid_mobile/pages/explore/blogs/universe_page.dart';
import 'package:chatkid_mobile/pages/main_page.dart';
import 'package:chatkid_mobile/services/blog_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/bottom_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class BlogCategoriesDetailPage extends ConsumerStatefulWidget {
  const BlogCategoriesDetailPage({super.key});

  @override
  ConsumerState<BlogCategoriesDetailPage> createState() =>
      _BlogCategoriesDetailPage();
}

class _BlogCategoriesDetailPage
    extends ConsumerState<BlogCategoriesDetailPage> {
  late final Future<List<BlogTypeModel>> blogTypes;
  @override
  void initState() {
    super.initState();
    blogTypes = BlogService().getBlogTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(primary.shade100),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: primary.shade400,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Text(
                    "Kiến thức",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 120,
              child: FutureBuilder(
                future: blogTypes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data as List<BlogTypeModel>;
                    return Stack(
                      children: [
                        GridView.builder(
                            padding: const EdgeInsets.only(bottom: 10),
                            itemCount: data.length,
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 2.4,
                              crossAxisCount: 1,
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => {
                                  if (index == 0)
                                    Navigator.push(
                                      context,
                                      createRoute(
                                        () => const UniversePage(),
                                      ),
                                    )
                                  else
                                    Navigator.push(
                                      context,
                                      createRoute(
                                        () => BlogPage(type: data[index]),
                                      ),
                                    )
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x144E2813),
                                        blurRadius: 20,
                                        offset: Offset(0, -4),
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: (data[index].imageUrl == null ||
                                          index == 0)
                                      ? Image.asset(
                                          'assets/blog/vu_tru.png',
                                          width:
                                              MediaQuery.of(context).size.width,
                                        )
                                      : Image.network(
                                          data[index].imageUrl ?? '',
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                ),
                              );
                            }),
                      ],
                    );
                  }
                  if (snapshot.hasError) {
                    Logger().e(snapshot.error);
                    return Container();
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
