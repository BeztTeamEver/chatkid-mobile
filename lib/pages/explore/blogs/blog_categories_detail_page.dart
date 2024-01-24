import 'package:chatkid_mobile/models/blog_type_model.dart';
import 'package:chatkid_mobile/pages/explore/blogs/blog_page.dart';
import 'package:chatkid_mobile/pages/explore/blogs/universe_page.dart';
import 'package:chatkid_mobile/pages/main_page.dart';
import 'package:chatkid_mobile/services/blog_service.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Kiến thức"),
        titleTextStyle: const TextStyle(
          color: Color(0xFF242837),
          fontSize: 16,
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w600,
          height: 0,
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: FutureBuilder(
          future: blogTypes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data as List<BlogTypeModel>;
              return Stack(
                children: [
                  GridView.builder(
                      padding: const EdgeInsets.only(top: 10),
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
                            child: (data[index].imageUrl == null || index == 0)
                                ? Image.asset(
                                    'assets/blog/vu_tru.png',
                                    width: MediaQuery.of(context).size.width,
                                  )
                                : Image.network(
                                    data[index].imageUrl ?? '',
                                    width: MediaQuery.of(context).size.width,
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
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      bottomNavigationBar: BottomMenu(
        currentIndex: 0,
        onTap: (index) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MainPage(index: index)));
        },
      ),
    );
  }
}
