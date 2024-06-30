import 'package:chatkid_mobile/utils/error_snackbar.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class KidBottomBar extends StatelessWidget {
  const KidBottomBar({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 60,
      notchMargin: 15,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              ErrorSnackbar.showError(
                  err: Exception("Chức năng này đang được phát triển"),
                  context: context);
            },
            icon: const SvgIcon(icon: 'location'),
          ),
          IconButton(
            onPressed: () {
              ErrorSnackbar.showError(
                  err: Exception("Chức năng này đang được phát triển"),
                  context: context);
            },
            icon: const SvgIcon(icon: 'camera'),
          ),
          const SizedBox(
            width: 80,
          ),
          IconButton(
            onPressed: () {
              ErrorSnackbar.showError(
                  err: Exception("Chức năng này đang được phát triển"),
                  context: context);
            },
            icon: const SvgIcon(icon: 'sticker'),
          ),
          IconButton(
            onPressed: () {
              ErrorSnackbar.showError(
                  err: Exception("Chức năng này đang được phát triển"),
                  context: context);
            },
            icon: const SvgIcon(icon: 'photo'),
          ),
        ],
      ),
    );
  }
}
