import 'package:chatkid_mobile/models/history_model.dart';
import 'package:chatkid_mobile/models/paging_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/providers/history_provider.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/date_time.dart';
import 'package:chatkid_mobile/widgets/avatar_png.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class HistoryPage extends ConsumerStatefulWidget {
  final UserModel user;
  const HistoryPage({super.key, required this.user});

  @override
  ConsumerState<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  final ItemScrollController _scrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetController _scrollOffsetController =
      ScrollOffsetController();
  final ScrollOffsetListener _scrollOffsetListener =
      ScrollOffsetListener.create();

  int _currentPage = 0;
  List<HistoryModel> _histories = [];
  bool _isLoading = false;
  bool _isLoadMore = true;

  void getHistories() async {
    if (!_isLoadMore) {
      Logger().i("No more data");
      return;
    }
    setState(() {
      _isLoading = true;
    });

    final request = HistoryRequestModal(
      memberId: widget.user.id!,
      paging: PagingModel(pageSize: 10, pageNumber: _currentPage),
    );

    await ref.read(getHistoryProvider(request).future).then((value) {
      if (value.items.isEmpty) {
        setState(() {
          _isLoadMore = false;
        });
        return;
      }
      setState(() {
        _currentPage++;
        _histories.addAll(value.items);
      });
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _init() async {
    getHistories();

    _itemPositionsListener.itemPositions.addListener(
      () {
        final positions = _itemPositionsListener.itemPositions.value;
        if (!_isLoadMore) {
          Logger().i("No more data");
          return;
        }
        if (positions.isEmpty) {
          return;
        }
        if (positions.last.index == _histories.length - 1 &&
            _histories.length >= 10) {
          getHistories();
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  Builder _listHistoryBuilder(
      BuildContext context, int index, List<HistoryModel> histories) {
    final history = histories[index];
    return Builder(
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: CustomCard(
            height: 120,
            children: [
              SizedBox(
                child: Row(
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: AvatarPng(
                        imageUrl: widget.user.avatarUrl!,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${widget.user.name} ${history.title!}',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                        ),
                        Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                            children: [
                              TextSpan(
                                text: DateTimeUtils.getFormatedDate(
                                    DateTime.parse(history.createdAt!),
                                    DateTimeUtils.DATE_TIME_ACTIVITY_FORMAT),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: neutral.shade400,
                                    ),
                              ),
                              history.note != null
                                  ? const WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: SvgIcon(
                                          size: 6,
                                          icon: 'dot',
                                        ),
                                      ),
                                    )
                                  : const TextSpan(),
                              history.note != null
                                  ? TextSpan(
                                      text: '${history.note}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: neutral.shade400,
                                          ),
                                    )
                                  : const TextSpan(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Lịch sử hoạt động',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            _histories.length != 0
                ? Expanded(
                    child: ScrollablePositionedList.builder(
                      itemBuilder: (context, index) =>
                          _listHistoryBuilder(context, index, _histories),
                      itemCount: _histories.length,
                      padding: const EdgeInsets.only(bottom: 40),
                      scrollOffsetController: _scrollOffsetController,
                      scrollOffsetListener: _scrollOffsetListener,
                      itemScrollController: _scrollController,
                      itemPositionsListener: _itemPositionsListener,
                    ),
                  )
                : Container(),
            _isLoading
                ? const SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
