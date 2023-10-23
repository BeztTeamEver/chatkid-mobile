import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getStepProvider = Provider((ref) {
  final step = LocalStorage.instance.preferences.get('step');
  return step;
});

final saveStepProvider = Provider.family(
  (ref, int currentStep) {
    final step = LocalStorage.instance.preferences.setInt('step', currentStep);
    return step;
  },
);
