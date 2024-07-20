import 'package:chatkid_mobile/pages/home_page/target_detail/widgets/edit_modal.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/button_icon.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:chatkid_mobile/widgets/progress_bar.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeadCard extends StatefulWidget {
  const HeadCard({super.key});

  @override
  State<HeadCard> createState() => _HeadCardState();
}

class _HeadCardState extends State<HeadCard> {
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      children: [
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      "Hoàn thành tốt việc học",
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontSize: 18,
                              ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "01/05 - 31/05",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 14,
                          ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: ProgressBar(
                              value: 0.5,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          SvgIcon(
                            icon: 'coin',
                            size: 42,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 4,
                top: 4,
                child: ButtonIcon(
                  icon: 'chevron-left',
                  color: primary.shade500,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  iconSize: 26,
                  padding: 4,
                  backgroundColor: primary.shade100,
                ),
              ),
              Positioned(
                top: 1,
                right: 4,
                child: ButtonIcon(
                  onPressed: () {
                    showModalBottomSheet(
                      showDragHandle: true,
                      context: context,
                      builder: (context) {
                        return EditModal();
                      },
                    );
                  },
                  icon: "dots",
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
