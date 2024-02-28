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
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor ?? neutral.shade400,
            width: 2,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Image.network(
            imageUrl ??
                "https://static.vecteezy.com/system/resources/previews/026/619/142/non_2x/default-avatar-profile-icon-of-social-media-user-photo-image-vector.jpg",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
