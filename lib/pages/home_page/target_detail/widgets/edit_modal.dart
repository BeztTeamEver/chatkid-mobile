import 'package:chatkid_mobile/pages/routes/target_create_route.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/confirmation/confirm_modal.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class EditModal extends StatefulWidget {
  final String id;
  const EditModal({super.key, required this.id});

  @override
  State<EditModal> createState() => _EditModalState();
}

class _EditModalState extends State<EditModal> {
  handleDelete() async {
    await showDialog(
      context: context,
      builder: (context) => ConfirmModal(
        title: "Xác nhận xóa",
        content: "Bạn có chắc chắn muốn xóa công việc này?",
        onConfirm: () {
          // todoHomeStore.deleteTask(widget.id);
          Navigator.of(context).pop();
        },
      ),
    );
  }

  handleEdit() async {
    // todoHomeStore.editTask(widget.id);
    final result =
        await Navigator.of(context).push(createRoute(() => TargetCreateRoute(
              id: widget.id,
            )));

    if (result != null) {
      Navigator.of(context).pop(result);
    }
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        children: [
          ListTile(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: neutral.shade400,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            onTap: () {
              handleEdit();
            },
            title: const Text("Chỉnh sửa mục tiêu"),
            leading: SvgIcon(
              icon: 'edit',
              color: primary.shade500,
              size: 24,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          ListTile(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: neutral.shade400,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              onTap: () {
                // todoHomeStore.deleteTask(widget.id);

                Navigator.of(context).pop();
              },
              title: const Text("Xóa mục tiêu"),
              leading: SvgIcon(
                icon: 'trash',
                size: 24,
              )),
        ],
      ),
    );
  }
}
