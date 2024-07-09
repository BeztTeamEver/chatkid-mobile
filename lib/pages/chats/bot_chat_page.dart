import 'dart:convert';

import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/constants/gpt_voice.dart';
import 'package:chatkid_mobile/enum/bot_type.dart';
import 'package:chatkid_mobile/models/bot_asset_model.dart';
import 'package:chatkid_mobile/models/kid_service_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/bot/bot_asset.dart';
import 'package:chatkid_mobile/providers/gpt_provider.dart';
import 'package:chatkid_mobile/services/asset_service.dart';
import 'package:chatkid_mobile/services/tts_service.dart';
import 'package:chatkid_mobile/services/wallet_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/loading_indicator.dart';
import 'package:chatkid_mobile/widgets/speech_to_text.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class BotChatPage extends ConsumerStatefulWidget {
  final BotType? botType;
  final String? content;
  const BotChatPage({super.key, this.botType = BotType.PUMKIN, this.content});

  @override
  ConsumerState<BotChatPage> createState() => _BotChatPageState();
}

class _BotChatPageState extends ConsumerState<BotChatPage> {
  TtsService ttsService = TtsService().instance;
  bool _loading = false;
  String? _lastWords = "";
  // TODO Remove this
  String _botServiceName = "Chat bot";
  UserModel? _user;
  final WalletController wallet = Get.put(WalletController());
  late Future<List<BotAssetModel>> currentSkin;

