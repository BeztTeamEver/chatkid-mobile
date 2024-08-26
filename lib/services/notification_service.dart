import 'dart:convert';

import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/notification_model.dart';
import 'package:chatkid_mobile/models/response_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class NotificationService {
  Future<PagingResponseModel<NotificationModel>> getNotifications(
      int pageNumber, int pageSize) async {
    final response = await BaseHttp.instance.get(
      endpoint: Endpoint.notificationEndPoint,
      param: {
        'page-number': pageNumber,
        'page-size': pageSize,
      },
    );
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      final data = jsonDecode(response.body);
      List<NotificationModel> listChat = (data['items'] as List<dynamic>)
          .map((item) => NotificationModel.fromJson(item))
          .toList();
      final pagingResponseModel = PagingResponseModel<NotificationModel>(
        pageSize: data['pageSize'],
        pageNumber: data['pageNumber'],
        totalItem: data['totalItem'],
        items: listChat,
      );
      return pagingResponseModel;
    }
    switch (response.statusCode) {
      case 401:
        LocalStorage.instance.clear();
        throw Exception('Lỗi không thể xác thực người dùng, vui lòng thử lại!');
      case 403:
        LocalStorage.instance.clear();
        throw Exception(
            'Bạn không có quyền truy cập vào ứng dụng, vui lòng liên hệ với quản trị viên!');
      case 404:
        LocalStorage.instance.clear();
        throw Exception('Không tìm thấy thông báo, vui lòng thử lại!');
      default:
        throw Exception('Không thể lấy thông báo, vui lòng thử lại!');
    }
  }
}

class NotificationController extends GetxController {
  RxList<NotificationModel> data = <NotificationModel>[].obs;
  Rx<bool> loading = false.obs;
  Rx<bool> isLoadMore = true.obs;
  int _pageNumber = 0;

  @override
  void onInit() {
    fetchData(0);
    super.onInit();
  }

  fetchData(int pageIdx) async {
    Logger().i("Fetching data");
    _pageNumber = pageIdx;
    loading.value = true;

    await NotificationService().getNotifications(pageIdx, 10).then((value) {
      if (pageIdx > 0) {
        data.addAll(value.items);
        isLoadMore.value = value.totalItem > data.length + value.items.length;
      } else {
        data.value = value.items;
        isLoadMore.value = value.totalItem > value.items.length;
      }
    }).whenComplete(() => loading.value = false);
  }

  fetchMore() async {
    if (!isLoadMore.value || loading.value) {
      Logger().i("No more data ${data.length}");
      return;
    }

    fetchData(_pageNumber + 1);
  }
}
