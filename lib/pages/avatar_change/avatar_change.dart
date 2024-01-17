import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/widgets/avatar.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:pinput/pinput.dart';

class AvatarChange extends StatefulWidget {
  final TextEditingController controller;
  final Function onChange;
  final options;

  const AvatarChange({
    super.key,
    this.options,
    required this.onChange,
    required this.controller,
  });

  @override
  State<AvatarChange> createState() => _AvatarChangeState();
}

class _AvatarChangeState extends State<AvatarChange> {
  String _avatarUrl = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _avatarUrl = widget.controller.text;
    });
  }

  _onChange() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg', 'svg'],
    );
    if (result != null) {
      setState(() {
        // _avatarUrl = result.files.single.path!;
        _avatarUrl = result.files.single.path!;
      });
      // widget.controller.text = _avatarUrl;
      widget.controller.setText(result.files.single.path!);
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    "Thay đổi ảnh đại diện",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Avatar(icon: _avatarUrl),
                ],
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                ),
                child: SingleChildScrollView(
                  child: Wrap(
                    runSpacing: 2,
                    spacing: 2,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          _onChange();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Avatar(icon: "upload"),
                        ),
                      ),
                      ...DefaultAvatar.DefaultAvatarList.map(
                        (e) => GestureDetector(
                          onTap: () {
                            setState(() {
                              _avatarUrl = e;
                            });
                            widget.controller.text = e;
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Avatar(icon: e),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FullWidthButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Xác nhận",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontSize: 16, color: Colors.white),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
