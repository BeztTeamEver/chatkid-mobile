import 'dart:async';
import 'dart:convert';

import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/wallet_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:chatkid_mobile/services/user_service.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/toast.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class WalletController extends GetxController {
  Rx<int> diamond = 0.obs;
  Rx<int> coin = 0.obs;

  Rx<String> memberId = (LocalStorage.instance.getUser().id ?? '').obs;

  @override
  void onInit() {
    super.onInit();
    refetchWallet();
  }

  refetchWallet() {
    UserService().getUser(memberId.value).then((value) {
      diamond.value = value.diamond ?? 0;
      coin.value = value.coin ?? 0;
    });
  }

  transferDiamond(TransferDiamondPayloadModel data, Function() callback) async {
    if (data.diamond == 0) {
      ShowToast.error(msg: "Số lượng kim cương phải lớn hơn 0!");
      return;
    }

    final response = await BaseHttp.instance.patch(
      endpoint: Endpoint.transferDiamondEndpoint,
      body: data.toJson(),
    );

    if (response.statusCode == 200) {
      refetchWallet();
      ShowToast.success(
          msg:
              "${data.diamond > 0 ? "Chuyển" : "Rút"} kim cương thành công 🎉");
      callback();
    } else {
      ShowToast.error(
          msg:
              "${data.diamond > 0 ? "Chuyển" : "Rút"}  kim cương thất bại, vui lòng thử lại sau");
    }
  }
}
