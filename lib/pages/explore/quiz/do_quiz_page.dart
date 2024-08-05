import 'package:chatkid_mobile/models/question_model.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class DoQuizPage extends StatefulWidget {
  final List<QuestionModel> listQuestions;
  final String image;
  final Function() handleReset;
  final int questionTimeLimit;

  const DoQuizPage({
    super.key,
    required this.listQuestions,
    required this.image,
    required this.handleReset,
    required this.questionTimeLimit,
  });

  @override
  State<DoQuizPage> createState() => _DoQuizPageState();
}

class _DoQuizPageState extends State<DoQuizPage> with TickerProviderStateMixin {
  late int index = 1;
  late String selectedAnswer = "#####";
  late List<String> result = [];
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.questionTimeLimit),
      
    )
      ..addStatusListener((AnimationStatus status) {
        setState(() {
          if (status == AnimationStatus.completed) true;
        });
      })
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int numberOfQuestion = widget.listQuestions.length;

    return Scaffold(
      backgroundColor: secondary.shade50,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: FullWidthButton(
          width: MediaQuery.of(context).size.width - 44,
          onPressed: () {
            if (result.length == index) {
              setState(() {
                selectedAnswer = "#####";
                index++;
              });
            } else {
              setState(() {
                result.add(selectedAnswer);
              });
            }
          },
          isDisabled: selectedAnswer == "#####",
          child: Text(
            result.length == index ? "Câu hỏi tiếp theo" : "Xác nhận đáp án",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            LinearProgressIndicator(
              minHeight: 8,
              backgroundColor: neutral.shade300,
              color: primary.shade500,
              value: controller.value,
              semanticsLabel: 'Linear progress indicator',
            ),
            Image.network(
              widget.image,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 12, left: 12, right: 12, bottom: 16),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: neutral.shade300,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    "Câu hỏi $index/${numberOfQuestion}",
                    style: TextStyle(
                      color: neutral.shade900,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    widget.listQuestions[index - 1].text,
                    style: TextStyle(
                      color: secondary.shade900,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 4,
                    ),
                  ),
                ],
              ),
            ),
            Wrap(
              direction: Axis.vertical,
              spacing: 12,
              children: widget.listQuestions[index - 1].answerOptions
                  .map(
                    (answer) => GestureDetector(
                      onTap: () {
                        if (result.length < index) {
                          setState(() {
                            selectedAnswer = answer;
                          });
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 22),
                        width: MediaQuery.of(context).size.width - 46,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        decoration: BoxDecoration(
                          color: selectedAnswer == answer
                              ? result.length == index
                                  ? selectedAnswer ==
                                          widget.listQuestions[index - 1]
                                              .correctAnswer
                                      ? green.shade100
                                      : red.shade100
                                  : secondary.shade100
                              : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            width: 2,
                            color: selectedAnswer == answer
                                ? result.length == index
                                    ? selectedAnswer ==
                                            widget.listQuestions[index - 1]
                                                .correctAnswer
                                        ? green.shade200
                                        : red.shade200
                                    : secondary.shade200
                                : Colors.transparent,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 0.5),
                            ),
                          ],
                        ),
                        child: Text(
                          answer,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
