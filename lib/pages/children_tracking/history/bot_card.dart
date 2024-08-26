import 'dart:io';
import 'dart:math';

import 'package:chatkid_mobile/constants/date.dart';
import 'package:chatkid_mobile/constants/history.dart';
import 'package:chatkid_mobile/models/history_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/controller/bot_chat_page/bot_history_store.dart';
import 'package:chatkid_mobile/services/history_service.dart';
import 'package:chatkid_mobile/services/tts_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/toast.dart';
// import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/widgets/chat_box.dart';
import 'package:chatkid_mobile/widgets/confirmation/confirm_modal.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:chatkid_mobile/widgets/label.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:path_provider/path_provider.dart';

class HistoryCard extends StatefulWidget {
  final HistoryBotChatModel history;
  final UserModel user;
  const HistoryCard({super.key, required this.history, required this.user});

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  final TtsService tts = TtsService();
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final BotHistoryStore historyStore = Get.find<BotHistoryStore>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    removeFile();
    super.dispose();
  }

  removeFile() async {
    final directory = await getExternalStorageDirectory();
    File file = File(
        "${directory!.path}/tts-${widget.history.createdAt ?? DateTime.now()}.wav");
    file.delete();
  }

  submit() async {
    final formState = formKey.currentState!;
    final isValid = formState.saveAndValidate();
    if (isValid) {
      final value = formState.value;
      final report = HistoryReportModel.fromJson({
        "reasons": value["reasons"],
        "botQuestionId": widget.history.id,
      });

      await HistoryService.report(report);
      historyStore.updateStatus(widget.history.id, ReportStatus.PENDING);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Future<File> botVoiceFile = tts
    //     .convertToAudio(widget.history.answer, time: widget.history.createdAt)
    //     .then((value) {
    //   return value;
    // });
    return CustomCard(
      padding: const EdgeInsets.all(16),
      backgroundColor: Colors.white,
      children: [
        Text(
          "${widget.user.name} đã đặt câu hỏi",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: neutral.shade800,
              ),
        ),
        SizedBox(
          height: 8,
        ),
        if (widget.history.reportStatus != ReportStatus.NA)
          Label(
              type: ReportStatusTypeMap[widget.history.reportStatus]!,
              label: ReportStatusMap[widget.history.reportStatus]!),
        SizedBox(
          height: 8,
        ),
        Text(
          widget.history.createdAt!.format(DateConstants.dateTimeFormat),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 12,
                color: neutral.shade500,
              ),
        ),
        SizedBox(height: 8),
        ChatTextBox(
          isSender: true,
          width: MediaQuery.of(context).size.width * 0.5,
          useTextfullWidth: true,
          useSenderAvatar: true,
          user: widget.user,
          isUseSenderAvatar: true,
          voiceUrl: widget.history.voiceUrl,
          message: widget.history.content,
        ),
        SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              "assets/robot/pumkin.svg",
              width: 24,
              height: 24,
            ),
            Expanded(
              child: ChatTextBox(
                width: MediaQuery.of(context).size.width * 0.5,
                user: UserModel(
                  id: "bot",
                  avatarUrl: "assets/robot/pumkin.svg",
                  name: "Bot",
                ),
                useTextfullWidth: true,
                backgroundColor: primary.shade100,
                voiceUrl: widget.history.botVoiceUrl,
                message: widget.history.answer,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Container(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () async {
              // if (isLoading) {
              //   return;
              // }
              // if (widget.onCancel != null) {
              //   widget.onCancel!();
              // }
              // Navigator.of(context).pop();.
              final result = await showDialog(
                  context: context,
                  builder: (context) {
                    return ConfirmModal(
                      title: "Báo cáo hoạt động",
                      onConfirm: () async {
                        await submit();
                      },
                      content:
                          "Botchat vẫn trong quá trình phát triển KidTalkie chân thành cảm ơn bạn đã đồng hành và giúp chúng tôi ngày càng hoàn thiện",
                      contentWidget: ReportSelector(formKey: formKey),
                    );
                  });
              if (result != null) {
                ShowToast.success(
                  msg: "Báo cáo thành công",
                );
              }
            },
            style: ElevatedButtonTheme.of(context).style!.copyWith(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.transparent,
                  ),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      side: BorderSide(
                        color: primary.shade500,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  shadowColor: MaterialStatePropertyAll(
                    Colors.transparent,
                  ),
                ),
            child: Text(
              "Báo cáo",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: primary.shade500,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}

class ReportSelector extends StatefulWidget {
  final GlobalKey<FormBuilderState> formKey;
  const ReportSelector({super.key, required this.formKey});

  @override
  State<ReportSelector> createState() => _ReportSelectorState();
}

class _ReportSelectorState extends State<ReportSelector> {
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: widget.formKey,
      child: Column(
        children: [
          FormBuilderCheckboxGroup(
            name: 'reasons',
            checkColor: Colors.white,
            decoration: const InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              border: InputBorder.none,
            ),
            validator: FormBuilderValidators.compose<List<String>>(
              [
                FormBuilderValidators.required(
                    errorText: "Vui lòng chọn ít nhất 1 mục"),
                FormBuilderValidators.minLength(1,
                    errorText: "Vui lòng chọn ít nhất 1 mục"),
              ],
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            orientation: OptionsOrientation.vertical,
            options: [
              FormBuilderFieldOption(
                value: "Câu trả lời không chính xác",
                child: Text(
                  "Câu trả lời không chính xác",
                ),
              ),
              FormBuilderFieldOption(
                value: "Từ ngữ không phù hợp với độ tuổi của trẻ",
                child: Text(
                  "Từ ngữ không phù hợp với độ tuổi của trẻ",
                ),
              ),
              FormBuilderFieldOption(
                value: "Câu hỏi này không nên được trả lời",
                child: Text(
                  "Câu hỏi này không nên được trả lời",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  option(String value, String title) {
    return FormBuilderFieldOption(
      value: value,
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontSize: 14, color: neutral.shade800),
      ),
    );
  }
}
