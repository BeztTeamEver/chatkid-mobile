import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:avatar_stack/avatar_stack.dart';
import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/enum/bot_type.dart';
import 'package:chatkid_mobile/models/family_model.dart';
import 'package:chatkid_mobile/pages/chats/bot_chat_page.dart';
import 'package:chatkid_mobile/pages/chats/group_chat_page.dart';
import 'package:chatkid_mobile/pages/sign_in/sign_in_page.dart';
import 'package:chatkid_mobile/providers/chat_provider.dart';
import 'package:chatkid_mobile/providers/family_provider.dart';
import 'package:chatkid_mobile/services/chat_service.dart';
import 'package:chatkid_mobile/services/family_service.dart';
import 'package:chatkid_mobile/services/firebase_service.dart';
import 'package:chatkid_mobile/services/login_service.dart';
import 'package:chatkid_mobile/services/socket_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/avatar.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:chatkid_mobile/widgets/indicator.dart';
import 'package:chatkid_mobile/widgets/select_button.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';

const MAX_ITEMS = 3;

class ListGroupChat extends ConsumerStatefulWidget {
  const ListGroupChat({super.key});

  @override
  ConsumerState<ListGroupChat> createState() => _ListGroupChatState();
}

class _ListGroupChatState extends ConsumerState<ListGroupChat> {
  int _currentBanner = 0;
  Timer? _timer;
  final _pageController = PageController(initialPage: 0);

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
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final currentUser = LocalStorage.instance.getUser();
  @override
  Widget build(BuildContext context) {
    // final family = ref
    //     .watch(getFamilyProvider(
    //         FamilyRequestModel(id: '6b02cfc1-0b92-4ec4-97e3-75f57a8c186b')))
    //     .asData
    //     ?.value;
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Ink(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: primary.shade200, width: 2),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x144E2813),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: Color(0x024E2914),
                      blurRadius: 2,
                      offset: Offset(0, -1),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(40),
                  overlayColor: MaterialStateProperty.all(primary.shade100),
                  onTap: () {},
                  child: const Center(
                    child: SvgIcon(
                      icon: "search",
                      size: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Wrap(spacing: 12, children: [
                      Avatar(
                        icon: iconAnimalList[0],
                        size: 48,
                      ),
                      Avatar(
                        icon: iconAnimalList[1],
                        size: 48,
                      ),
                      Avatar(
                        icon: iconAnimalList[2],
                        size: 48,
                      ),
                      Avatar(
                        icon: iconAnimalList[3],
                        size: 48,
                      ),
                      Avatar(
                        icon: iconAnimalList[4],
                        size: 48,
                      ),
                      Avatar(
                        icon: iconAnimalList[2],
                        size: 48,
                      ),
                      Avatar(
                        icon: iconAnimalList[3],
                        size: 48,
                      ),
                      Avatar(
                        icon: iconAnimalList[4],
                        size: 48,
                      ),
                    ])),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          FullWidthButton(
            onPressed: () {},
            child: const Text(
              "Tạo nhóm chat mới",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w800,
                height: 0,
                letterSpacing: 0.72,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              CustomCard(
                onTap: () => {
                  Navigator.push(
                    context,
                    createRoute(
                      () => GroupChatPage(
                        channelId: "6b02cfc1-0b92-4ec4-97e3-75f57a8c186b",
                      ),
                    ),
                  )
                },
                children: [
                  Container(
                    width: double.infinity,
                    child: Center(
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        alignment: WrapAlignment.center,
                        children: [
                          Avatar(
                            icon: iconAnimalList[0],
                            size: 40,
                          ),
                          Avatar(
                            icon: iconAnimalList[1],
                            size: 40,
                          ),
                          Avatar(
                            icon: iconAnimalList[2],
                            size: 40,
                          ),
                          Avatar(
                            icon: iconAnimalList[3],
                            size: 40,
                          ),
                          Avatar(
                            icon: iconAnimalList[4],
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Gia đình",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  )
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              CustomCard(
                onTap: () {
                  Navigator.push(
                    context,
                    createRoute(() => BotChatPage(botType: BotType.PUMKIN)),
                  );
                },
                children: [
                  SvgPicture.asset('assets/robot/pumkin.svg'),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Bí ngô",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Wrap(
            runSpacing: 8,
            children: [
              SelectButton(
                label: "Gia đình",
                icon:
                    "https://theforumcenter.com/wp-content/uploads/2023/02/topic-talk-about-your-family.jpg",
                onPressed: () {
                  ref.watch(receiveMessage);
                  Navigator.push(
                    context,
                    createRoute(
                      () => GroupChatPage(
                        channelId: "6b02cfc1-0b92-4ec4-97e3-75f57a8c186b",
                      ),
                    ),
                  );
                },
              ),
              // SelectButton(
              //   label: "Gia đình",
              //   icon:
              //       "https://theforumcenter.com/wp-content/uploads/2023/02/topic-talk-about-your-family.jpg",
              //   onPressed: () =>
              //       Navigator.push(context, createRoute(() => GroupChatPage())),
              // ),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseService.instance.signOut().then((value) {
                    AuthService.signOut();
                    Navigator.of(context).pushReplacement(
                      createRoute(
                        () => const LoginPage(),
                      ),
                    );
                  });
                },
                child: const Text("Sign out"),
              )
            ],
          )
        ],
      ),
    );
  }
}
