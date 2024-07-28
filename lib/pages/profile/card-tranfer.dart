import 'package:chatkid_mobile/models/transfer_model.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/date_time.dart';
import 'package:chatkid_mobile/utils/utils.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class CardTransfer extends StatelessWidget {
  final TransferModel transfer;

  const CardTransfer({super.key, required this.transfer});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 0.5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: transfer.diamond > 0
                      ? primary.shade100
                      : secondary.shade100,
                  borderRadius: BorderRadius.circular(1000),
                ),
                child: SvgIcon(
                  icon: transfer.diamond > 0 ? "arrow-down" : "arrow-up",
                  size: 24,
                  color: transfer.diamond > 0
                      ? primary.shade500
                      : secondary.shade500,
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transfer.diamond > 0 ? "Rút kim cương" : "Chuyển kim cương",
                    style: TextStyle(
                      color: HexColor("#252937"),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    DateTimeUtils.getFormattedDateTime(transfer.createdAt),
                    style: TextStyle(
                      color: neutral.shade600,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "${transfer.diamond < 0 ? "" : "+"}${transfer.diamond.toString()}",
                style: TextStyle(
                  color: neutral.shade900,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 4),
              Image.asset(
                "assets/icons/diamond_icon.png",
                width: 16,
              ),
              const SizedBox(width: 4),
            ],
          ),
        ],
      ),
    );
  }
}
