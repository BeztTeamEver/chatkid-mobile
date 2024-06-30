import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EmptyAssetData extends StatelessWidget {
  const EmptyAssetData({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 14),
      child: Column(
        children: [
          Image.asset(
            "assets/bots/bot_face.png",
            width: 130,
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Cửa hàng đã hết trang bị",
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 8,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              "KidTalkie sẽ cập nhật thêm trang bị trong thời gian sắp tới",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
