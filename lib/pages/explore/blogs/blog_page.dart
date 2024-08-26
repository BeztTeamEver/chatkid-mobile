import 'package:chatkid_mobile/models/blog_model.dart';
import 'package:chatkid_mobile/models/blog_type_model.dart';
import 'package:chatkid_mobile/pages/explore/blogs/blog_detail_page.dart';
import 'package:chatkid_mobile/pages/main_page.dart';
import 'package:chatkid_mobile/services/blog_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/bottom_menu.dart';
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
                  Text(
                    widget.type?.name ?? "Kiến thức",
                    style: const TextStyle(
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
              height: MediaQuery.of(context).size.height - 110,
              child: FutureBuilder(
                future: blogs,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data as List<BlogModel>;
                    return Stack(
                      children: [
                        GridView.builder(
                            padding: const EdgeInsets.only(top: 10),
                            itemCount: data.length,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 2.9,
                              crossAxisCount: 1,
                            ),
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
                                  child: data[index].imageUrl == null
                                      ? Image.asset(
                                          'assets/blog/the_gioi_dong_vat.png',
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
