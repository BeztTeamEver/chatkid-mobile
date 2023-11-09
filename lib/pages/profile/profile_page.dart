import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/pages/profile/wallet_page.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
          child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListView(children: [
          SizedBox(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgIcon(
                  icon: iconAnimalList[0],
                  size: 75,
                ),
                const Text(
                  "Trần Đức Minh",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tài khoản cá nhân',
                style: TextStyle(
                    color: Color.fromRGBO(165, 168, 187, 1),
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    createRoute(
                      () => const WalletPage(),
                    ),
                  )
                },
                child: const Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color.fromRGBO(255, 155, 6, 1),
                      child: Icon(
                        Icons.wallet_outlined,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ví KidTalkie',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              letterSpacing: 0.5),
                        ),
                        Text(
                          '100 năng lượng',
                          style: TextStyle(
                              color: Color.fromRGBO(165, 168, 187, 1),
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color.fromRGBO(255, 155, 6, 1),
                    child: Icon(
                      Icons.account_circle_outlined,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Thông tin tài khoản',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        letterSpacing: 0.5),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color.fromRGBO(255, 155, 6, 1),
                    child: Icon(
                      Icons.brush,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Thay đổi theme',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        letterSpacing: 0.5),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tài khoản bé',
                style: TextStyle(
                    color: Color.fromRGBO(165, 168, 187, 1),
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  SvgIcon(
                    icon: iconAnimalList[1],
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    'Bé Huy',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        letterSpacing: 0.5),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SvgIcon(
                    icon: iconAnimalList[3],
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    'Bé Huy',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        letterSpacing: 0.5),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Khác',
                style: TextStyle(
                    color: Color.fromRGBO(165, 168, 187, 1),
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color.fromRGBO(255, 155, 6, 1),
                    child: Icon(
                      Icons.sync_alt_outlined,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Chuyển đổi tài khoản',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        letterSpacing: 0.5),
                  ),
                ],
              )
            ],
          )
        ]),
      )),
    );
  }
}
