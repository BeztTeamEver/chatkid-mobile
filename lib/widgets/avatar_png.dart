import 'package:flutter/material.dart';

class AvatarPng extends StatelessWidget {
  final String? imageUrl;
  final double? size;
  final double? borderRadius;


  const AvatarPng({super.key, this.imageUrl, this.borderRadius, this.size});
  

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: Image.network(
        width: size ?? 64,
        imageUrl ??
            "https://static.vecteezy.com/system/resources/previews/026/619/142/non_2x/default-avatar-profile-icon-of-social-media-user-photo-image-vector.jpg",
        fit: BoxFit.fill,
      ),
    );
  }
}
