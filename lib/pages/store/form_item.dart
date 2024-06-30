import 'package:chatkid_mobile/models/gift_model.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/utils.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:chatkid_mobile/widgets/input_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class FormItem extends StatefulWidget {
  final GiftModel? giftModel;

  const FormItem({super.key, this.giftModel});

  @override
  State<FormItem> createState() => _FormItemState();
}

class _FormItemState extends State<FormItem> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  _handleUploadImage() async {
    FilePickerResult? file = await FilePicker.platform
        .pickFiles(type: FileType.image);
    if (file != null) {
      Logger().d(file.files.single.path);
      // _pickedFile = File(file.files.first.path!);
      // onChanged.call(_pickedFile!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("FFF8ED"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: -5,
                      top: 0,
                      child: IconButton(
                        icon: Icon(
                          Icons.chevron_left,
                          color: primary.shade400,
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                            (states) => primary.shade100,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: Text(
                        widget.giftModel.isNull ? "Tạo quà" : "Chỉnh sửa quà",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                          color: neutral.shade900,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Tựa đề",
                    style: TextStyle(
                      color: neutral.shade900,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                FormBuilder(
                  child: InputField(
                    name: "title",
                    controller: titleController,
                    hint: "Búp bê",
                    validator: ValidationBuilder(
                      requiredMessage: "Vui lòng nhập tên món quà",
                    ).required().build(),
                    autoFocus: true,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Giá trị",
                    style: TextStyle(
                      color: neutral.shade900,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                FormBuilder(
                  child: InputField(
                    name: "price",
                    controller: titleController,
                    hint: "100",
                    validator: ValidationBuilder(
                      requiredMessage: "Vui lòng nhập tên món quà",
                    ).required().build(),
                    autoFocus: true,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Hình ảnh",
                    style: TextStyle(
                      color: neutral.shade900,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: _handleUploadImage,
                  child: DottedBorder(
                    dashPattern: const [12, 12, 12, 12],
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12),
                    color: primary.shade500,
                    strokeWidth: 2,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: primary.shade500,
                          size: 42,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                FullWidthButton(
                  onPressed: () {},
                  child: const Text(
                    "Tạo",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
