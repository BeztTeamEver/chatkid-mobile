import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TagQuestion extends StatelessWidget {
  final String title;
  final int rate;
  final bool isDone;

  const TagQuestion({
    super.key,
    required this.title,
    required this.rate,
    required this.isDone,
  });

  @override
  Widget build(BuildContext context) {
    final array5 = [1, 2, 3, 4, 5];

    return Row(children: [
      Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: primary.shade50,
        ),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: isDone ? primary.shade500 : primary.shade200,
          ),
          child: Icon(
            isDone ? Icons.check_rounded : Icons.lock_outline_rounded,
            size: 28,
            color: Colors.white,
          ),
        ),
      ),
      const SizedBox(width: 6),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 120,
            child: Text(
              " $title",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                color: neutral.shade900,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Row(
            children: [
              ...array5.map(
                (e) => (e <= rate && isDone)
                    ? Icon(
                        key: key,
                        Icons.star_rounded,
                        color: HexColor("#FFC148"),
                      )
                    : Icon(
                        key: key,
                        Icons.star_rounded,
                        color: neutral.shade300,
                      ),
              ),
            ],
          ),
        ],
      )
    ]);
  }
}
