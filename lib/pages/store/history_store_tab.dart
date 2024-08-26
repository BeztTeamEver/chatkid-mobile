import 'package:chatkid_mobile/models/gift_model.dart';
import 'package:chatkid_mobile/services/gift_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/date_time.dart';
import 'package:chatkid_mobile/utils/toast.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

class HistoryStoreTab extends StatefulWidget {
  final String userName;
  final Function(int) handleRefetch;
  final List<GiftModel> histories;

  const HistoryStoreTab({
    super.key,
    required this.userName,
    required this.histories,
    required this.handleRefetch,
  });

  @override
  State<HistoryStoreTab> createState() => _HistoryStoreTabState();
}

class _HistoryStoreTabState extends State<HistoryStoreTab> {
  String idLoading = '';

  void handleConfirm(String id) {
    setState(() {
      idLoading = id;
    });

    GiftService()
        .confirmBoughtGift(id)
        .then(
          (value) => {
            widget.handleRefetch(
                widget.histories.indexWhere((element) => element.id == id)),
            ShowToast.success(msg: "Xác nhận thành công 🎉"),
          },
        )
        .catchError((e) {
      Logger().e(e);
      ShowToast.error(msg: "Đã có lỗi xảy ra vui lòng thử lại sau!");
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.histories.isNotEmpty) {
      return SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20),
        child: Wrap(
          direction: Axis.vertical,
          spacing: 12,
          children: widget.histories
              .map(
                (item) => Container(
                  width: MediaQuery.of(context).size.width - 44,
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 8,
                    right: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Image.network(
                                item.imageUrl!,
                                width: MediaQuery.of(context).size.width / 5,
                                height: MediaQuery.of(context).size.width / 7,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 5,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: primary.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SvgIcon(
                                      icon: "coin",
                                      size: 16,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      (item.numberOfCoin ?? 0).toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8 - 72,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  DateTimeUtils.getFormattedDateTime(
                                      item.createdAt ?? ''),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: neutral.shade500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  item.title ?? '',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: neutral.shade900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      if (item.status == "AWARDED")
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: neutral.shade50,
                            borderRadius: BorderRadius.circular(46),
                            border: Border.all(
                              width: 1,
                              color: neutral.shade300,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.done_rounded,
                                size: 18,
                                color: neutral.shade300,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                'Đã tặng quà',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: neutral.shade300,
                                ),
                              ),
                            ],
                          ),
                        )
                      else if (item.id == idLoading)
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: neutral.shade50,
                            borderRadius: BorderRadius.circular(46),
                            border: Border.all(
                              width: 1,
                              color: neutral.shade300,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 14,
                                height: 14,
                                child: CircularProgressIndicator(
                                  color: neutral.shade300,
                                  strokeWidth: 2,
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                'Xác nhận đã tặng quà',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: neutral.shade300,
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        IconButton(
                          color: primary.shade500,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                              minHeight: 32, maxHeight: 32),
                          onPressed: () {
                            handleConfirm(item.id ?? '');
                          },
                          icon: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(46),
                              border: Border.all(
                                width: 1,
                                color: primary.shade500,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.done_rounded,
                                  size: 18,
                                  color: primary.shade500,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  'Xác nhận đã tặng quà',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: primary.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/payment/bot-head.png",
              width: 150,
            ),
            const SizedBox(height: 16),
            Text(
              "Lịch sử đổi quà hiện đang trống",
              style: TextStyle(
                color: neutral.shade900,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 130),
          ],
        ),
      );
    }
  }
}
