import 'package:chatkid_mobile/models/transaction_model.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/date_time.dart';
import 'package:chatkid_mobile/utils/number_format.dart';
import 'package:flutter/material.dart';

final Map<String, Map<String, dynamic>> statusTheme = {
  "PROCESSING": {
    "bgColor": primary.shade100,
    "color": primary.shade900,
    "text": "Chưa thanh toán",
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
  final HistoryTransactionModel transaction;

  const CardTransaction({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 44,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              Image.network(
                transaction.package.thumbnailUrl,
                width: 90,
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 160,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
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
                        Text(
                          DateTimeUtils.getFormattedDateTime(
                              transaction.createdAt),
                          style: TextStyle(
                            color: neutral.shade600,
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 160,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          transaction.package.name,
                          style: TextStyle(
                            color: neutral.shade900,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${NumberFormat.formatAmount(transaction.actualPrice.toString())} vnđ",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 160,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                        Text(
                          "Giảm ${NumberFormat.formatSale(transaction.price, transaction.actualPrice)}",
                          style: TextStyle(
                            color: green.shade800,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
