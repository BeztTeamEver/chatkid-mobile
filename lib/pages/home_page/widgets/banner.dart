import 'dart:convert';

import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/constants/local_storage.dart';
import 'package:chatkid_mobile/models/family_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/chats/group_chat_page.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/todo_home_store.dart';
import 'package:chatkid_mobile/pages/store/store_page.dart';
import 'package:chatkid_mobile/providers/family_provider.dart';
import 'package:chatkid_mobile/services/family_service.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/avatar_png.dart';
import 'package:chatkid_mobile/widgets/button_icon.dart';
import 'package:chatkid_mobile/widgets/custom_progress_indicator.dart';
import 'package:chatkid_mobile/widgets/indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class TodoBanner extends ConsumerStatefulWidget {
  final GlobalKey? bottomSheetKey;
  const TodoBanner({super.key, this.bottomSheetKey});

  @override
  ConsumerState<TodoBanner> createState() => _TodoBannerState();
}

class _TodoBannerState extends ConsumerState<TodoBanner> {
  final UserModel user = LocalStorage.instance.getUser();

  TodoHomeStore todoStore = Get.find<TodoHomeStore>();

  @override
  Widget build(BuildContext context) {
    final familyChannel = ref.watch(getFamilyChannel);

    final familiesAccounts = ref.watch(getFamilyProvider.future).then((value) {
      Logger().i("Families: ${jsonEncode(value.members)}");
      final children =
          value.members.fold(<UserModel>[], (previousValue, element) {
        if (element.role == RoleConstant.Child) {
          previousValue.add(element);
        }
        return previousValue;
      });
      todoStore.setMembers(children);
      todoStore.fetchData();
      return children;
    });

    return Container(
      height: MediaQuery.of(context).size.height -
          2 * MediaQuery.of(context).size.height / 3 -
          22,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
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
              FutureBuilder(
                initialData: <UserModel>[
                  UserModel(
                    id: "1",
                    name: "Người dùng",
                    avatarUrl: "https://i.pravatar.cc/150?img=1",
                  ),
                ],
                future: familiesAccounts,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    Logger().i("Error: ${snapshot.error}");
                    return Container();
                    // return Text("Error: ${snapshot.error}");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return BannerAvatar(isLoading: true);
                  }
                  if (snapshot.hasData) {
                    return BannerAvatar();
                  }
                  return Positioned(
                    width: 48,
                    height: 48,
                    child: Container(
                      width: 48,
                      height: 48,
                      child: const CustomCircleProgressIndicator(),
                    ),
                  );
                },
              ),
              Positioned(
                width: 50,
                height: 54,
                top: 120,
                left: 140,
                child: SvgPicture.asset(
                  "assets/todoPage/banner/flower2.svg",
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                width: 140,
                top: 30,
                right: 65,
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(
                      context,
                      createRoute(() => const StorePage()),
                    )
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(40),
                            right: Radius.circular(40),
                          ),
                        ),
                        child: const Text(
                          "Cửa hàng phần thưởng",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      SvgPicture.asset(
                        "assets/todoPage/banner/store.svg",
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                width: 80,
                height: 84,
                top: 90,
                right: 0,
                child: SvgPicture.asset(
                  "assets/todoPage/banner/flower4.svg",
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          FutureBuilder(
            initialData: [
              UserModel(
                id: "1",
                name: "Người dùng",
                avatarUrl: "https://i.pravatar.cc/150?img=1",
              ),
            ],
            future: familiesAccounts,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                Logger().i("Error: ${snapshot.error}");
                return Container();
                // return Text("Error: ${snapshot.error}");
              }
              if (snapshot.data != null && snapshot.data!.isEmpty) {
                return Container();
              }

              return Positioned(
                top: 0,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: GetX<TodoHomeStore>(builder: (controller) {
                            if (controller.members.isEmpty ||
                                todoStore.currentUserIndex.value >=
                                    controller.members.length) {
                              return Center();
                            }
                            return Text(
                              controller
                                      .members[
                                          controller.currentUserIndex.value]
                                      .name ??
                                  "Người dùng",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            );
                          }),
                        ),
                      ),
                      familyChannel.when(
                        data: (value) =>
                            // Badge(
                            // // TODO: update badge
                            // label: Text("1"),
                            // backgroundColor: red.shade500,
                            // textColor: Colors.white,
                            // alignment: Alignment.topRight,
                            // largeSize: 16,
                            // offset: Offset(-4, 4),
                            // child:
                            ButtonIcon(
                                onPressed: () {
                                  Get.to(
                                    () => GroupChatPage(channelId: value.id),
                                  );
                                },
                                iconSize: 32,
                                padding: 0,
                                icon: "hipchat"),
                        // ),
                        error: (error, stackTrace) {
                          Logger().i("Error: $error");
                          return Container();
                        },
                        loading: () => const CustomCircleProgressIndicator(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          GetBuilder<TodoHomeStore>(builder: (todoStore) {
            return Positioned(
              left: 0,
              top: MediaQuery.of(context).size.height / 12,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        final currentIndex = todoStore.currentUserIndex.value;
                        if (currentIndex <= 0) {
                          todoStore
                              .setCurrentUser(todoStore.members.length - 1);
                        } else {
                          todoStore.setCurrentUser(currentIndex - 1);
                        }
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: primary.shade50.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: SvgPicture.asset(
                          "assets/todoPage/banner/chevron-left.svg",
                          fit: BoxFit.fill,
                          colorFilter: ColorFilter.mode(
                              primary.shade500, BlendMode.srcIn),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        final currentIndex = todoStore.currentUserIndex.value;
                        if (currentIndex == todoStore.members.length - 1) {
                          todoStore.setCurrentUser(0);
                        } else {
                          todoStore.setCurrentUser(currentIndex + 1);
                        }
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: primary.shade50.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: SvgPicture.asset(
                          "assets/todoPage/banner/chevron-right.svg",
                          fit: BoxFit.fill,
                          colorFilter: ColorFilter.mode(
                            primary.shade500,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          Positioned(
            top: MediaQuery.of(context).size.height / 4 - 28,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Obx(
                () => Indicator(
                  index: todoStore.currentUserIndex.value,
                  dotSize: 12,
                  height: 12,
                  lenght: todoStore.members.length,
                  selectedColor: Colors.white,
                  unselectedColor: Colors.white60,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BannerAvatar extends StatelessWidget {
  bool? isLoading;

  BannerAvatar({Key? key, this.isLoading = false});

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
          isLoading == false
              ? Positioned(
                  width: 72,
                  height: 72,
                  child: Container(
                    width: 20,
                    height: 20,
                    child: GetX<TodoHomeStore>(builder: (todoStore) {
                      if (todoStore.members.isEmpty) {
                        return Hero(
                          tag: "avatar-0",
                          child: AvatarPng(
                            borderColor: Colors.transparent,
                            imageUrl: "https://i.pravatar.cc/150?img=1",
                          ),
                        );
                      }
                      return Hero(
                        tag: "avatar-${todoStore.currentUserIndex.value}",
                        child: AvatarPng(
                          borderColor: Colors.transparent,
                          imageUrl: todoStore
                              .members[todoStore.currentUserIndex.value]
                              .avatarUrl,
                        ),
                      );
                    }),
                  ),
                )
              : Positioned(
                  width: 72,
                  height: 72,
                  child: Container(
                    width: 20,
                    height: 20,
                    child: const CustomCircleProgressIndicator(),
                  ),
                ),
        ],
      ),
    );
  }
}