  Future<void> _onResult(String result) async {
    // _speechEnabled = await _speechToText.initialize();
    // setState(() {});
    Logger().i(result);

    if (result.isEmpty) {
      // await ttsService.speak("Bạn có thể nói lại cho tôi được không?");
      return;
    }

    try {
      setState(() {
        _loading = true;
      });
      // final kidService = _user?.kidServices ??
      //     // TODO: remove
      //     [
      //       KidServiceModel(
      //         id: '2f1b057b-67ac-4d8d-9c23-b0dd3d8b87b2',
      //         serviceType: 'Chat bot',
      //         status: 1,
      //       )
      //     ];
      // if (kidService == null) {
      //   throw Exception("Kid service is null");
      // }

      // String kidServiceId = kidService
      //         .firstWhere((element) => element.serviceType == _botServiceName)
      //         .id ??
      //     '';

      // if (kidServiceId.isEmpty) {
      //   throw Exception('Kid service id is empty');
      // }

      if (wallet.diamond.value == 0) {
        await ttsService.speak(
            'Tôi đã hết kim cương rồi, bạn hãy giúp tôi nạp kim cương nhé!');
        return;
      }
      final gptNotifier = ref.watch(gptProvider.notifier);
      // await gptNotifier.chat(result, kidServiceId).then((value) async {
      //   wallet.refetchWallet();
      //   await ttsService.speak(value);
      //   setState(() {
      //     _lastWords = value;
      //   });
      // }).whenComplete(() => setState(() {
      //       _loading = false;
      //     }));
    } catch (e, s) {
      Logger().e(e, stackTrace: s);
      ttsService.speak(
          "Tôi đang nâng cấp rồi, xin lỗi bạn nhé! tôi sẽ sớm trở lại với bạn");
      setState(() {
        _lastWords =
            "Tôi đang nâng cấp rồi, xin lỗi bạn nhé! tôi sẽ sớm trở lại với bạn";
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _hello({bool? test = true}) async {
    // TODO: revert this
    // UserModel user = await ref
    //     .watch(userProvider.notifier)
    //     .getUser(currentUser.id, currentUser.password);
    final user = UserModel(
        id: "13854ecf-796c-4682-b66b-aaf735d85564", role: RoleConstant.Child);

    String lastWords =
        'Xin chào, tôi là Kidtalkie. Bạn có câu hỏi gì cho tôi không?';

    if (wallet.diamond == 0) {
      lastWords =
          'Tôi đã hết kim cương rồi, bạn hãy giúp tôi nạp kim cương nhé!';
    } else {
      setState(() {
        _user = user;
        // TODO: revert this
        // _botServiceName = widget.botType == BotType.PUMKIN
        //     ? ServiceTypeConstant.PUMPKIN
        //     : ServiceTypeConstant.STRAWBERRY;
        _botServiceName = "Chat bot";

        _lastWords = lastWords;
      });
      Logger().i('init success');
    }
    await ttsService.speak(lastWords);
  }

  void initTts() async {
    ttsService.stop();
    if (widget.botType == BotType.PUMKIN) {
      await ttsService.setVoice(GptVoice.PumkinVoice);
    } else {
      await ttsService.setVoice(GptVoice.CherryVoice);
    }
    await _hello();
    if (widget.content != null) {
      _onResult(widget.content!);
    }
  }

  @override
  void initState() {
    super.initState();
    initTts();
    ttsService.stop();
    currentSkin = BotAssetService().getCurrentSkin();
  }

  @override
  void dispose() {
    ttsService.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = widget.botType == BotType.PUMKIN ? primary : secondary;
    final botName =
        widget.botType == BotType.PUMKIN ? 'full_pumkin' : 'full_cherry';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: 96,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  createRoute(() => const BotAsset()),
                );
              },
              icon: SvgIcon(
                icon: "info",
                size: 30,
                color: primaryColor.shade500,
              ),
            ),
            SpeechToTextButton(
              onResult: _onResult,
              color: primaryColor,
            ),
            IconButton(
              onPressed: () {},
              icon: SvgIcon(
                icon: "history",
                size: 30,
                color: primaryColor.shade500,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: primaryColor.shade50,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 80,
              width: MediaQuery.of(context).size.width,
              child: SvgPicture.asset('assets/botChatPage/heading.svg'),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 2,
                        color: primaryColor.shade200,
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    height: 40,
                    width: 144,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/diamond_icon.png",
                          height: 20,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Obx(
                          () => Text(
                            "${wallet.diamond}",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 310,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            constraints: const BoxConstraints(
                              maxHeight: 120,
                            ),
                            decoration: BoxDecoration(
                              color: primary.shade100.withOpacity(0.8),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(8),
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 200),
                                transitionBuilder: (child, animation) =>
                                    ScaleTransition(
                                        scale: animation, child: child),
                                child: _loading
                                    ? const Loading()
                                    : Text(
                                        _lastWords ??
                                            "Xin chào, tôi là kidtalkie. Bạn có câu hỏi gì cho tôi không?",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                        textAlign: TextAlign.center,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: FutureBuilder(
                            future: currentSkin,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final data =
                                    snapshot.data as List<BotAssetModel>;
                                return Stack(
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                                  2 -
                                              AppBar().preferredSize.height / 2,
                                      decoration:
                                          BoxDecoration(color: primary.shade50),
                                    ),
                                    ...data
                                        .map((item) => Positioned(
                                              left: 0,
                                              top: 0,
                                              child: Image.network(
                                                item.imageUrl ?? "",
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        2 -
                                                    AppBar()
                                                            .preferredSize
                                                            .height /
                                                        2,
                                                fit: BoxFit.cover,
                                              ),
                                            ))
                                        .toList(),
                                  ],
                                );
                              }
                              if (snapshot.hasError) {
                                Logger().e(snapshot.error);
                                // return SvgPicture.asset('robot/full_pumkin.svg',
                                //     width: MediaQuery.of(context).size.width,
                                //     height:
                                //         MediaQuery.of(context).size.height / 2 -
                                //             AppBar().preferredSize.height / 2,
                                //     fit: BoxFit.cover);
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 2 -
                                          AppBar().preferredSize.height / 2,
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              return SvgPicture.asset(
                                'assets/robot/full_pumkin.svg',
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 2 -
                                    AppBar().preferredSize.height / 2,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  TrianglePainter(
      {this.strokeColor = Colors.black,
      this.strokeWidth = 3,
      this.paintingStyle = PaintingStyle.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(0, y)
      ..lineTo(x / 2, 0)
      ..lineTo(x, y)
      ..lineTo(0, y);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
