import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/error_page.dart';
import 'package:chatkid_mobile/pages/children_tracking/tracking_detail_page.dart';
import 'package:chatkid_mobile/providers/family_provider.dart';
import 'package:chatkid_mobile/services/family_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/avatar_png.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final mockdata = [
  {
    'id': '1',
    "name": "Hồng",
    "avatarUrl": "assets/images/avatars/1.png",
    "currentActive": " ở trường",
    "unRead": 3,
  },
  {
    'id': '2',
    "name": "Hồng",
    "avatarUrl": "assets/images/avatars/2.png",
    "currentActive": null,
    "unRead": 3,
  },
  {
    'id': '3',
    "name": "Hồng",
    "avatarUrl": "assets/images/avatars/3.png",
    "currentActive": " ở trường",
    "unRead": 3,
  },
  {
    'id': '4',
    "name": "Hồng",
    "avatarUrl": "assets/images/avatars/4.png",
    "currentActive": " ở trường",
    "unRead": 3,
  },
];

class ChildrenTrackingPage extends ConsumerStatefulWidget {
  final UserModel? user;
  final int? userIndex;
  const ChildrenTrackingPage({super.key, this.userIndex, this.user});

  @override
  ConsumerState<ChildrenTrackingPage> createState() =>
      _ChildrenTrackingPageState();
}

class _ChildrenTrackingPageState extends ConsumerState<ChildrenTrackingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final family = FamilyService().getFamily();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: FutureBuilder(
            future: family,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: ErrorPage(
                    message: snapshot.error.toString().split(':')[2],
                  ),
                );
              }

              final data =
                  snapshot.data!.members.fold(<UserModel>[], (value, element) {
                if (element.role == RoleConstant.Parent) {
                  return value;
                }
                value.add(element);
                return value;
              });

              return ListView.builder(
                itemCount: data.length < 3 ? data.length : 3,
                itemBuilder: (context, index) {
                  final user = data[index];

                  return SizedBox(
                    width: double.infinity,
                    child: CustomCard(
                      height: 200,
                      onTap: () {
                        Navigator.push(
                          context,
                          createRoute(
                            () => TrackingDetailPage(
                              activityId: user.id as String,
                            ),
                          ),
                        );
                      },
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          child: AvatarPng(
                            imageUrl: user.avatarUrl,
                            borderColor: primary.shade500,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        user.doing != null
                            ? Text(user.doing!)
                            : Text("${user.name} đang không hoạt động"),
                        const SizedBox(
                          height: 10,
                        ),
                        user.notSeenActivities != null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    user.notSeenActivities!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: primary.shade500,
                                          fontSize: 12,
                                        ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  SvgIcon(
                                    icon: "right_chevron",
                                    size: 12,
                                    color: primary.shade500,
                                  ),
                                ],
                              )
                            : Text(
                                "Không có hoạt động mới",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: primary.shade500,
                                      fontSize: 12,
                                    ),
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
