import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/constants/init_item.dart';
import 'package:chatkid_mobile/models/family_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/main_page.dart';
import 'package:chatkid_mobile/pages/profile/subcription_page.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/avatar_png.dart';
import 'package:chatkid_mobile/widgets/bottom_menu.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:chatkid_mobile/widgets/indicator.dart';
import 'package:logger/logger.dart';

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
      if (_currentBanner < MAX_ITEMS - 1) {
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Ví KidTalkie"),
        titleTextStyle: const TextStyle(
          color: Color(0xFF242837),
          fontSize: 16,
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w600,
          height: 0,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: PageView.builder(
                      onPageChanged: (value) => setState(
                        () {
                          _currentBanner = value;
                        },
                      ),
                      itemCount: MAX_ITEMS,
                      scrollDirection: Axis.horizontal,
                      controller: _pageController,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.7),
                            image: const DecorationImage(
                              image: NetworkImage(
                                  "https://marketplace.canva.com/EAE6uxzge6c/1/0/1600w/canva-yellow-and-white-minimalist-big-sale-banner-BjBIq-T_6j4.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: null,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    child: Container(
                      decoration: const BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 0,
                            blurRadius: 20,
                            offset: Offset(0, 0))
                      ]),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        child: Center(
                          child: Indicator(
                            index: _currentBanner,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                      'Bạn đang có ${widget.currentUser?.diamond ?? 100}',
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
            physics: const NeverScrollableScrollPhysics(),
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
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.green),
                              borderRadius: BorderRadius.circular(50)),
                          child: Container(
                            width: 40,
                            height: 40,
                            child: AvatarPng(
                              imageUrl: user.avatarUrl,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -10,
                          left: 0,
                          right: 0,
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: const Color.fromRGBO(255, 155, 6, 1)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    user.diamond?.toString() ?? '0',
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
                    const SizedBox(height: 10),
                    Text(
                      user.name ?? "Ẩn danh",
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              );
            }),
          ),
        ]),
      ),
      bottomNavigationBar: BottomMenu(
        currentIndex: 3,
        onTap: (index) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MainPage(index: index)));
        },
      ),
    );
  }
}
