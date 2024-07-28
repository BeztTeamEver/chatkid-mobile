import 'dart:io';

import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

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
    final isUrl = imageUrl?.contains("http") ?? false;
    final isFile = File(imageUrl!).existsSync();
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
        padding: !isFile ? EdgeInsets.zero : const EdgeInsets.all(2),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: isUrl == true
              ? Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                )
              : isFile
                  ? Image.file(
                      File(imageUrl!),
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      (imageUrl == null || imageUrl == '') ? "assets/profile/default-avatar.png" : imageUrl!,
                      fit: BoxFit.cover,
                    ),
        ),
      ),
    );
  }
}
