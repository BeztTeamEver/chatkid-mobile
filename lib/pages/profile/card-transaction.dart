import 'package:chatkid_mobile/models/transaction_model.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/date_time.dart';
import 'package:chatkid_mobile/utils/number_format.dart';
import 'package:flutter/material.dart';

final Map<String, Map<String, dynamic>> statusTheme = {
  "PROCESSING": {
    "bgColor": primary.shade100,
    "color": primary.shade900,
    "text": "Đang xử lý",
  },
  "SUCCESSFUL": {
    "bgColor": green.shade50,
    "color": green.shade900,
    "text": "Thành công",
  },
  "FAILED": {
    "bgColor": red.shade100,
    "color": red.shade900,
    "text": "Thất bại",
  },
};

class CardTransaction extends StatelessWidget {
  final TransactionModel transaction;

  const CardTransaction({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 44,
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusTheme[transaction.status]!["bgColor"],
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Text(
                      statusTheme[transaction.status]!["text"],
                      style: TextStyle(
                        color: statusTheme[transaction.status]!["color"],
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Image.network(
                    transaction.package.thumbnailUrl,
                    width: 90,
                  )
                ],
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.package.name,
                    style: TextStyle(
                      color: neutral.shade900,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/icons/diamond_icon.png",
                        width: 12,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        transaction.package.diamond.toString(),
                        style: TextStyle(
                          color: neutral.shade800,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${NumberFormat.formatAmount(transaction.package.actualPrice.toString() ?? "0")} vnđ",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Giảm ${NumberFormat.formatSale(transaction.package.price, transaction.package.actualPrice)}",
                style: TextStyle(
                  color: green.shade800,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                DateTimeUtils.getFormattedDateTime(transaction.createdAt),
                style: TextStyle(
                  color: neutral.shade600,
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
