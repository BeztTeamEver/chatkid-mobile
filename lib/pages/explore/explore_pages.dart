import 'package:chatkid_mobile/models/topic_model.dart';
import 'package:chatkid_mobile/pages/explore/blogs/select_topic_page.dart';
import 'package:chatkid_mobile/services/quiz_service.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class ExplorePage extends ConsumerStatefulWidget {
  const ExplorePage({super.key});

  @override
  ConsumerState<ExplorePage> createState() => _ExplorePage();
}

class _ExplorePage extends ConsumerState<ExplorePage> {
  late final Future<List<TopicModel>> listTopic;
  @override
  void initState() {
    super.initState();
    listTopic = QuizService().getTopics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          height: MediaQuery.of(context).size.height - 100,
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: listTopic,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data as List<TopicModel>;
                  return Wrap(
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: [
                      const Text(
                        'Blog',
                        style: TextStyle(
                          fontSize: 4,
                          color: Colors.transparent,
                        ),
                      ),
                      ...data.map(
                        (item) => GestureDetector(
                          onTap: () => {
                            Navigator.push(
                              context,
                              createRoute(
                                () => SelectTopicPage(topicId: item.id, name: item.name),
                              ),
                            ),
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
                            child: Image.network(
                              item.imageUrl,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                        ),
                      ),
                      const Text('Blog',
                          style: TextStyle(
                            fontSize: 4,
                            color: Colors.transparent,
                          )),
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
        ),
      ),
    );
  }
}
