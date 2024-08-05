import 'package:chatkid_mobile/models/topic_model.dart';
import 'package:chatkid_mobile/pages/explore/component/tag_question.dart';
import 'package:chatkid_mobile/pages/explore/quiz/info_quiz_page.dart';
import 'package:chatkid_mobile/services/quiz_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class SelectTopicPage extends ConsumerStatefulWidget {
  final String topicId;
  final String name;
  const SelectTopicPage({super.key, required this.topicId, required this.name});

  @override
  ConsumerState<SelectTopicPage> createState() => _BlogPageState();
}

class _BlogPageState extends ConsumerState<SelectTopicPage> {
  late final Future<TopicDetailModel> topicDetail;

  @override
  void initState() {
    super.initState();
    topicDetail = QuizService().getTopicById(widget.topicId);
  }

  void resetListQuiz() {
    setState(() {
      topicDetail = QuizService().getTopicById(widget.topicId);
    });
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
                    widget.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 110,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: FutureBuilder(
                  future: topicDetail,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data as TopicDetailModel;
                      return Wrap(
                        runSpacing: 8,
                        children: data.quizzes
                            .map(
                              (item) => GestureDetector(
                                onTap: () => {
                                  Navigator.push(
                                    context,
                                    createRoute(
                                      () => InfoQuizPage(
                                        quizInfo: item,
                                        handleReset: resetListQuiz,
                                      ),
                                    ),
                                  )
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 6,
                                        offset: const Offset(0, 1),
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(6.0),
                                        child: Image.network(
                                          item.illustratedImageUrl,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      TagQuestion(title: item.topic, rate: item.rate, isDone: item.rate > 0),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
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
          ],
        ),
      ),
    );
  }
}
