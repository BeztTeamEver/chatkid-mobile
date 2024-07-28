import 'dart:io';

import 'package:chatkid_mobile/models/file_model.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/target_store.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/target_page/target_assign_page.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/target_page/widgets/mission_create_item.dart';
import 'package:chatkid_mobile/services/file_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/utils/toast.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:chatkid_mobile/widgets/custom_progress_indicator.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:chatkid_mobile/widgets/input_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class TargetAddGiftPage extends StatefulWidget {
  const TargetAddGiftPage({super.key});

  @override
  State<TargetAddGiftPage> createState() => _TargetAddGiftPageState();
}

class _TargetAddGiftPageState extends State<TargetAddGiftPage> {
  final TargetFormStore targetFormStore = Get.find();
  bool uploadingImage = false;
  String? giftImageErrorText;

  void uploadGiftImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg', 'svg'],
    );
    if (result != null) {
      // TODO: get the image link from the internet
      File file = await File(result.files.single.path!).create(recursive: true);
      Logger().i(result.files.single.bytes);
      targetFormStore.addGiftImage(file.path);
    } else {
      // User canceled the picker
    }
  }

  void onSubmit() async {
    final form = targetFormStore.formKey.currentState;

    if (form?.saveAndValidate() ?? false) {
      setState(() {
        uploadingImage = true;
      });
      try {
        if (targetFormStore.giftImages.isEmpty) {
          ShowToast.error(msg: "Vui lòng chọn hình ảnh minh họa");
          return;
        }
        File file = File(targetFormStore.giftImages[0]);
        FileModel rewardImageUrl = await FileService().sendfile(file);

        form?.fields['rewardImageUrl']?.didChange(rewardImageUrl.url);

        targetFormStore.increaseStep();
        targetFormStore.updateProgress();
        Navigator.of(context).push(createRoute(() => TargetAssignPage()));
      } catch (e) {
        ShowToast.error(msg: "Có lỗi xảy ra, vui lòng thử lại sau");
      } finally {
        setState(() {
          uploadingImage = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Logger().i(targetFormStore.formKey.currentState?.value['missions']);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      primary: false,
      body: Container(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(8),
        child: GetX<TargetFormStore>(builder: (controller) {
          final gifts = targetFormStore.giftImages
              .map(
                (element) => GiftImageCard(imageUrl: element),
              )
              .toList();
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormBuilderField(
                  builder: (field) => Container(),
                  name: 'rewardImageUrl',
                ),
                InputField(
                  name: 'reward',
                  label: "Tên quà",
                  hint: "Nhập tên quà",
                  validator: FormBuilderValidators.compose([
                    (val) {
                      if (targetFormStore.step.value != 2) {
                        return null;
                      }
                      if (val == null || val.isEmpty) {
                        return "Vui lòng nhập tên quà";
                      }
                      return null;
                    }
                  ]),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  "Hình ảnh minh họa",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(
                  height: 12,
                ),
                if (gifts.isNotEmpty) gifts[0],
                const SizedBox(
                  height: 12,
                ),
                if (gifts.isEmpty)
                  CreateItemCard(
                    onAdd: () {
                      uploadGiftImage();
                    },
                  ),
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(8.0),
        child: FullWidthButton(
          onPressed: () {
            onSubmit();
          },
          isDisabled: uploadingImage,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (uploadingImage) CustomCircleProgressIndicator(),
              SizedBox(width: uploadingImage ? 0 : 8),
              Text(
                "Tiếp theo",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GiftImageCard extends StatelessWidget {
  final String imageUrl;

  const GiftImageCard({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final TargetFormStore targetFormStore = Get.find();

    return CustomCard(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.zero,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Slidable(
          endActionPane: ActionPane(
            motion: ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  targetFormStore.removeGiftImage(imageUrl);
                },
                icon: Icons.delete,
                backgroundColor: red.shade500,
                flex: 1,
                label: 'Xóa',
              ),
            ],
          ),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: 280,
            ),
            width: MediaQuery.of(context).size.width,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Image.file(
                File(imageUrl),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
