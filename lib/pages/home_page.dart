import 'dart:async';
import 'dart:math';

import 'package:avatar_stack/avatar_stack.dart';
import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/enum/bot_type.dart';
import 'package:chatkid_mobile/pages/chats/bot_chat_page.dart';
import 'package:chatkid_mobile/pages/chats/group_chat_page.dart';
import 'package:chatkid_mobile/providers/family_provider.dart';
import 'package:chatkid_mobile/services/family_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/avatar.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:chatkid_mobile/widgets/indicator.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

const MAX_ITEMS = 3;

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
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
    final family = ref.watch(familyServiceProvider);
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Xin Chào ${currentUser.name ?? ""} ^^",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: primary.shade500,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  child: PageView.builder(
                    onPageChanged: (value) => setState(() {
                      _currentBanner = value;
                    }),
                    itemCount: MAX_ITEMS,
                    scrollDirection: Axis.horizontal,
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      return SvgPicture.asset(
                        'assets/advertise-banner/banner${index + 1}.svg',
                      );
                    },
                  ),
                ),
                Positioned(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    child: Center(
                      child: Indicator(
                        index: _currentBanner,
                        lenght: MAX_ITEMS,
                      ),
                    ),
                  ),
                  bottom: 0,
                )
              ],
            ),
          ),
          Row(
            children: [
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
              const SizedBox(
                width: 10,
              ),
              CustomCard(
                onTap: () {
                  Navigator.push(
                    context,
                    createRoute(
                        () => const BotChatPage(botType: BotType.STRAWBERRY)),
                  );
                },
                onTapColor: secondary.shade100,
                children: [
                  SvgPicture.asset('assets/robot/cherry.svg'),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Dâu tây",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  )
                ],
              )
            ],
          ),
          Row(
            children: [
              CustomCard(
                onTap: () => {
                  Navigator.push(
                    context,
                    createRoute(
                      () => GroupChatPage(),
                    ),
                  )
                },
                children: [
                  Container(
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 40,
                          child: Avatar(
                            icon: iconAnimalList[0],
                          ),
                        ),
                        Positioned(
                          left: 90,
                          child: Avatar(
                            icon: iconAnimalList[1],
                          ),
                        ),
                        Positioned(
                          right: 40,
                          child: Avatar(
                            icon: iconAnimalList[2],
                          ),
                        ),
                        Positioned(
                          right: 90,
                          child: Avatar(
                            icon: iconAnimalList[3],
                          ),
                        ),
                        Positioned(
                          child: Avatar(
                            icon: iconAnimalList[4],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
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
            ],
          )
        ],
      ),
    );
  }
}
