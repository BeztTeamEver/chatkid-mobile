import 'package:chatkid_mobile/models/blog_model.dart';
import 'package:chatkid_mobile/models/blog_type_model.dart';
import 'package:chatkid_mobile/pages/explore/blogs/blog_categories_detail_page.dart';
import 'package:chatkid_mobile/pages/explore/blogs/blog_page.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BlogDetailPage extends StatefulWidget {
  final BlogTypeModel? type;
  final BlogModel blog;
  const BlogDetailPage({super.key, this.type, required this.blog});

  @override
  State<BlogDetailPage> createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 25),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: SvgPicture.asset("assets/icons/back.svg"),
                    onPressed: () => {
                      Navigator.push(
                        context,
                        createRoute(
                          () => BlogPage(type: widget.type),
                        ),
                      )
                    },
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.only(right: 13.0),
                      child: Text(
                        widget.blog.title ?? "Tiêu đề",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: SvgPicture.asset("assets/icons/info.svg"),
                    onPressed: () => {
                      Navigator.push(
                        context,
                        createRoute(
                          () => const BlogCategoriesDetailPage(),
                        ),
                      )
                    },
                  ),
                ],
              ),
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular((8.0)))),
                child: widget.blog.imageUrl == null
                    ? Image.asset(
                        'assets/thumbnails/animals.png',
                        width: 360,
                      )
                    : Image.network(
                        widget.blog.imageUrl ?? '',
                        width: 360,
                        fit: BoxFit.cover,
                      ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/bot_head.svg',
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width / 3 * 2 + 65,
                          height: 56,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 155, 6, 1),
                              borderRadius: BorderRadius.circular(18)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/play.svg',
                                width: 15,
                              ),
                              SvgPicture.asset('assets/audio/waveform.svg'),
                              const Text(
                                "14:37",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              )
                            ],
                          )),
                    ]),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(1, 1),
                        )
                      ]),
                  child: SingleChildScrollView(
                    child: Text(
                      widget.blog.content ?? "Mô tả",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
