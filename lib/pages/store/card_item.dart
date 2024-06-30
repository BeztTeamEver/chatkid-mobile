import 'package:chatkid_mobile/models/gift_model.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/utils.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardItem extends StatefulWidget {
  final GiftModel gift;
  const CardItem({super.key, required this.gift});

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          child: Image.asset(
            "assets/store/shelf.png",
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 20),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: HexColor('93CCFF'),
                width: 2,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 12,
                direction: Axis.horizontal,
                children: [
                  Image.network(
                    widget.gift.imageUrl ??
                        'https://static.thenounproject.com/png/4974686-200.png',
                    width: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.width / 5,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 5,
                    child: Wrap(
                      direction: Axis.vertical,
                      alignment: WrapAlignment.center,
                      spacing: 8,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75 - 120,
                          child: Text(
                            widget.gift.title ?? "",
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.none),
                          ),
                        ),
                        Wrap(
                          direction: Axis.horizontal,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 4,
                          children: [
                            Image.asset(
                              'assets/store/icon_star.png',
                              width: 25,
                              height: 24,
                            ),
                            Text(
                              (widget.gift.numberOfCoin ?? 100).toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: neutral.shade800,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.none),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 5,
          right: 10,
          child: IconButton(
            iconSize: 24,
            onPressed: showMenu,
            icon: const SvgIcon(icon: 'store/three-dots'),
          ),
        ),
      ],
    );
  }

  showMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: 1,
                        color: neutral.shade200,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          SvgIcon(
                            icon: 'edit',
                            color: primary.shade300,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Chỉnh sửa quà",
                            style: TextStyle(
                              color: neutral.shade800,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: 1,
                        color: neutral.shade200,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          SvgIcon(
                            icon: 'delete',
                            color: primary.shade300,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Xoá quà",
                            style: TextStyle(
                              color: neutral.shade800,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
