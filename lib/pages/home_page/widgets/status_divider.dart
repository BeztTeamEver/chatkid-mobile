import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatusDivider extends StatefulWidget {
  final String status;
  final Color color;
  const StatusDivider({
    super.key,
    required this.status,
    required this.color,
  });

  @override
  State<StatusDivider> createState() => _StatusDividerState();
}

class _StatusDividerState extends State<StatusDivider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: primary.shade100,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          Text(
            widget.status,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: widget.color,
                ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Divider(
              height: 2,
              indent: 4,
              endIndent: 10,
              color: widget.color,
            ),
          ),
        ],
      ),
    );
  }
}
