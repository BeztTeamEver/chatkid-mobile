import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardTitle extends StatefulWidget {
  final String title;
  final Function()? onPressDetail;

  const CardTitle({
    super.key,
    required this.onPressDetail,
    required this.title,
  });

  @override
  State<CardTitle> createState() => _CardTitleState();
}

class _CardTitleState extends State<CardTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: neutral.shade600,
                  fontWeight: FontWeight.bold,
                ),
          ),
          GestureDetector(
            onTap: widget.onPressDetail,
            child: Text(
              'Chi tiết',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: primary.shade600,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
