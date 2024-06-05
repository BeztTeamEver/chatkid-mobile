import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/widgets/avatar_png.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TodoBanner extends StatefulWidget {
  const TodoBanner({super.key});

  @override
  State<TodoBanner> createState() => _TodoBannerState();
}

class _TodoBannerState extends State<TodoBanner> {
  final UserModel user = LocalStorage.instance.getUser();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue.shade400,
          ),
        ),
        Stack(
          children: [
            Positioned(
              top: 62,
              child: SvgPicture.asset(
                "assets/todoPage/banner/cloud2.svg",
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              top: 76,
              right: 10,
              child: SvgPicture.asset(
                "assets/todoPage/banner/cloud1.svg",
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
        Positioned(
          top: 108,
          height: MediaQuery.of(context).size.height - 100,
          width: MediaQuery.of(context).size.width + 100,
          child: SvgPicture.asset(
            "assets/todoPage/banner/ground.svg",
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height - 100,
            width: MediaQuery.of(context).size.width + 100,
          ),
        ),
        Stack(
          fit: StackFit.expand,
          children: [
            BannerAvatar(user: user),
            Positioned(
              top: 30,
              right: 10,
              child: SvgIcon(icon: "assets/todoPage/banner/flower2.svg"),
            ),
          ],
        )
      ],
    );
  }
}

class BannerAvatar extends StatelessWidget {
  const BannerAvatar({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 32,
      left: 40,
      width: 138,
      height: 142,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 5,
            width: 138,
            height: 142,
            child: SvgPicture.asset(
              "assets/todoPage/banner/flower1.svg",
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            width: 68,
            height: 68,
            child: Container(
              width: 20,
              height: 20,
              child: AvatarPng(
                borderColor: Colors.transparent,
                imageUrl: user.avatarUrl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
