import 'dart:async';
import 'dart:convert';

import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/constants/init_item.dart';
import 'package:chatkid_mobile/models/family_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/profile/subcription_page.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WalletPage extends StatefulWidget {
  final FamilyModel family;
  final UserModel? currentUser;
  WalletPage({super.key, required this.family, this.currentUser});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  late UserModel currentUser;
  Timer? _timer;
  int _currentBanner = 0;

  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentBanner < BANNER_MAX_ITEMS - 1) {
        setState(() {
          _currentBanner++;
        });
      } else {
        setState(() {
          _currentBanner = 0;
        });
      }
      _pageController.animateToPage(
        _currentBanner,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void setState(VoidCallback fn) {
    currentUser = UserModel.fromJson(
        jsonDecode(LocalStorage.instance.preferences.getString('user') ?? ""));
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    if (mounted) {
      _timer!.cancel();
      _pageController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(children: [
          SizedBox(
            height: 200,
            child: PageView.builder(
              onPageChanged: (value) => setState(() {
                _currentBanner = value;
              }),
              itemCount: MAX_ITEMS,
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(0),
                    child: SvgPicture.asset(
                      'assets/advertise-banner/banner${index + 1}.svg',
                    ));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
                onPressed: () => {
                      Navigator.push(
                        context,
                        createRoute(
                          () => const SubcriptionPage(),
                        ),
                      )
                    },
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Color.fromRGBO(255, 155, 6, 1)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgIcon(
                      icon: 'sparkle',
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Mua năng lượng',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SvgIcon(
                      icon: 'sparkle',
                      color: Colors.white,
                    ),
                  ],
                )),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromRGBO(78, 41, 20, 0.03),
                      spreadRadius: 0,
                      blurRadius: 6,
                      offset: Offset(0, 3))
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'THÔNG TIN NĂNG LƯỢNG',
                  style: TextStyle(
                      color: Color.fromRGBO(197, 92, 2, 1),
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Bạn đang có ${widget.currentUser!.wallets!.first.totalEnergy ?? 0}',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const Icon(
                      Icons.bolt_outlined,
                      color: Color.fromRGBO(255, 155, 6, 1),
                    )
                  ],
                )
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.family.members.length - 1,
            itemBuilder: ((context, index) {
              final filterUsers = widget.family.members
                  .where((e) => e.id != widget.currentUser?.id)
                  .toList();
              final user = filterUsers[index];
              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromRGBO(78, 41, 20, 0.03),
                          spreadRadius: 0,
                          blurRadius: 6,
                          offset: Offset(0, 3))
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.green),
                              borderRadius: BorderRadius.circular(50)),
                          child: SvgIcon(icon: iconAnimalList[3]),
                        ),
                        Positioned(
                          bottom: -5,
                          right: -10,
                          child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: const Color.fromRGBO(255, 155, 6, 1)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    user.wallets!.isNotEmpty
                                        ? user.wallets!.first.totalEnergy
                                            .toString()
                                        : '0',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.bolt_outlined,
                                    size: 14,
                                    color: Colors.white,
                                  )
                                ],
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      user.name ?? "Ẩn danh",
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              );
            }),
          )
        ]),
      ),
    );
  }
}
