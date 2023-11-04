import 'package:chatkid_mobile/models/blog_model.dart';
import 'package:chatkid_mobile/models/blog_type_model.dart';
import 'package:chatkid_mobile/pages/explore/blogs/blog_detail_page.dart';
import 'package:chatkid_mobile/services/blog_service.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class BlogPage extends ConsumerStatefulWidget {
  final BlogTypeModel? type;

  const BlogPage({super.key, this.type});

  @override
  ConsumerState<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends ConsumerState<BlogPage> {
  late final Future<List<BlogModel>> blogs;

  @override
  void initState() {
    super.initState();
    blogs = BlogService().getBlogsByTypeId(widget.type!.id ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder(
              future: blogs,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data as List<BlogModel>;
                  return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 30),
                      child: Stack(
                        children: [
                          Text(
                            'Chủ đề ${widget.type!.name ?? ''}',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 50),
                          GridView.builder(
                              itemCount: data.length,
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 5,
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () => {
                                    Navigator.push(
                                      context,
                                      createRoute(
                                        () => BlogDetailPage(
                                          type: widget.type,
                                          blog: data[index],
                                        ),
                                      ),
                                    )
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    elevation: 5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Container(
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular((8.0)))),
                                          child: data[index].imageUrl == null
                                              ? Image.asset(
                                                  'assets/thumbnails/people.png',
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            data[index].title ?? "",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0.01,
                                                fontSize: 14,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            textAlign: TextAlign.center,
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
