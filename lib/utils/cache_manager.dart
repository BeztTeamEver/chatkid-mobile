import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;

class CustomCacheManager {
  static const key = 'cache_manager';
  static CacheManager instance = CacheManager(Config(
    key,
    stalePeriod: const Duration(days: 7),
    maxNrOfCacheObjects: 20,
    fileService: HttpFileService(
      httpClient: http.Client(),
    ),
  ));
}
