import 'package:chatkid_mobile/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateProvider<UserModel>((ref) => UserModel());
