import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/material.dart';

class AvatarPng extends StatelessWidget {
  final String? imageUrl;
  final Color? borderColor;

  const AvatarPng({
    super.key,
    this.imageUrl,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final isUrl = imageUrl?.contains("http");
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor ?? neutral.shade400,
            width: 2,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: isUrl != null || isUrl == true
                ? Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    imageUrl!,
                    fit: BoxFit.cover,
                  )),
      ),
    );
  }
}
