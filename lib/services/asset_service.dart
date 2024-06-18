import 'dart:convert';

import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/bot_asset_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:logger/logger.dart';

class BotAssetService {
  Future<BotAssetTypeModel> getBotAssets() async {
    final response = await BaseHttp.instance.get(
      endpoint: Endpoint.botAssetEndPoint,
    );
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      dynamic data = jsonDecode(response.body);
      BotAssetTypeModel result = BotAssetTypeModel.fromJson(data);
      List<BotAssetModel> newBackgroundList = [];

      result.background?.forEach((element) {
        if (newBackgroundList.isNotEmpty &&
            newBackgroundList.last.position != element.position) {
          BotAssetModel newElement = BotAssetModel(
            id: element.id,
            createdAt: element.createdAt,
            updatedAt: element.updatedAt,
            position: -1,
            imageUrl: element.imageUrl,
            previewImageUrl: element.previewImageUrl,
            name: element.name,
            type: element.type,
            status: element.status,
            price: element.price,
          );
          newElement.position = -1;
          newBackgroundList.add(newElement);
        }
        newBackgroundList.add(element);
      });
      result.background = newBackgroundList;
      return result;
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
        throw Exception('Không tìm thấy trang phục, vui lòng thử lại!');
      default:
        throw Exception(
            'Không thể lấy thông tin trang phục, vui lòng thử lại!');
    }
  }

  Future<List<BotAssetModel>> getCurrentSkin() async {
    final response = await BaseHttp.instance.get(
      endpoint: Endpoint.botAssetSelectedEndPoint,
    );
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      List data = jsonDecode(response.body);
      final result = data.map((res) => BotAssetModel.fromJson(res)).toList();
      return result;
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
        throw Exception('Không tìm thấy trang phục, vui lòng thử lại!');
      default:
        throw Exception(
            'Không thể lấy thông tin trang phục, vui lòng thử lại!');
    }
  }

  Future<BotAssetTypeModel> getStoreAsset() async {
    final response = await BaseHttp.instance.get(
      endpoint: Endpoint.storeAssetEndPoint,
    );
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      dynamic data = jsonDecode(response.body);
      BotAssetTypeModel result = BotAssetTypeModel.fromJson(data);
      BotAssetModel dividerElement = BotAssetModel(
        id: '',
        createdAt: '',
        updatedAt: '',
        position: -1,
        imageUrl: '',
        previewImageUrl: '',
        name: '',
        type: '',
        status: '',
        price: 0,
      );
      List<BotAssetModel> newAssetList = [];

      // emoji
      result.emoji = [...(result.ears ?? []), ...(result.emoji ?? [])];
      newAssetList = [];
      result.emoji?.forEach((element) {
        newAssetList.add(element);
        final int index = (result.emoji?.indexOf(element) ?? 1) + 1;
        if (index % 3 == 0 || index == result.emoji?.length) {
          newAssetList.add(dividerElement);
        }
      });
      result.emoji = newAssetList;

      // cloak
      newAssetList = [];
      result.cloak?.forEach((element) {
        newAssetList.add(element);
        final int index = (result.cloak?.indexOf(element) ?? 1) + 1;
        if (index % 3 == 0 || index == result.cloak?.length) {
          newAssetList.add(dividerElement);
        }
      });
      result.cloak = newAssetList;

      // eyes
      newAssetList = [];
      result.eyes?.forEach((element) {
        newAssetList.add(element);
        final int index = (result.eyes?.indexOf(element) ?? 1) + 1;
        if (index % 3 == 0 || index == result.eyes?.length) {
          newAssetList.add(dividerElement);
        }
      });
      result.eyes = newAssetList;

      // hat
      newAssetList = [];
      result.hat?.forEach((element) {
        newAssetList.add(element);
        final int index = (result.hat?.indexOf(element) ?? 1) + 1;
        if (index % 3 == 0 || index == result.hat?.length) {
          newAssetList.add(dividerElement);
        }
      });
      result.hat = newAssetList;

      // necklace
      newAssetList = [];
      result.necklace?.forEach((element) {
        newAssetList.add(element);
        final int index = (result.necklace?.indexOf(element) ?? 1) + 1;
        if (index % 3 == 0 || index == result.necklace?.length) {
          newAssetList.add(dividerElement);
        }
      });
      result.necklace = newAssetList;

      // background
      newAssetList = [];
      result.background?.forEach((element) {
        newAssetList.add(element);
        final int index = (result.background?.indexOf(element) ?? 1) + 1;
        if (index % 3 == 0 || index == result.background?.length) {
          newAssetList.add(dividerElement);
        }
      });
      result.background = newAssetList;

      return result;
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
        throw Exception('Không tìm thấy trang phục, vui lòng thử lại!');
      default:
        throw Exception(
            'Không thể lấy thông tin trang phục, vui lòng thử lại!');
    }
  }

  Future<List<BotAssetModel>> selectAssetItem(String id, String status) async {
    final endpoint = status == "Equipped"
        ? Endpoint.unselectBotAssetEndPoint
        : Endpoint.selectBotAssetEndPoint;
    final response = await BaseHttp.instance.patch(
      endpoint: endpoint.replaceFirst("{id}", id),
    );
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      List data = jsonDecode(response.body);
      final result = data.map((res) => BotAssetModel.fromJson(res)).toList();
      return result;
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
        throw Exception('Không tìm thấy trang phục, vui lòng thử lại!');
      default:
        throw Exception(
            'Không thể lấy thông tin trang phục, vui lòng thử lại!');
    }
  }

  Future<BotAssetTypeModel> buySkin(String id) async {
    final response = await BaseHttp.instance.patch(
      endpoint: Endpoint.buyBotAssetEndPoint.replaceFirst("{id}", id),
    );
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      dynamic data = jsonDecode(response.body);
      BotAssetTypeModel result = BotAssetTypeModel.fromJson(data);
      BotAssetModel dividerElement = BotAssetModel(
        id: '',
        createdAt: '',
        updatedAt: '',
        position: -1,
        imageUrl: '',
        previewImageUrl: '',
        name: '',
        type: '',
        status: '',
        price: 0,
      );
      List<BotAssetModel> newAssetList = [];

      // emoji
      result.emoji = [...(result.ears ?? []), ...(result.emoji ?? [])];
      newAssetList = [];
      result.emoji?.forEach((element) {
        newAssetList.add(element);
        final int index = (result.emoji?.indexOf(element) ?? 1) + 1;
        if (index % 3 == 0 || index == result.emoji?.length) {
          newAssetList.add(dividerElement);
        }
      });
      result.emoji = newAssetList;

      // cloak
      newAssetList = [];
      result.cloak?.forEach((element) {
        newAssetList.add(element);
        final int index = (result.cloak?.indexOf(element) ?? 1) + 1;
        if (index % 3 == 0 || index == result.cloak?.length) {
          newAssetList.add(dividerElement);
        }
      });
      result.cloak = newAssetList;

      // eyes
      newAssetList = [];
      result.eyes?.forEach((element) {
        newAssetList.add(element);
        final int index = (result.eyes?.indexOf(element) ?? 1) + 1;
        if (index % 3 == 0 || index == result.eyes?.length) {
          newAssetList.add(dividerElement);
        }
      });
      result.eyes = newAssetList;

      // hat
      newAssetList = [];
      result.hat?.forEach((element) {
        newAssetList.add(element);
        final int index = (result.hat?.indexOf(element) ?? 1) + 1;
        if (index % 3 == 0 || index == result.hat?.length) {
          newAssetList.add(dividerElement);
        }
      });
      result.hat = newAssetList;

      // necklace
      newAssetList = [];
      result.necklace?.forEach((element) {
        newAssetList.add(element);
        final int index = (result.necklace?.indexOf(element) ?? 1) + 1;
        if (index % 3 == 0 || index == result.necklace?.length) {
          newAssetList.add(dividerElement);
        }
      });
      result.necklace = newAssetList;

      // background
      newAssetList = [];
      result.background?.forEach((element) {
        newAssetList.add(element);
        final int index = (result.background?.indexOf(element) ?? 1) + 1;
        if (index % 3 == 0 || index == result.background?.length) {
          newAssetList.add(dividerElement);
        }
      });
      result.background = newAssetList;

      return result;
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
        throw Exception('Không tìm thấy trang phục, vui lòng thử lại!');
      default:
        throw Exception(
            'Mua trang phục không thành công, vui lòng thử lại sau!');
    }
  }
}
