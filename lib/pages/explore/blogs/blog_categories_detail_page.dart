import 'package:chatkid_mobile/models/blog_type_model.dart';
import 'package:chatkid_mobile/pages/explore/blogs/blog_page.dart';
import 'package:chatkid_mobile/services/blog_service.dart';
import 'package:chatkid_mobile/utils/route.dart';
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
      body: Center(
          child: FutureBuilder(
              future: blogTypes,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data as List<BlogTypeModel>;
                  return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 30),
                      child: Stack(
                        children: [
                          const Text(
                            "1000 CÂU HỎI VÌ SAO",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 50),
                          GridView.builder(
                              itemCount: data.length,
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 1.2,
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () => {
                                    Navigator.push(
                                      context,
                                      createRoute(
                                        () => BlogPage(type: data[index]),
                                      ),
                                    )
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    elevation: 5,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 10,
                                              left: 10,
                                              right: 10,
                                              bottom: 2),
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular((8.0)))),
                                          child: data[index].imageUrl == null
                                              ? Image.asset(
                                                  'assets/thumbnails/animals.png',
                                                  width: 156,
                                                  height: 100,
                                                )
                                              : Image.network(
                                                  data[index].imageUrl ?? '',
                                                  width: 156,
                                                  height: 100,
                                                ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            data[index].name ?? "",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0.01,
                                                fontSize: 14,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ));
                }
                if (snapshot.hasError) {
                  Logger().e(snapshot.error);
                  return Container();
                } else {
                  return const CircularProgressIndicator();
                }
              })),
    );
  }
}
