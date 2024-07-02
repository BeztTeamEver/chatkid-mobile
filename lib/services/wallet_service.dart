import 'dart:async';

import 'package:chatkid_mobile/services/user_service.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:get/get.dart';

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
}
