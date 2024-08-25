import 'dart:convert';
import 'dart:io';

import 'package:chatkid_mobile/models/gift_model.dart';
import 'package:chatkid_mobile/pages/store/store_page.dart';
import 'package:chatkid_mobile/services/file_service.dart';
import 'package:chatkid_mobile/services/gift_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/utils/toast.dart';
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
import 'package:permission_handler/permission_handler.dart';

class FormItem extends StatefulWidget {
  final GiftModel? gift;
  final Function() refetch;

  const FormItem({super.key, this.gift, required this.refetch});

  @override
  State<FormItem> createState() => _FormItemState();
}

class _FormItemState extends State<FormItem> {
  String selectedFile = '';
  bool isLoading = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  _checkPermission() async {
    var status = await Permission.storage.status;
    Logger().i(status);
    bool result = false;
    if (status.isDenied) {
      await Permission.storage.onDeniedCallback(() async {
        Logger().i("Denied");
      }).onGrantedCallback(() {
        result = true;
        Logger().i("Granted");
      }).request();
    } else {
      Logger().i("Granted");
      result = true;
    }
    return result;
  }

  _handleUploadImage() async {
    if (await _checkPermission()) {
      FilePickerResult? file =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (file != null) {
        Logger().d(file.files.single.path);
        setState(() {
          selectedFile = file.files.single.path ?? '';
        });
      }
    }
  }

  _handleUpdateGift() async {
    if (selectedFile.contains('http://') || selectedFile.contains('https://')) {
      GiftService()
          .updateGift(
            widget.gift?.id ?? '',
            GiftModel(
              imageUrl: selectedFile,
              title: titleController.text,
              numberOfCoin: int.parse(priceController.text),
            ),
          )
          .then(
            (value) => {
              ShowToast.success(msg: "Chỉnh sửa quà thành công 🎉"),
              widget.refetch(),
              Navigator.pop(context),
            },
          )
          .catchError(
            (err) => {
              ShowToast.error(msg: "Chỉnh sửa quà thất bại"),
            },
          )
          .whenComplete(
            () => setState(() {
              isLoading = false;
            }),
          );
    } else {
      FileService().sendfile(File(selectedFile)).then(
            (value) => GiftService()
                .updateGift(
                  widget.gift?.id ?? '',
                  GiftModel(
                    imageUrl: value.url,
                    title: titleController.text,
                    numberOfCoin: int.parse(priceController.text),
                  ),
                )
                .then(
                  (value) => {
                    ShowToast.success(msg: "Chỉnh sửa quà thành công 🎉"),
                    widget.refetch(),
                    Navigator.pop(context),
                  },
                )
                .catchError(
                  (err) => {
                    ShowToast.error(msg: "Chỉnh sửa quà thất bại"),
                  },
                )
                .whenComplete(
                  () => setState(() {
                    isLoading = false;
                  }),
                ),
          );
    }
  }

  _handleCreateGift() async {
    setState(() {
      isLoading = true;
    });
    FileService().sendfile(File(selectedFile)).then((value) => {
          GiftService()
              .createGift(GiftModel(
                title: titleController.text,
                imageUrl: value.url,
                numberOfCoin: int.parse(priceController.text),
              ))
              .then(
                (value) => {
                  ShowToast.success(msg: "Thêm quà thành công 🎉"),
                  widget.refetch(),
                  Navigator.pop(context),
                },
              )
              .catchError(
                (err) => {
                  ShowToast.error(msg: "Thêm quà thất bại"),
                },
              )
              .whenComplete(
                () => setState(() {
                  isLoading = false;
                }),
              )
        });
  }

  @override
  void initState() {
    super.initState();
    titleController.text = widget.gift?.title ?? "";
    priceController.text = widget.gift?.numberOfCoin.toString() ?? "";
    selectedFile = widget.gift?.imageUrl ?? "";
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
                          Icons.arrow_back_ios_new_rounded,
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
                          if (!isLoading) Navigator.of(context).pop();
                        },
                      ),
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: Text(
                        widget.gift.isNull ? "Tạo quà" : "Chỉnh sửa quà",
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
                    controller: priceController,
                    hint: "100",
                    validator: ValidationBuilder(
                      requiredMessage: "Vui lòng nhập giá trị món quà",
                    ).required().build(),
                    type: TextInputType.number,
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
                Stack(
                  alignment: Alignment.center,
                  children: [
                    if (selectedFile.contains('http://') ||
                        selectedFile.contains('https://'))
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Image.network(
                          selectedFile,
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.width / 2,
                          fit: BoxFit.cover,
                        ),
                      )
                    else if (selectedFile != '')
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Image.file(
                          File(selectedFile),
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.width / 2,
                          fit: BoxFit.cover,
                        ),
                      )
                    else
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
                    Visibility(
                      visible: selectedFile != '',
                      child: Positioned(
                        top: 0,
                        right: MediaQuery.of(context).size.width / 4 - 40,
                        child: IconButton(
                          iconSize: 36,
                          style: const ButtonStyle(
                            padding:
                                MaterialStatePropertyAll(EdgeInsets.all(0)),
                          ),
                          onPressed: () {
                            setState(() {
                              selectedFile = '';
                            });
                          },
                          icon: Container(
                            decoration: BoxDecoration(
                                color: primary.shade50,
                                borderRadius: BorderRadius.circular(100)),
                            child: Icon(
                              Icons.cancel_outlined,
                              color: primary.shade400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                FullWidthButton(
                  onPressed: () {
                    if (widget.gift.isNull)
                      _handleCreateGift();
                    else
                      _handleUpdateGift();
                  },
                  isLoading: isLoading,
                  isDisabled: (titleController.text == '' ||
                      priceController.text == '' ||
                      selectedFile == ''),
                  child: Text(
                    widget.gift.isNull ? "Tạo" : "Chỉnh sửa",
                    style: const TextStyle(
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
