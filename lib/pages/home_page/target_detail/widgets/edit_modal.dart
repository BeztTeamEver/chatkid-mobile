import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditModal extends StatelessWidget {
  const EditModal({super.key});

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
              // todoHomeStore.deleteTask(widget.id);
              Navigator.of(context).pop();
            },
            title: const Text("Chỉnh sửa công việc"),
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
              title: const Text("Xóa công việc"),
              leading: SvgIcon(
                icon: 'trash',
                size: 24,
              )),
        ],
      ),
    );
  }
}
