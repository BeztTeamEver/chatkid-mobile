import 'dart:convert';

import 'package:chatkid_mobile/models/file_model.dart';
import 'package:chatkid_mobile/services/file_service.dart';
import 'package:chatkid_mobile/utils/error_snackbar.dart';
import 'package:chatkid_mobile/widgets/avatar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final getAvatarProvider = FutureProvider((ref) async {
  final result = await FileService().getAvatars();
  Logger().i(jsonEncode(result));
  return result;
});
