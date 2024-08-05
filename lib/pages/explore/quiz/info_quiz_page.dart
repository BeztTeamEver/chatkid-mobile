import 'dart:ui';

import 'package:chatkid_mobile/models/quiz_model.dart';
import 'package:chatkid_mobile/pages/explore/blogs/blog_detail_page.dart';
import 'package:chatkid_mobile/pages/explore/component/tag_question.dart';
import 'package:chatkid_mobile/pages/explore/quiz/do_quiz_page.dart';
import 'package:chatkid_mobile/services/quiz_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/utils/utils.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';

class InfoQuizPage extends StatefulWidget {
  final QuizModel quizInfo;
  final Function() handleReset;

  const InfoQuizPage(
      {super.key, required this.quizInfo, required this.handleReset});

  @override
  State<InfoQuizPage> createState() => _InfoQuizPageState();
}

class _InfoQuizPageState extends State<InfoQuizPage> {
  late Future<QuizModel> listQuiz;

  @override
  void initState() {
    super.initState();

    listQuiz = QuizService().getQuizById(widget.quizInfo.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#4870FF'),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 10,
              ),
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
                    "Chi tiết bộ câu hỏi",
                    style: TextStyle(
                      color: Colors.white,
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
            SizedBox(
              height: MediaQuery.of(context).size.height - 100,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Image.network(
                        widget.quizInfo.illustratedImageUrl,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 24,
                      ),
                      child: TagQuestion(
                        title: widget.quizInfo.title,
                        rate: widget.quizInfo.rate,
                        isDone: widget.quizInfo.rate > 0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 24,
                        horizontal: 17,
                      ),
                      child: FutureBuilder(
                        future: listQuiz,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final data = snapshot.data as QuizModel;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(25.0),
                                      child: Image.asset(
                                          "assets/blog/read-blog.jpg"),
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      left:
                                          MediaQuery.of(context).size.width / 8,
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            createRoute(
                                              () => BlogDetailPage(
                                                blog: data.blog,
                                              ),
                                            ),
                                          );
                                        },
                                        icon: Container(
                                          width: 128,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 4,
                                            horizontal: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: secondary.shade500,
                                            borderRadius:
                                                BorderRadius.circular(46.0),
                                          ),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Đọc ngay",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              SizedBox(width: 4),
                                              Icon(
                                                Icons.arrow_right_alt_rounded,
                                                size: 24,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: secondary.shade100,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: Center(
                                          child: SvgPicture.asset(
                                            "assets/icons/question-mark.svg",
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${data.questions.length} câu",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: neutral.shade900,
                                            ),
                                          ),
                                          Text(
                                            "Trắc nghiệm nhiều lựa chọn",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: neutral.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: secondary.shade100,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: Center(
                                          child: SvgPicture.asset(
                                            "assets/icons/alarm.svg",
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${widget.quizInfo.questionTimeLimit} câu",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: neutral.shade900,
                                            ),
                                          ),
                                          Text(
                                            "Để trả lời cho 1 câu hỏi",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: neutral.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: secondary.shade100,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: Center(
                                          child: SvgPicture.asset(
                                            "assets/icons/trophy.svg",
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${widget.quizInfo.percent}%",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: neutral.shade900,
                                            ),
                                          ),
                                          Text(
                                            "Câu trả lời đúng để hoàn thành",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: neutral.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 24),
                                FullWidthButton(
                                  width: MediaQuery.of(context).size.width - 45,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      createRoute(
                                        () => DoQuizPage(
                                          listQuestions: data.questions,
                                          image: data.illustratedImageUrl,
                                          handleReset: widget.handleReset,
                                          questionTimeLimit: widget.quizInfo.questionTimeLimit,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Giải câu đố",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            Logger().d(snapshot.error);
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
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
