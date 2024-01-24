import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/widgets/avatar.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:pinput/pinput.dart';

class AvatarChange extends StatefulWidget {
  final String? value;
  final Function(String) onAccept;
  final options;

  const AvatarChange({
    super.key,
    this.options,
    required this.onAccept,
    required this.value,
  });

  @override
  State<AvatarChange> createState() => _AvatarChangeState();
}

class _AvatarChangeState extends State<AvatarChange> {
  String _avatarUrl = "animal/bear";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _avatarUrl = widget.value ?? "animal/bear";
    });
  }

  _onChange(String e) {
    setState(() {
      _avatarUrl = e;
    });
    Logger().d(e);
  }

  _onFileUpload() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg', 'svg'],
    );
    if (result != null) {
      // TODO: get the image link from the internet
      _onChange(result.files.single.path!);
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
                          _onFileUpload();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Avatar(icon: "upload"),
                        ),
                      ),
                      ...widget.options.map(
                        (e) => GestureDetector(
                          onTap: () {
                            _onChange(e);
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
                    widget.onAccept(_avatarUrl);
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
