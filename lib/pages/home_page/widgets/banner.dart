import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/widgets/avatar_png.dart';
import 'package:chatkid_mobile/widgets/indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TodoBanner extends StatefulWidget {
  final GlobalKey? bottomSheetKey;
  const TodoBanner({super.key, this.bottomSheetKey});

  @override
  State<TodoBanner> createState() => _TodoBannerState();
}

class _TodoBannerState extends State<TodoBanner> {
  final UserModel user = LocalStorage.instance.getUser();

  double _height = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height -
          2 * MediaQuery.of(context).size.height / 3,
      child: Stack(
        fit: StackFit.expand,
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
                width: 90,
                height: 94,
                top: 90,
                left: 140,
                child: SvgPicture.asset(
                  "assets/todoPage/banner/flower2.svg",
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                width: 90,
                height: 94,
                top: 70,
                right: 50,
                child: SvgPicture.asset(
                  "assets/todoPage/banner/flower3.svg",
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                width: 90,
                height: 94,
                top: 90,
                right: 0,
                child: SvgPicture.asset(
                  "assets/todoPage/banner/flower4.svg",
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Text(
                        user?.name ?? "Người dùng",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    child: SvgPicture.asset(
                      "assets/todoPage/banner/bell.svg",
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: -12,
            top: MediaQuery.of(context).size.height / 12,
            width: MediaQuery.of(context).size.width + 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  child: SvgPicture.asset(
                    "assets/todoPage/banner/chevron-left.svg",
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  width: 64,
                  height: 64,
                  child: SvgPicture.asset(
                    "assets/todoPage/banner/chevron-right.svg",
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height / 10,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: const Indicator(
                index: 0,
                dotSize: 12,
                height: 12,
                selectedColor: Colors.white,
                unselectedColor: Colors.white60,
              ),
            ),
          ),
        ],
      ),
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
      top: 52,
      left: 32,
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
            width: 72,
            height: 72,
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
